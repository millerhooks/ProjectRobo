//
//  NetworkClientController.h
//  Hello World
//
//  Created by mewp on 2/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <CFNetwork/CFSocketStream.h>
#import "NSStreamAdditions.h"

@interface NetworkClientController : NSObject {
	NSString *hostAddress;
	uint port;
	NSMutableData *data;
	
	NSInputStream *iStream;
	NSOutputStream *oStream;
	BOOL connected;
}

-(id)  initWithHost: (NSString *)urlStr portNo: (uint) portNo;
-(void) connect;
-(void) connectToServerUsingStream:(NSString *)urlStr portNo: (uint) portNo;
-(void) connectToServerUsingCFStream:(NSString *) urlStr portNo: (uint) portNo;
-(void) writeToServer:(const uint8_t *) buf;
-(void) writeStringToServer:(NSString *) buf;
-(void) disconnect;


@end
