//
//  Hello_WorldAppDelegate.m
//  Hello World
//
//  Created by mewp on 2/2/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "Hello_WorldAppDelegate.h"
#import "TouchViewController.h"

@implementation Hello_WorldAppDelegate

@synthesize myViewController;
//@synthesize touchView;
@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	
	TouchViewController *aViewController = [[TouchViewController alloc]
									  initWithNibName:@"TouchViewController" bundle:[NSBundle mainBundle]];
	
	[self setMyViewController:aViewController];
	[aViewController release];
	
	UIView *controllersView = [myViewController view];
	[window addSubview:controllersView];
	
	[window makeKeyAndVisible];
    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


- (void)dealloc {
	[myViewController release];
    [window release];
    [super dealloc];
}


@end
