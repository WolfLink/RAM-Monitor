//
//  WindowController.m
//  RAM Monitor
//
//  Created by Marc Davis on 10/27/13.
//  Copyright (c) 2013 Marc Davis. All rights reserved.
//

#import "WindowController.h"
#import <sys/sysctl.h>
#import <mach/host_info.h>
#import <mach/mach_host.h>
#import <mach/task_info.h>
#import <mach/task.h>

@interface WindowController ()

@end

@implementation WindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        }
    return self;
}
- (void)windowDidLoad
{
    [super windowDidLoad];
}
-(void)setUpdateSpeed:(id)sender {
    
}
@end
