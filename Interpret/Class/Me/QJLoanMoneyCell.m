//
//  QJLoanMoneyCell.m
//  JHH
//
//  Created by jinrongweidian on 16/11/14.
//  Copyright © 2016年 金融微店. All rights reserved.
//

#import "QJLoanMoneyCell.h"
#import "AppMacro.h"
#import "HTColorHelper.h"
#import "NumberFormatter.h"

@interface QJLoanMoneyCell ()<UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;

@end

@implementation QJLoanMoneyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.loanMoneyLabel.font = [UIFont boldSystemFontOfSize:35];
    
    
    self.mScrollView.directionalLockEnabled = YES;
    
    self.loanMoneyLabel.text = [NumberFormatter formatterNumberToDecimal:[NSNumber numberWithInteger:100000]];
    
    self.loanCount = 50;
    
    [self setUpScrollView:self.loanCount];
    
    self.mScrollView.delegate = self;

}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat x = scrollView.contentOffset.x;
    
    if (x < 0) {
        
        x = 0;
    }else if ( x > self.loanCount*100 - 10) {
        x = self.loanCount * 100 - 10;
    }
    self.loanMoneyLabel.text = [NumberFormatter formatterNumberToDecimal:[NSNumber numberWithInteger:round(x/10) *1000 + 1000]];

    self.loanMoneyBlock(self.loanMoneyLabel.attributedText.string);

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

    CGFloat x = scrollView.contentOffset.x;

    if (x < 0) {
        
        x = 0;
        
    }else if ( x > self.loanCount*100 - 10) {
        
        x = self.loanCount * 100 - 10;
    }

    [scrollView setContentOffset:CGPointMake(round(x/10) * 10, 0)];
}

- (void)setUpScrollView:(NSInteger) count{
    
    [self.mScrollView.layer addSublayer:[self shaplayerShadow1]];
    
    for (int i = 0; i < count; i++) {
        CAShapeLayer *layer = nil;
        if (i == count - 1) {
            layer = [self shapeLayer:i];
            layer.frame = CGRectMake(100 * i + SCREEN_WIDTH/2.0, 0, 90, 20);
            [self.mScrollView.layer addSublayer:layer];
            
            self.mScrollView.contentSize = CGSizeMake(100 * count  + SCREEN_WIDTH - 10, 50);

        }else {
        
            layer = [self shapeLayer:i];
            layer.frame = CGRectMake(100 * i + SCREEN_WIDTH/2.0, 0, 100, 20);
            [self.mScrollView.layer addSublayer:layer];
        }
        
        UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(100*i - 40 + SCREEN_WIDTH/2.0 - 10, 20, 80, 30)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = ColorFromHex(0x333333);
       
        if (i == 0) {
            
            label.textColor = ColorFromHex(0x999999);
        }
        label.text = [NumberFormatter formatterNumberToDecimal:[NSNumber numberWithInteger:i*10000]];

        [self.mScrollView addSubview:label];
        
    }
    UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(100*count - 40 + SCREEN_WIDTH/2.0, 20, 80, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = ColorFromHex(0x444444);
    
    label.text = [NumberFormatter formatterNumberToDecimal:[NSNumber numberWithInteger:count*10000]];

    [self.mScrollView addSubview:label];
    
    UIView *redLineView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0 - 1, 60, 2, 18)];
    redLineView.backgroundColor = [UIColor redColor];
    [self addSubview:redLineView];
    
    UIView *redTipView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-3, 76.5, 6, 6)];
    redTipView.layer.cornerRadius = 3;
    redTipView.layer.masksToBounds = YES;
    redTipView.backgroundColor = [UIColor redColor];
    [self addSubview:redTipView];
    
    [self.mScrollView setContentOffset:CGPointMake(290, 0)];
    
    [self.mScrollView.layer addSublayer:[self shaplayerShadow2]];

}



