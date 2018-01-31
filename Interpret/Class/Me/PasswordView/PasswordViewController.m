//
//  PasswordViewController.m
//  NewTest
//
//  Created by 乔杰 on 2018/1/23.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "PasswordViewController.h"

#import "PasswordView.h"

#import "KeychainManager.h"

#import "TouchAuthManager.h"

@interface PasswordViewController ()

@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"密码管理";
    [self addBackButtonWithClickBlock: nil];
 
    PasswordView *view = [[PasswordView alloc] initWithFrame: CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, cycle_width + (cycle_width + cycle_raw) * 2)];
    [self.view addSubview: view];
 
//
//    [[TouchAuthManager shareMannager] judgeTouchAuth:^(BOOL success, NSString *errorDecription) {
//
//        if (success) {
//
//            [QJAlertSimple alertWithMessage: errorDecription delay: 2.0];
//
//        }else {
//            [QJAlertSimple alertWithMessage: errorDecription delay: 2.0];
//        }
//    }];
    
    NSMutableDictionary *userNamePasswordKVPairs = [NSMutableDictionary dictionary];
    [userNamePasswordKVPairs setObject:@"1060581291@qq.com" forKey: @"key_username"];
    [userNamePasswordKVPairs setObject:@"QJqiaojie133206" forKey: @"key_userpassword"];
    NSLog(@"%@", userNamePasswordKVPairs); //有KV值
    
    // 将用户名和密码写入keychain
    [KeychainManager save: @"key_username_password" data:userNamePasswordKVPairs];
    
    // 从keychain中读取用户名和密码
    NSMutableDictionary *readUsernamePassword = (NSMutableDictionary *)[KeychainManager load: @"key_username_password"];
    NSString *userName = [readUsernamePassword objectForKey: @"key_username"];
    NSString *password = [readUsernamePassword objectForKey: @"key_userpassword"];
    NSLog(@"username = %@", userName);
    NSLog(@"password = %@", password);
    
    [KeychainManager delete: @"key_username_password"];
    
    NSLog(@"%@", [KeychainManager getKeychainQuery: @"key_username_password"]);
}







@end
