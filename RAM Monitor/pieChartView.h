//
//  pieChartView.h
//  RAM Monitor
//
//  Created by Marc Davis on 10/27/13.
//  Copyright (c) 2013 Marc Davis. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <sys/sysctl.h>
#import <mach/host_info.h>
#import <mach/mach_host.h>
#import <mach/task_info.h>
#import <mach/task.h>

@interface pieChartView : NSView {
    CGPoint center;
    float radius;
    NSTimer *tickTock;
    double wired;
    double active;
    double inactive;
    double free;
}
-(void)startTick;
@end