- (CAShapeLayer *)shaplayerShadow1 {
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = CGRectMake(0, 0, SCREEN_WIDTH/2.0, 20);
    layer.backgroundColor = [UIColor clearColor].CGColor;
    
    CAShapeLayer *lineLayer = [[CAShapeLayer alloc] init];
    lineLayer.frame = CGRectMake(0, 19, layer.bounds.size.width, 1);
    lineLayer.backgroundColor = COLOR(163, 163, 163, 0.3).CGColor;
    [layer addSublayer:lineLayer];
    
    
    for (int i = 0; i < SCREEN_WIDTH/20; i++) {
        
        CAShapeLayer *verticalLineLayer = [[CAShapeLayer alloc] init];
        verticalLineLayer.backgroundColor =  COLOR(163, 163, 163, 0.3).CGColor;
        if (i%10 == 1) {
            verticalLineLayer.frame = CGRectMake(SCREEN_WIDTH /2.0 - 10 * i, 7, 1, 12);
            
        }else if (i%5 == 1) {
            
            verticalLineLayer.frame = CGRectMake(SCREEN_WIDTH /2.0 - 10 * i, 11, 1, 8);
            
        }else {
            verticalLineLayer.frame = CGRectMake(SCREEN_WIDTH /2.0 - 10 * i, 14, 1, 5);
        }
        
        [layer addSublayer:verticalLineLayer];

    }
    
     return layer;
}

- (CAShapeLayer *)shaplayerShadow2 {
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = CGRectMake(self.mScrollView.contentSize.width - SCREEN_WIDTH/2.0 , 0, SCREEN_WIDTH/2.0, 20);
    layer.backgroundColor = [UIColor clearColor].CGColor;
    
    CAShapeLayer *lineLayer = [[CAShapeLayer alloc] init];
    lineLayer.frame = CGRectMake(0, 19, layer.bounds.size.width, 1);
    lineLayer.backgroundColor = COLOR(163, 163, 163, 0.3).CGColor;
    [layer addSublayer:lineLayer];
    
    
    for (int i = 0; i < SCREEN_WIDTH/20; i++) {
        
        CAShapeLayer *verticalLineLayer = [[CAShapeLayer alloc] init];
        verticalLineLayer.backgroundColor =  COLOR(163, 163, 163, 0.3).CGColor;
        if (i%10 == 0) {
            verticalLineLayer.frame = CGRectMake(10 * i, 7, 1, 12);
            
        }else if (i%5 == 0) {
            
            verticalLineLayer.frame = CGRectMake( 10 * i, 11, 1, 8);
            
        }else {
            verticalLineLayer.frame = CGRectMake(10 * i, 14, 1, 5);
        }
        
        [layer addSublayer:verticalLineLayer];
        
    }
    return layer;
}




- (CAShapeLayer *)shapeLayer :(NSInteger) index {

    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = CGRectMake(0, 0, index == self.loanCount - 1? 90 : 100, 20);
    layer.backgroundColor = [UIColor clearColor].CGColor;

    CAShapeLayer *lineLayer = [[CAShapeLayer alloc] init];
    lineLayer.backgroundColor = ColorFromHex(0xa3a3a3).CGColor;
    lineLayer.frame = CGRectMake(0, 19, layer.bounds.size.width, 1);
    [layer addSublayer:lineLayer];
    
    for (int i = 0; i < 10; i++) {
        
        CAShapeLayer *verticalLineLayer = [[CAShapeLayer alloc] init];
        verticalLineLayer.backgroundColor = ColorFromHex(0xa3a3a3).CGColor;
        if (i == 9) {
            verticalLineLayer.frame = CGRectMake(10 * i, 7, 1, 12);

        }else if (i == 4) {
            
            verticalLineLayer.frame = CGRectMake(10 * i, 11, 1, 8);

        }else {
            verticalLineLayer.frame = CGRectMake(10 * i, 14, 1, 5);
        }
        
        [layer addSublayer:verticalLineLayer];
    }
        
    return layer;
}



- (void)setUpLoanMoney:(NSString *)loanMoney {

    self.loanMoneyLabel.text = [NumberFormatter formatterNumberToDecimal:[NSNumber numberWithInteger: [loanMoney integerValue]]];

    self.mScrollView.contentOffset = CGPointMake(([loanMoney integerValue] - 1000) / 1000 * 10 , 0);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
