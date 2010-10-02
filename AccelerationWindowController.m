//
//  AccelerationWindowController.m
//  Mousy
//
//  Created by Basil Shkara on 22/08/09.
//  Copyright 2009 Oiled Machine Pty Ltd. All rights reserved.
//
//  Note: This is basically SetMouseAcclSample from Apple.
//  http://developer.apple.com/Samplecode/SetMouseAcclSample/index.html
//

#import "AccelerationWindowController.h"

// Amount divided by 10 as increment/decrement amount
static NSUInteger kStandardIncrement = 1;
// Corresponds to the maximum setting for the slider in the nib file
static NSUInteger kMaxSpeedSetting = 4;


@implementation AccelerationWindowController

@synthesize slider = slider_;
@synthesize textField = textField_;
@synthesize mouseInterface = mouseInterface_;
@synthesize accelerationValue = accelerationValue_;


- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];

	[self setSlider:nil];
	[self setTextField:nil];
	[self setMouseInterface:nil];
	[super dealloc];
}

- (void)awakeFromNib {
	MouseInterface *mouseInterface = [[MouseInterface alloc] init];
	self.mouseInterface = mouseInterface;
	[mouseInterface release];

	// Store the original value to restore if needed
	self.accelerationValue = [self.mouseInterface mouseDefaultSpeed];

	// Promote original values into View
	[self.slider setFloatValue:self.accelerationValue];
	[self.textField setFloatValue:self.accelerationValue];

	// Register for notifications
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(windowDidBecomeKey:)
												 name:NSWindowDidBecomeKeyNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(windowDidResignActive:)
												 name:NSWindowDidResignMainNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(applicationWillTerminate:)
												 name:NSApplicationWillTerminateNotification object:nil];
}

// User wants to set the currently selected acceleration value as the default
- (IBAction)setMouseSpeedAsDefault:(id)sender {
	self.accelerationValue = [self.slider floatValue];
}

- (IBAction)updateMouseSpeed:(id)sender {
	// Read the current mouse value from the slider
	CGFloat value = [self.slider floatValue];

	// Set the text value of the mouse setting in the window
	[self.textField setFloatValue:value];

	// Set this value as the mouse speed
	[self.mouseInterface setMouseSpeed:value];
}

- (IBAction)incrementMouseSpeed:(id)sender {
	CGFloat value = [self.slider floatValue] * 10 + kStandardIncrement + 0.1;
	NSInteger newValue = value;
	value = newValue;
	value = value / 10;	// cannot use value = newValue / 10, since (newValue / 10) will force integer math
	if (value > kMaxSpeedSetting) {
		value = kMaxSpeedSetting;
	}
	[self.slider setFloatValue:value];
	[self.textField setFloatValue:value];
	[self.mouseInterface setMouseSpeed:value];
}

- (IBAction)decrementMouseSpeed:(id)sender {
	CGFloat value = [self.slider floatValue] * 10 - kStandardIncrement + 0.1;
	NSInteger newValue = value;
	if (newValue < 0) {
		newValue = 0;
	}
	value = newValue;
	value = value / 10;	// cannot use value = newValue / 10, since (newValue / 10) will force integer math
	[self.slider setFloatValue:value];
	[self.textField setFloatValue:value];
	[self.mouseInterface setMouseSpeed:value];
}

#pragma mark -
#pragma mark Observer methods

// Restore the mouse acceleration setting to whatever is in slider
- (void)windowDidBecomeKey:(NSNotification *)aNotification {
	CGFloat value = [self.slider floatValue];
	[self.textField setFloatValue:value];
	[self.mouseInterface setMouseSpeed:value];
}

// Restore the mouse acceleration setting to whatever the original value was
- (void)windowDidResignActive:(NSNotification *)aNotification {
	[self.mouseInterface setMouseSpeed:self.accelerationValue];
}

// Restore the mouse acceleration setting to whatever the original value was
- (void)applicationWillTerminate:(NSNotification *)aNotification {
	[self.mouseInterface setMouseSpeed:self.accelerationValue];
}


@end
