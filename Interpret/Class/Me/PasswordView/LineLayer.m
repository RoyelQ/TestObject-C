
//
//  LineLayer.m
//  NewTest
//
//  Created by 乔杰 on 2018/1/22.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "LineLayer.h"

@implementation LineLayer


- (void)drawInContext:(CGContextRef)ctx {
    
    if (!self.passwordView.isTracking) {
        return;
    }
    NSArray *selectedIndexArr = self.passwordView.passwordIndexArr;
    
    CGPoint point = [self getPoint: [selectedIndexArr[0] integerValue]];
    CGContextSetStrokeColorWithColor(ctx, Cycle_Line_color.CGColor);
    CGContextSetLineWidth(ctx, 1.0);
    CGContextMoveToPoint(ctx, point.x, point.y);
    
    for (int i = 1; i < selectedIndexArr.count; i ++) {
        
        CGPoint point = [self getPoint: [selectedIndexArr[i] integerValue]];

        CGContextAddLineToPoint(ctx, point.x, point.y);
    }
    
    point = self.passwordView.currentFingerPoint;
    
    CGContextAddLineToPoint(ctx, point.x, point.y);

    CGContextDrawPath(ctx, kCGPathStroke);
}


- (CGPoint)getPoint:(NSInteger)number {
    
    float col = ([UIScreen mainScreen].bounds.size.width - cycle_width * 3)/4.0;

    float x = col + (col + cycle_width) * (number%3) + cycle_width/2.0;
    
    float y = (cycle_raw + cycle_width) * (number/3) + cycle_width/2.0;
    
    return CGPointMake(x, y);
}

@end
