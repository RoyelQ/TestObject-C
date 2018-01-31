//
//  TouchAuthManager.m
//  NewTest
//
//  Created by 乔杰 on 2018/1/23.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "TouchAuthManager.h"

#include <sys/sysctl.h>

#import <UIKit/UIDevice.h>


@implementation TouchAuthManager

static TouchAuthManager *shareManager = nil;

+ (TouchAuthManager *)shareMannager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        shareManager = [[TouchAuthManager alloc] init];
    });
    return shareManager;
}


- (void)judgeTouchAuth:(void(^)(BOOL success, NSString *errorDecription))confirmHandler {
    
    LAPolicy policy;
    if (@available(iOS 9.0, *)) {
        policy = LAPolicyDeviceOwnerAuthentication ;
    }else {
        policy = LAPolicyDeviceOwnerAuthenticationWithBiometrics;
    }
    if ([self devicePlatform]) {
        
        [self startAuthWithPolicy: policy confirmHandler: confirmHandler];
        
    }else {
        if (confirmHandler) {
            confirmHandler(NO, @"设备不支持指纹识别");
        }
    }
}

- (void)startAuthWithPolicy:(LAPolicy)policy  confirmHandler:(void(^)(BOOL success, NSString *errorDecription))confirmHandler {
    
    LAContext *myContext = [[LAContext alloc] init];
    myContext.localizedFallbackTitle = @"输入密码";
    
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"请验证已有指纹";
    if ([myContext canEvaluatePolicy:policy error: &authError]) {
        
        [myContext evaluatePolicy: policy localizedReason: myLocalizedReasonString reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                // 指纹识别成功，回主线程更新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (confirmHandler) {
                        confirmHandler(success, @"指纹识别成功");
                    }
                });
            }else {
                //指纹识别失败，回主线程更新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    //失败操作
                    LAError errorCode = error.code;
                    NSString *errorDecription = @"";
                    if (@available(iOS 9.0, *)) {
                        switch (errorCode) {
                            case LAErrorAuthenticationFailed:
                                errorDecription = @"授权失败";
                                break;
                            case LAErrorUserCancel:
                                errorDecription = @"用户取消验证Touch ID";
                                break;
                            case LAErrorUserFallback:
                                errorDecription = @"用户选择输入密码，切换主线程处理";
                                break;
                            case LAErrorSystemCancel:
                                errorDecription = @"取消授权，如其他应用切入";
                                break;
                            case LAErrorPasscodeNotSet:
                                errorDecription = @"设备系统未设置密码";
                                break;
                            case LAErrorTouchIDNotAvailable:
                                errorDecription = @"设备未设置Touch ID";
                                break;
                            case LAErrorTouchIDNotEnrolled:
                                errorDecription = @"用户未录入指纹";
                                break;
                            case LAErrorTouchIDLockout:
                                errorDecription = @"Touch ID被锁，需要用户输入密码解锁";
                                break;
                            case LAErrorAppCancel:
                                errorDecription = @"用户不能控制情况下APP被挂起";
                                break;
                            case LAErrorInvalidContext:
                                errorDecription = @"LAContext传递给这个调用之前已经失效";
                                break;
                            case LAErrorNotInteractive:
                                break;
                        }
                    }
                    if (confirmHandler) {
                        confirmHandler(success, errorDecription);
                    }
                });
            }
        }];
    }
}

- (BOOL)devicePlatform {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    if(platform.length > 6 ) {
        
        NSString * numberPlatformStr = [platform substringWithRange:NSMakeRange(6, 1)];
        NSInteger numberPlatform = [numberPlatformStr integerValue];
        // 是否是5s以上的设备
        return numberPlatform > 5;
    } else {
        return NO;
    }
}
@end
