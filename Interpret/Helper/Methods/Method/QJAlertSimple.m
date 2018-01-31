//
//  QJAlertSimple.m
//  JHHQB
//
//  Created by jinrongweidian on 17/3/21.
//  Copyright © 2017年 我爱微点. All rights reserved.
//

#import "QJAlertSimple.h"

@implementation QJAlertSimple

+ (void)alertViewControllerWithAlertTitle:(NSString *)alertTitle alertMessage:(NSString *)alertMessage  cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle  cancelHandler:(void(^)(void))cancelHandler confirmHandler:(void(^)(void))confirmHandler alertFinishHandler:(void(^)(void))alertFinishHandler {
    if (@available(iOS 8.0, *)) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle: cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelHandler) {
                cancelHandler();
            }
        }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle: confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (confirmHandler) {
                confirmHandler();
            }
        }];
        [alert addAction:action1];
        [alert addAction:action2];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:^{
            if (alertFinishHandler) {
                alertFinishHandler();
            }
        }];
    }
}


+ (void)alertViewControllerWithAlertTitle:(NSString *)alertTitle alertMessage:(NSString *)alertMessage  actionTitle:(NSString *)cancelTitle cancelHandler:(void(^)(void))cancelHandler alertFinishHandler:(void(^)(void))alertFinishHandler {
    if (@available(iOS 8.0, *)) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle: cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelHandler) {
                cancelHandler();
            }
        }];
        [alert addAction:action];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:^{
            if (alertFinishHandler) {
                alertFinishHandler();
            }
        }];
    }
}



+ (void)alertViewControllerWithAlertTitle:(NSString *)alertTitle alertMessage:(NSString *)alertMessage  actionTitle:(NSString *)confirmTitle confirmHandler:(void(^)(void))confirmHandler  alertFinishHandler:(void(^)(void))alertFinishHandler {
    if (@available(iOS 8.0, *)) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle: confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (confirmHandler) {
                confirmHandler();
            }
        }];
        [alert addAction:action];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:^{
            if (alertFinishHandler) {
                alertFinishHandler();
            }
        }];
    }
}


+ (void)alertWithMessage:(NSString *)message {
    
    if (@available(iOS 8.0, *)) {
        
        [QJAlertSimple alertViewControllerWithAlertTitle: @"提示" alertMessage: message actionTitle: @"取消" cancelHandler: nil alertFinishHandler:nil];
    }
}


+ (void)alertWithMessage:(NSString *)message delay:(NSTimeInterval)delay {
    
    if (@available(iOS 8.0, *)) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"" message: message preferredStyle:UIAlertControllerStyleAlert];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion: nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [alert dismissViewControllerAnimated: NO completion: nil];
        });
    }
}

@end
