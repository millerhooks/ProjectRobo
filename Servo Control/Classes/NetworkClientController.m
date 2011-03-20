//
//  NetworkClientController.m
//  Hello World
//
//  Created by mewp on 2/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NetworkClientController.h"


@implementation NetworkClientController

CFReadStreamRef readStream = NULL;
CFWriteStreamRef writeStream = NULL;

-(id)  initWithHost: (NSString *)host
			 portNo: (uint) portNo {
	if (self = [super init]) {
		
		port = portNo;
		hostAddress = [host copy];
		[self connectToServerUsingStream: host portNo: portNo];
	}
	return self;
}
	
-(void) connect {
	[self connectToServerUsingStream: hostAddress portNo: port];
}

-(void) writeToServer:(const uint8_t *) buf {
    [oStream write:buf maxLength:strlen((char*)buf)];    
}

-(void) writeStringToServer:(NSString *) buf {
    const uint8_t *str = (uint8_t *) [buf cStringUsingEncoding:NSASCIIStringEncoding];
	
	[self writeToServer:str];
}

-(void) disconnect {
    [iStream close];
    [oStream close];
	connected = false;
}

-(void) connectToServerUsingStream:(NSString *)urlStr 
                            portNo: (uint) portNo {
	if (!connected) {
		if (![urlStr isEqualToString:@""]) {
			NSURL *website = [NSURL URLWithString:urlStr];
			if (!website) {
				NSLog(@"%@ is not a valid URL");
				return;
			} else {
				[NSStream getStreamsToHostNamed:urlStr 
										   port:portNo 
									inputStream:&iStream
								   outputStream:&oStream];            
				[iStream retain];
				[oStream retain];
				
				[iStream setDelegate:self];
				[oStream setDelegate:self];
				
				[iStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
								   forMode:NSDefaultRunLoopMode];
				[oStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
								   forMode:NSDefaultRunLoopMode];
				
				[oStream open];
				[iStream open]; 
				connected = true;
				
				NSLog(@"Connected");
				
			}
		}    
	}
	else {
		NSLog(@"Already Connected");
		
	}
	
	
}

-(void) connectToServerUsingCFStream:(NSString *) urlStr portNo: (uint) portNo {
	
    CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, 
                                       (CFStringRef) urlStr, 
                                       portNo, 
                                       &readStream, 
                                       &writeStream);
    
    if (readStream && writeStream) {
        CFReadStreamSetProperty(readStream,
                                kCFStreamPropertyShouldCloseNativeSocket, 
                                kCFBooleanTrue);
        CFWriteStreamSetProperty(writeStream, 
								 kCFStreamPropertyShouldCloseNativeSocket, 
								 kCFBooleanTrue);
        
        iStream = (NSInputStream *)readStream;
        [iStream retain];
        [iStream setDelegate:self];
        [iStream scheduleInRunLoop:[NSRunLoop currentRunLoop] 
						   forMode:NSDefaultRunLoopMode];
        [iStream open];
        
        oStream = (NSOutputStream *)writeStream;
        [oStream retain];
        [oStream setDelegate:self];
        [oStream scheduleInRunLoop:[NSRunLoop currentRunLoop] 
						   forMode:NSDefaultRunLoopMode];
        [oStream open];         
    }
}

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode {
    
    switch(eventCode) {
        case NSStreamEventHasBytesAvailable:
        {
            if (data == nil) {
                data = [[NSMutableData alloc] init];
            }
            uint8_t buf[1024];
            unsigned int len = 0;
            len = [(NSInputStream *)stream read:buf maxLength:1024];
            if(len) {    
                [data appendBytes:(const void *)buf length:len];
                int bytesRead;
                bytesRead += len;
            } else {
                NSLog(@"No data.");
            }
            
            NSString *str = [[NSString alloc] initWithData:data 
												  encoding:NSUTF8StringEncoding];
            NSLog(str);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"From server" 
                                                            message:str 
                                                           delegate:self 
                                                  cancelButtonTitle:@"OK" 
                                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
			
            [str release];
            [data release];        
            data = nil;
        } break;
    }
}

- (void)dealloc {
	[self disconnect];
    
    [iStream release];
    [oStream release];
    
    if (readStream) CFRelease(readStream);
    if (writeStream) CFRelease(writeStream);
	
    [hostAddress release];
    [super dealloc];
}

@end
