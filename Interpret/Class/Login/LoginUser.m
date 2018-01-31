//
//  LoginUser.m
//  NewTest
//
//  Created by 乔杰 on 2018/1/19.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "LoginUser.h"

#define User_info                       @"User_info"
#define User_login_statu                @"User_login_statu"
#define User_is_first_launch            @"User_is_first_launch"

@implementation LoginUser

static LoginUser *sharedLoginUser = nil;
//登录用户对象
+ (id)alloc {
    NSAssert(sharedLoginUser == nil, @"Attempted to allocate a second instance of a singleton.");
    sharedLoginUser = [super alloc];
    return sharedLoginUser;    
}

+ (LoginUser *)sharedLoginUser {
    if (!sharedLoginUser)
        sharedLoginUser = [[LoginUser alloc] init];
    return sharedLoginUser;
}

- (id)init{
    if ((self = [super init])){
    }
    return self;
}

#pragma mark - Mange user info
//用户信息
- (void)setLoginUserInfo:(NSDictionary *)info {

    [User_default removeObjectForKey: User_info];
    
    [TransfNilHelper deleNullValueDictionary: info];
    
    [User_default setValue: info forKey: User_info];
    
    [User_default synchronize];
}

-(NSDictionary *)getLoginUserInfo {
    
    return [User_default objectForKey:User_info];
    
}

//登录状态
- (void)setUserLoginStatus:(BOOL)status{
    if (status) { //登录
        
        [User_default setObject: @"1" forKey: User_login_statu];
       
        [User_default synchronize];
    }else{      //没登录
        
        [User_default setObject:@"0" forKey: User_login_statu];
        
        [User_default synchronize];
    }
}
- (BOOL)userIsLogin {
    
    return [[User_default objectForKey: User_login_statu] integerValue] == 1;
}

//APP第一次运行
- (void)setUserFirstLaunch {
    
    [User_default setObject: AppCurrentVersion forKey: User_is_first_launch];
  
    [User_default synchronize];
}

- (BOOL)userIsFirstLaunch {
    
    if ([[User_default objectForKey:User_is_first_launch] isEqualToString:AppCurrentVersion]) {
      
        return NO;
        
    }else{
        return YES;
    }
}




@end
