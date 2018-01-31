//
//  CycleLayer.h
//  NewTest
//
//  Created by 乔杰 on 2018/1/22.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#define Cycle_Line_color  ColorFromHex(0x909090)
#define cycle_width     60
#define cycle_raw       20

@interface CycleLayer : CALayer

@property (nonatomic, assign) BOOL isSelected;

@end
