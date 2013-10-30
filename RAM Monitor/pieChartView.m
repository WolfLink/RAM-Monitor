//
//  pieChartView.m
//  RAM Monitor
//
//  Created by Marc Davis on 10/27/13.
//  Copyright (c) 2013 Marc Davis. All rights reserved.
//

#import "pieChartView.h"

@implementation pieChartView

const CGRect frameRect = {{0.0f,0.0f},{512.0f,512.0f}};
const CGPoint center = {256.0f,256.0f};
const int radius = 170;


- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self startTick];
    }
    return self;
}
-(void)awakeFromNib {
    [self startTick];
}
-(void)checkSettings {
    FILE *file;
    file = fopen("settings.txt","r");
    if (file) {
        
    }
    else {
        NSLog(@"Writing default settings file...");
        file = fopen("settings.txt", "w");
        
    }
    fclose(file);
}
-(void)startTick {
    //[self checkSettings];
    tickTock = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(updateDatas) userInfo:nil repeats:YES];
    [self updateDatas];
}
- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
    float lastAngle = 90;
    float nextAngle = 90-360*wired;
    NSImage *image = [[NSImage alloc] initWithSize:NSSizeFromCGSize(frameRect.size)];
    [image lockFocus];
    NSBezierPath *path = [[NSBezierPath alloc] init];
    [path moveToPoint: center];
    [path appendBezierPathWithArcWithCenter:center radius:radius startAngle:lastAngle endAngle:nextAngle clockwise:YES];
    [path lineToPoint:center];
    [path closePath];
    
    [[NSColor colorWithRed:1 green:0 blue:0 alpha:1] set];
    [path stroke];
    [path fill];
    
    path = [[NSBezierPath alloc] init];
    [path moveToPoint: center];
    lastAngle = nextAngle;
    nextAngle = lastAngle-360*active;
    [path appendBezierPathWithArcWithCenter:center radius:radius startAngle:lastAngle endAngle:nextAngle clockwise:YES];
    [path lineToPoint:center];
    [path closePath];
    
    [[NSColor colorWithRed:1 green:1 blue:0 alpha:1] set];
    [path stroke];
    [path fill];
    
    path = [[NSBezierPath alloc] init];
    [path moveToPoint: center];
    lastAngle = nextAngle;
    nextAngle = lastAngle-360*inactive;
    [path appendBezierPathWithArcWithCenter:center radius:radius startAngle:lastAngle endAngle:nextAngle clockwise:YES];
    [path lineToPoint:center];
    [path closePath];
    
    [[NSColor colorWithRed:0 green:0 blue:1 alpha:1] set];
    [path stroke];
    [path fill];
    
    path = [[NSBezierPath alloc] init];
    [path moveToPoint: center];
    lastAngle = nextAngle;
    nextAngle = lastAngle-360*free;
    
    //nextAngle should be -270.  If it isn't, there is some kind of error (probably a rounding error).  If it isn't small, it is problem.  I'm going to assume there is no problem and draw the arc to 90 to complete the full angle in case there is a rounding error big enough to make a difference.
    if (nextAngle != -270) {
        NSLog(@"Error factor: %f", nextAngle+270);
    }
    [path appendBezierPathWithArcWithCenter:center radius:radius startAngle:lastAngle endAngle:90 clockwise:YES];
    [path lineToPoint:center];
    [path closePath];
    
    [[NSColor colorWithRed:0 green:1 blue:0 alpha:1] set];
    [path stroke];
    [path fill];
    
    [image unlockFocus];
    [image drawInRect:dirtyRect];
    [[NSApplication sharedApplication] setApplicationIconImage:image];
	
}
-(void)updateDatas{
    int mib[6];
    int pagesize;
    size_t length;
    mib[0] = CTL_HW;
    mib[1] = HW_PAGESIZE;
    length = sizeof (pagesize);
    if (sysctl (mib, 2, &pagesize, &length, NULL, 0) < 0)
    {
        fprintf (stderr, "getting page size");
    }
    
    mach_msg_type_number_t count = HOST_VM_INFO_COUNT;
    
    vm_statistics_data_t vmstat;
    if (host_statistics (mach_host_self (), HOST_VM_INFO, (host_info_t) &vmstat, &count) != KERN_SUCCESS)
    {
        fprintf (stderr, "Failed to get VM statistics.");
    }
    
    double total = vmstat.wire_count + vmstat.active_count + vmstat.inactive_count + vmstat.free_count;
    wired = vmstat.wire_count / total;
    active = vmstat.active_count / total;
    inactive = vmstat.inactive_count / total;
    free = vmstat.free_count / total;
    
    /*float percentWired = wired*100;
    float percentActive = active*100;
    float percentInactive = inactive*100;
    float percentFree = free*100;*/
    //float shouldBe100 = percentActive+percentFree+percentInactive+percentWired;
    
    [self setNeedsDisplay:YES];
}

@end
