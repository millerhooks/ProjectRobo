//
//  MyViewControlly.m
//  Hello World
//
//  Created by mewp on 2/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TouchViewController.h"


@implementation TouchViewController

@synthesize textField;
@synthesize label;
@synthesize image;
@synthesize slider;
@synthesize string;


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
 }
 return self;
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	NSLog(@"Trying..");
	connection = [[NetworkClientController alloc] initWithHost: @"10.0.1.198" portNo:5204];
	
    [super viewDidLoad];
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == textField) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (IBAction)changeGreeting:(id)sender {
	// Reconnect?
	
	[connection disconnect];
	
	[connection	connect];
	
	self.string = textField.text;
	
	const uint8_t *str = (uint8_t *) [string cStringUsingEncoding:NSASCIIStringEncoding];
	
	[connection writeToServer:str];
	
	NSString *nameString = string;
    if ([nameString length] == 0) {
        nameString = @"World";
    }
	
	NSString *greeting =[[NSString alloc] initWithFormat:@"Hello %@!", nameString];
	label.text = greeting;
	[greeting release];
}

- (IBAction)getButton:(id)sender {
	[connection writeStringToServer: [NSString stringWithFormat:@"\nGET\r"]];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[connection release];
    [textField release];
	[slider release];
    [label release];
    [string release];
    [super dealloc];
}

- (void)sendTouchesEvent:(NSSet *)touches withEvent:(UIEvent *)event {
	
	//		
	//	[connection writeStringToServer: [NSString stringWithFormat:@"<TOUCH><LOC>%1.0f,%1.0f</LOC><PLOC>%1.0f,%1.0f</PLOC><TAP>%i</TAP></TOUCH>", location.x, location.y, plocation.x, plocation.y, [touch tapCount]]];	
	//	[connection writeStringToServer: [NSString stringWithFormat:@"</TOUCHEVENT>"]];
	NSEnumerator *enumerator = [touches objectEnumerator];
	id touch;
	
	[connection writeStringToServer: [NSString stringWithFormat:@"\n"]];	// \n starts an event.
	
	CGRect screenBounds = [[self view] bounds];
	
	
	
	while ((touch = [enumerator nextObject])) {	
		CGPoint location = [touch locationInView:[self view]];
		//		CGPoint plocation = [touch previousLocationInView:[self view]];
		
		[connection writeStringToServer: [NSString stringWithFormat:@"\t<s%1.0f><e%1.0f><w%1.0f><c%i>", location.x/screenBounds.size.width*180, location.y/screenBounds.size.height*180, [slider value], [touch tapCount]*10]];
		// Aaaaactually, we're not going to handle 
		break;
	}	
	[connection writeStringToServer: [NSString stringWithFormat:@"\r"]];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	NSLog(@"touch event");
	// We only support single touches, so anyObject retrieves just that touch from touches	
	[self sendTouchesEvent:touches withEvent:event];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[self sendTouchesEvent:touches withEvent:event];
	//	[connection writeStringToServer: [NSString stringWithFormat:@"x: %1.2f y: %1.2f", location.x, location.y]];	
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	//[self sendTouchesEvent:touches withEvent:event];
	return;
	
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	
	/*
     To impose as little impact on the device as possible, simply set the placard view's center and transformation to the original values.
     */
}




@end
