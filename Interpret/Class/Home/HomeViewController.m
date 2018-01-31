//
//  HomeViewController.m
//  Interpret
//
//  Created by 乔杰 on 2018/1/30.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear: animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.rdv_tabBarController.tabBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear: animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.rdv_tabBarController.tabBarHidden = YES;
}
@end
