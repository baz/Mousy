//
//  MousyAppDelegate.m
//  Mousy
//
//  Created by Basil Shkara on 22/08/09.
//  Copyright 2009 Oiled Machine Pty Ltd. All rights reserved.
//

#import "MousyAppDelegate.h"
#import "AccelerationWindowController.h"

@implementation MousyAppDelegate

@synthesize windowController = windowController_;


- (void)dealloc {
	[self setWindowController:nil];
	[super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	AccelerationWindowController *windowController = [[AccelerationWindowController alloc] initWithWindowNibName:@"MainWindow"];
	self.windowController = windowController;
	[windowController release];
}

// Quit the app if the window is closed
- (BOOL)windowShouldClose:(id)sender {
	[NSApp terminate:nil];
	return YES;
}


@end
