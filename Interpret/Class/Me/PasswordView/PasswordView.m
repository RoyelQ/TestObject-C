//
//  PasswordView.m
//  NewTest
//
//  Created by 乔杰 on 2018/1/22.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "PasswordView.h"

#import "LineLayer.h"

@interface PasswordView ()

@property (nonatomic, strong) NSMutableArray *cycleLayerArr;

@property (nonatomic, strong) LineLayer *pathLayer;

@end

@implementation PasswordView

- (instancetype)init {
    
    return [super initWithFrame: CGRectZero];
    
}
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame: frame];
    
    if (self) {
        self.cycleLayerArr = [[NSMutableArray alloc] init];
        
        self.passwordIndexArr = [[NSMutableArray alloc] init];
        
        [self setUpSubLayer];
    }
    return self;
}

- (void)setUpSubLayer {
    
    float col = ([UIScreen mainScreen].bounds.size.width - cycle_width * 3)/4.0;
    for (int i = 0; i < 9; i ++) {
        CycleLayer *layer = [CycleLayer layer];
        layer.frame = CGRectMake(col + (col + cycle_width) * (i%3), (cycle_width + cycle_raw) * (i/3), cycle_width, cycle_width);
        [layer setNeedsDisplay];
        [self.cycleLayerArr addObject: layer];
        [self.layer addSublayer: layer];
    }
    
    self.pathLayer = [LineLayer layer];
    self.pathLayer.passwordView = self;
    self.pathLayer.frame = self.bounds;
    [self.pathLayer setNeedsDisplay];
    [self.layer addSublayer: self.pathLayer];
}


- (void)reSetTrackingState {
    
    for (int i = 0; i < 9; i++) {
        CycleLayer *layer = self.cycleLayerArr[i];
        if (layer.isSelected == YES) {
            layer.isSelected = NO;
            [layer setNeedsDisplay];
        }
    }
    self.isTracking = NO;
    
    [self.passwordIndexArr removeAllObjects];
    self.pathLayer.frame = self.bounds;
    [self.pathLayer setNeedsDisplay];
}


#pragma mark - Touch 方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    self.isTracking = NO;
    
    UITouch* touch = [touches anyObject];
    
    self.currentFingerPoint = [touch locationInView:self];
    
    for (int i = 0; i < 9; i++) {
     
        CycleLayer *layer = self.cycleLayerArr[i];
        
        if ([self containPoint: self.currentFingerPoint inCircle: layer.frame]) {
            
            layer.isSelected = YES;
            [layer setNeedsDisplay];
            self.isTracking = YES;
            [self.passwordIndexArr addObject: [NSNumber numberWithInt: i]];
            break;
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesMoved:touches withEvent:event];

    if (self.isTracking) {
        
        UITouch* touch = [touches anyObject];
        
        self.currentFingerPoint = [touch locationInView: self];
        

        for (int i = 0; i < 9; i++) {
            
            CycleLayer *layer = self.cycleLayerArr[i];
            if ([self containPoint: self.currentFingerPoint inCircle: layer.frame] && layer.isSelected == NO) {
                layer.isSelected = YES;
                [layer setNeedsDisplay];
                self.isTracking = YES;
                [self.passwordIndexArr addObject: [NSNumber numberWithInt: i]];
                break;
            }
        }
    }
    [self.pathLayer setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesEnded:touches withEvent:event];
    
    [self reSetTrackingState];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesEnded:touches withEvent:event];
    
    [self reSetTrackingState];
}

#pragma mark - 判定Touch移动到layer内部

- (BOOL)containPoint:(CGPoint)point inCircle:(CGRect)rect
{
    CGPoint center = CGPointMake(rect.origin.x+rect.size.width/2, rect.origin.y+rect.size.height/2);
    
    BOOL isContain = ((center.x-point.x)*(center.x-point.x)+(center.y-point.y)*(center.y-point.y) - cycle_width*cycle_width/4.0) < 0;
  
    return isContain;
}


@end
