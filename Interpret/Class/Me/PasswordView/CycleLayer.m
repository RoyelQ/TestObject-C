//
//  CycleLayer.m
//  NewTest
//
//  Created by 乔杰 on 2018/1/22.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "CycleLayer.h"

@implementation CycleLayer

- (void)drawInContext:(CGContextRef)ctx {
   
    if (self.isSelected) {

        [self cycleSelected: ctx];

    }else {
        [self cycleNormal: ctx];
    }
}

- (void)cycleNormal:(CGContextRef)ctx {

    CGContextAddEllipseInRect(ctx, CGRectMake(1, 1, self.bounds.size.width - 2, self.bounds.size.width - 2));
    CGContextSetLineWidth(ctx, 1);
    CGContextSetStrokeColorWithColor(ctx, Cycle_Line_color.CGColor);
    CGContextSetFillColorWithColor(ctx, [UIColor clearColor].CGColor);
    CGContextDrawPath(ctx, kCGPathFill | kCGPathFillStroke);
}

- (void)cycleSelected:(CGContextRef)ctx {

    [self cycleNormal: ctx];
    CGContextAddEllipseInRect(ctx, CGRectMake(self.bounds.size.width/3.0, self.bounds.size.width/3.0, self.bounds.size.width/3.0, self.bounds.size.width/3.0));
    CGContextSetStrokeColorWithColor(ctx, Cycle_Line_color.CGColor);
    CGContextSetFillColorWithColor(ctx, Cycle_Line_color.CGColor);
    CGContextDrawPath(ctx, kCGPathFill | kCGPathFillStroke);
}

@end
