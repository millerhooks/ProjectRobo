//
//  Hello_WorldAppDelegate.h
//  Hello World
//
//  Created by mewp on 2/2/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TouchViewController;

@interface Hello_WorldAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	TouchViewController *myViewController;
//	MyTouchViewController *touchView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) TouchViewController *myViewController;
//@property (nonatomic, retain) MyTouchViewController *touchView;
@end

