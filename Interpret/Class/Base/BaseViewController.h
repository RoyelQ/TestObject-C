//
//  BaseViewController.h
//  Interpret
//
//  Created by 乔杰 on 2018/1/30.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, assign) BOOL ifSupportRightSlide;

#pragma mark - 添加导航栏左侧返回按钮
- (void)addBackButton;
- (void)addBackButtonWithClickBlock:(void(^)(void))leftButtonClickHandle;

#pragma mark - 添加导航栏右侧按钮 区分图文
- (void)addRightButton:(NSString *)title isImage:(BOOL)isImage imageName:(NSString *)imageName rightButtonClickBlock:(void(^)(void))rightButtonClickHandle;

@end
