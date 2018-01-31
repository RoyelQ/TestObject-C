//
//  UIButton+Block.h
//  NewTest
//
//  Created by 乔杰 on 2018/1/19.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonBlock)(void);

@interface UIButton (Block)

- (void)addAction:(ButtonBlock)block;

- (void)addAction:(ButtonBlock)block forControlEvents:(UIControlEvents)controlEvents;

@end
