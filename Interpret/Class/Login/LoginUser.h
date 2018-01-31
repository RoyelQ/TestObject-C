//
//  LoginUser.h
//  NewTest
//
//  Created by 乔杰 on 2018/1/19.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginUser : NSObject

//真实姓名 身份证号  昵称  头像  手机号 QQ号  微信号 密码 验证码 IDFA/UDID 指纹密码 手势密码  人脸识别

+ (LoginUser *)sharedLoginUser;

//用户信息
- (void)setLoginUserInfo:(NSDictionary *)info;
-(NSDictionary *)getLoginUserInfo;

//登录状态
- (void)setUserLoginStatus:(BOOL)status;
- (BOOL)userIsLogin;

//APP第一次运行
- (void)setUserFirstLaunch;
- (BOOL)userIsFirstLaunch;




@end
