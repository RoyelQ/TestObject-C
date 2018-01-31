//
//  CalendarPickerView.h
//  TestNetworkApi
//
//  Created by 乔杰 on 2017/12/28.
//  Copyright © 2017年 乔杰. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenWidth     [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight    [[UIScreen mainScreen] bounds].size.height
#define AdaptX(x)       [UIScreen mainScreen].bounds.size.width/320*x

#define ColorFromHex(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define COLOR(R, G, B, A)           [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]



@interface QJCalendarCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) BOOL currentDate;
//公历日期
@property (nonatomic, strong) UILabel *gregorianDateLabel;
//农历日期
@property (nonatomic, strong) UILabel *lunarDateLabel;
//是否事务
@property (nonatomic, strong) UIButton *affairsButton;


@end



@interface CalendarPickerView : UIView

- (CGFloat)viewHeight;

@end


