//
//  LoginViewController.m
//  Interpret
//
//  Created by 乔杰 on 2018/1/30.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear: animated];
    
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear: animated];
    
    self.navigationController.navigationBarHidden = NO;
    
}



@end
