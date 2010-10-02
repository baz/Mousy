//
//  AccelerationWindowController.h
//  Mousy
//
//  Created by Basil Shkara on 22/08/09.
//  Copyright 2009 Oiled Machine Pty Ltd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MouseInterface.h"
#import "AccelerationWindowController.h"


@interface AccelerationWindowController : NSWindowController {
	IBOutlet NSSlider *slider_;
	IBOutlet NSTextField *textField_;
	MouseInterface *mouseInterface_;
	CGFloat accelerationValue_;
}

@property (nonatomic, retain) NSSlider *slider;
@property (nonatomic, retain) NSTextField *textField;
@property (nonatomic, retain) MouseInterface *mouseInterface;
@property (nonatomic, assign) CGFloat accelerationValue;

- (IBAction)updateMouseSpeed:(id)sender;
- (IBAction)setMouseSpeedAsDefault:(id)sender;
- (IBAction)incrementMouseSpeed:(id)sender;
- (IBAction)decrementMouseSpeed:(id)sender;

@end
