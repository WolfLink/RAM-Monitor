//
//  WindowController.h
//  RAM Monitor
//
//  Created by Marc Davis on 10/27/13.
//  Copyright (c) 2013 Marc Davis. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "pieChartView.h"

@interface WindowController : NSWindowController {
    IBOutlet pieChartView *ChartView;
}

@end
