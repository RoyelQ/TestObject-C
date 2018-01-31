//
//  QJAlertSimple.h
//  JHHQB
//
//  Created by jinrongweidian on 17/3/21.
//  Copyright © 2017年 我爱微点. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QJAlertSimple : NSObject

//iOS 9以后使用UIAlertController代替UIAlertView显示弹窗
//有两个点击事件的系统弹窗
/**
 * alertTitle     弹窗标题
 * alertMessage   弹窗显示信息
 * cancelTitle    取消按钮标题
 * confirmTitle   确认按钮标题
 * cancelHandler  取消响应事件
 * confirmHandler 第二个按钮响应事件
 * alertFinishHandler 弹窗消失时响应事件
 */

+ (void)alertViewControllerWithAlertTitle:(NSString *)alertTitle alertMessage:(NSString *)alertMessage  cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle  cancelHandler:(void(^)(void))cancelHandler confirmHandler:(void(^)(void))confirmHandler alertFinishHandler:(void(^)(void))alertFinishHandler;

//有一个点击事件（取消）的系统弹窗
/**
 * alertTitle     弹窗标题
 * alertMessage   弹窗显示信息
 * cancelTitle    取消按钮标题
 * cancelHandler  取消响应事件
 * alertFinishHandler 弹窗消失时响应事件
 */
+ (void)alertViewControllerWithAlertTitle:(NSString *)alertTitle alertMessage:(NSString *)alertMessage  actionTitle:(NSString *)cancelTitle cancelHandler:(void(^)(void))cancelHandler alertFinishHandler:(void(^)(void))alertFinishHandler;


//有一个点击事件（确认）的系统弹窗
/**
 * alertTitle     弹窗标题
 * alertMessage   弹窗显示信息
 * confirmTitle   确认按钮标题
 * cancelHandler  按钮响应事件
 * alertFinishHandler 弹窗消失时响应事件
 */
+ (void)alertViewControllerWithAlertTitle:(NSString *)alertTitle alertMessage:(NSString *)alertMessage  actionTitle:(NSString *)confirmTitle confirmHandler:(void(^)(void))confirmHandler  alertFinishHandler:(void(^)(void))alertFinishHandler ;

/**
 * alertMessage   弹窗显示信息
 */
+ (void)alertWithMessage:(NSString *)message;

/**
 * alertMessage   弹窗显示信息
 * delay          弹窗显示时间
 */
+ (void)alertWithMessage:(NSString *)message delay:(NSTimeInterval)delay;



@end
