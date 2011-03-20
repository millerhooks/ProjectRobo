//
//  MyViewControlly.h
//  Hello World
//
//  Created by mewp on 2/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkClientController.h"

@interface TouchViewController : UIViewController <UITextFieldDelegate> {
	UITextField *textField;
	UILabel *label;
	UIImageView *image;
	NSString *string;
	UISlider	*slider;
	NetworkClientController *connection;
}

@property (nonatomic, retain) IBOutlet UITextField *textField;
@property (nonatomic, retain) IBOutlet UIImageView *image;
@property (nonatomic, retain) IBOutlet UILabel *label;

@property (nonatomic, retain) IBOutlet UISlider *slider;
@property (nonatomic, copy) NSString *string;

- (IBAction)changeGreeting:(id)sender;
- (IBAction)getButton:(id)sender;
- (void)sendTouchesEvent:(NSSet *)touches withEvent:(UIEvent *)event;

@end
