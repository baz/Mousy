//
//	MousyAppDelegate.h
//	Mousy
//
//	Created by Basil Shkara on 22/08/09.
//	Copyright 2009 Oiled Machine Pty Ltd. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class AccelerationWindowController;


@interface MousyAppDelegate : NSObject <NSApplicationDelegate> {
	AccelerationWindowController *windowController_;
}

@property (nonatomic, retain) AccelerationWindowController *windowController;

@end
