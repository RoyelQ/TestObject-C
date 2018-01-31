//
//  MeViewController.m
//  Interpret
//
//  Created by 乔杰 on 2018/1/30.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "MeViewController.h"

#import "MeOtherTableViewCell.h"

#import "ThemeViewController.h"
#import "PasswordViewController.h"
#import "MapViewController.h"
#import "ScanCodeViewController.h"
#import "AudioViewController.h"


@interface MeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mTableView;

@end

@implementation MeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";

    [self setUpTableView];
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


#pragma mark - 布局页面视图
- (void)setUpTableView {
    self.mTableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, Screen_width, Screen_height - 64 - 57) style:UITableViewStyleGrouped];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    [self.view addSubview:self.mTableView];
    self.mTableView.showsVerticalScrollIndicator = NO;
    self.mTableView.showsHorizontalScrollIndicator = NO;
    self.mTableView.backgroundColor = Clear_color;
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0, *)) {
        self.mTableView.estimatedRowHeight = 0;
        self.mTableView.estimatedSectionFooterHeight = 0;
        self.mTableView.estimatedSectionHeaderHeight = 0;
    }
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1f;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 8.0f;
}
//单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MeOtherTableViewCell *cell = [MeOtherTableViewCell  cellWithTableView: tableView andIndexPath: indexPath];
    
    [cell setData: indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            Push(ThemeViewController);
            break;
        case 1:
            Push(PasswordViewController);
            break;
        case 2:
            Push(MapViewController);
            break;
        case 3:
            Push(ScanCodeViewController);
            break;
        case 4:
            Push(AudioViewController);
            break;
        default:
            break;
    }
    
    
    
}


@end
