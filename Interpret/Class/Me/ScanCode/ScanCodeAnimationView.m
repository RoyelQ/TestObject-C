
//
//  ScanCodeAnimationView.m
//  NewTest
//
//  Created by 乔杰 on 2018/1/26.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "ScanCodeAnimationView.h"

#import "ScanCodeView.h"

#import "ScanCodeBackView.h"

@interface ScanCodeAnimationView ()

@property (nonatomic, strong) UIImageView *lineView;

@property (nonatomic, strong) NSTimer *mTimer;

@property (nonatomic, assign) CGPoint currentPosition;

@end

@implementation ScanCodeAnimationView

- (instancetype)init {
    
    return [super initWithFrame: CGRectZero];
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame: frame];
    
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {
    
    if (!self.lineView) {

        ScanCodeBackView *backView = [[ScanCodeBackView alloc] initWithFrame: self.bounds];
        backView.scanFrame = CGRectMake((SCREEN_WIDTH - ScanWidth)/2.0, ScanY, ScanWidth, ScanHeight);
        [self addSubview: backView];
        
        ScanCodeView *view = [[ScanCodeView alloc] initWithFrame: CGRectMake((SCREEN_WIDTH - ScanWidth)/2.0, ScanY, ScanWidth, ScanHeight)];
        view.backgroundColor = [UIColor clearColor];
        [self addSubview: view];
        
        self.lineView = [[UIImageView alloc] initWithFrame: CGRectMake((SCREEN_WIDTH - ScanWidth)/2.0, ScanY, ScanWidth, ScanWidth*60/654.0)];
        self.currentPosition = CGPointMake((SCREEN_WIDTH - ScanWidth)/2.0, ScanY);
        self.lineView.image = [UIImage imageNamed: @"line"];
        [self addSubview: self.lineView];
        
        self.mTimer = [NSTimer scheduledTimerWithTimeInterval: 0.01 target: self selector: @selector(lineAnimation) userInfo: nil repeats: YES];
        [[NSRunLoop currentRunLoop] addTimer: self.mTimer forMode: NSRunLoopCommonModes];
    }
}

- (void)lineAnimation {
    
    CGPoint newPosition = self.currentPosition;
    
    newPosition.y += 1;
    
    //判断y到达底部，从新开始下降
    if (newPosition.y > ScanHeight + ScanY - self.lineView.frame.size.height) {
        
        newPosition.y = ScanY;
    }
    //重新赋值position
    self.currentPosition = newPosition;
    
    CGRect frame = self.lineView.frame;
    frame.origin.y = self.currentPosition.y;
    [UIView animateWithDuration:0.01 animations:^{
        
        self.lineView.frame = frame;
    }];
}

-(void)startAnimaion {
    
    [self.mTimer setFireDate:[NSDate date]];
}

-(void)stopAnimaion {
    
    [self.mTimer setFireDate:[NSDate distantFuture]];
}

- (void)dealloc {
    
    [self.mTimer setFireDate:[NSDate distantFuture]];
    
    self.mTimer = nil;
}


@end
