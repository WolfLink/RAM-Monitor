//
//  AppDelegate.m
//  RAM Monitor
//
//  Created by Marc Davis on 10/27/13.
//  Copyright (c) 2013 Marc Davis. All rights reserved.
//

#import "AppDelegate.h"
#import "WindowController.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self.window setAspectRatio:CGSizeMake(1, 1)];
    //WindowController *mainWindowController = [[WindowController alloc] initWithWindow:self.window];
}

@end
