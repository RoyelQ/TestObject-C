
//
//  BaseViewController.m
//  Interpret
//
//  Created by 乔杰 on 2018/1/30.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController () <UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = Main_background_color;
    
    //添加右滑返回手势
    if (!self.ifSupportRightSlide) {
        
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }

}



#pragma mark - 添加导航栏左侧返回按钮
- (void)addBackButton {
    
    [self addBackButtonWithClickBlock: nil];
}

- (void)addBackButtonWithClickBlock:(void(^)(void))leftButtonClickHandle {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 30);
    [button setImage:[UIImage imageNamed:@"arrow_back"] forState:UIControlStateNormal];
    [button setImageEdgeInsets: UIEdgeInsetsMake(0, -40, 0, 0)];
    if (leftButtonClickHandle) {
        
        [button addAction: leftButtonClickHandle];
        
    }else {
        [button addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem *leftSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftSpacer.width = -10;
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItems = @[leftSpacer, barButtonItem];
}

- (void)backButtonClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - 添加导航栏右侧按钮 区分图文
- (void)addRightButton:(NSString *)title isImage:(BOOL)isImage imageName:(NSString *)imageName rightButtonClickBlock:(void(^)(void))rightButtonClickHandle {
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIView *view = nil;
    if (isImage) {
        
        [rightButton setFrame:CGRectMake(6.0, 0.0, 30, 30)];
        [rightButton setImage: [UIImage imageNamed:imageName] forState:UIControlStateNormal];
        view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 30, 30)];
    }else {
        CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size;
        [rightButton setFrame:CGRectMake(6.0, 0.0, size.width, 30)];
        [rightButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [rightButton setTitleColor: Navigation_bar_itemtext_color forState:UIControlStateNormal];
        [rightButton setTitle:title forState:UIControlStateNormal];
        rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
        view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, size.width, 30)];
    }
    
    if (rightButtonClickHandle) {
        
        [rightButton addAction:rightButtonClickHandle];
    }
    [view addSubview:rightButton];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItem = rightItem;
}


@end
