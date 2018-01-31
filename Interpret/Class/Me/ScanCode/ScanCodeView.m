
//
//  ScanCodeView.m
//  NewTest
//
//  Created by 乔杰 on 2018/1/26.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "ScanCodeView.h"

@interface ScanCodeView ()

@property (nonatomic, assign) CGFloat cornerRedius;

@end

@implementation ScanCodeView

- (void)drawRect:(CGRect)rect {

    //创建路径并获取句柄
    CGMutablePathRef path = CGPathCreateMutable();
    //将矩形添加到路径中
    CGPathAddRect(path,NULL, rect);
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //将路径添加到上下文
    CGContextAddPath(context, path);
    //设置矩形填充色
    [[UIColor clearColor] setFill];
    //矩形边框颜色
    [[UIColor whiteColor] setStroke];
    //边框宽度
    CGContextSetLineWidth(context, 2.0f);
    //绘制
    CGContextDrawPath(context, kCGPathFillStroke);
    CGPathRelease(path);
    
    self.cornerRedius = 20;
    [self addCornerRedis: rect context: context];
}


- (void)addCornerRedis:(CGRect)rect context:(CGContextRef)context {
 
    for (int index = 1; index < 5; index ++) {
        
        CGPoint point = CGPointMake(rect.origin.x + rect.size.width * ((index - 1) %2), rect.origin.y + rect.size.height * ((index - 1)/2)  - (index %2));
       
        CGContextMoveToPoint(context, point.x, point.y);
        CGContextSetLineWidth(context, 5.0f);
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        
        if (index%2 == 0) {
            //横线
            CGContextAddLineToPoint(context, point.x - self.cornerRedius, point.y);
            CGContextStrokePath(context);
            //竖线
            CGContextMoveToPoint(context, point.x, point.y);
            CGContextAddLineToPoint(context, point.x, point.y + self.cornerRedius * (3 - index));
            CGContextStrokePath(context);
        }else {
            //横线
            CGContextAddLineToPoint(context, point.x + self.cornerRedius, point.y);
            CGContextStrokePath(context);
            //竖线
            CGContextMoveToPoint(context, point.x, point.y);
            CGContextAddLineToPoint(context, point.x, point.y + self.cornerRedius * (2 - index));
            CGContextStrokePath(context);
        }
    }
 }


@end
