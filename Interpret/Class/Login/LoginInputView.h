//
//  LoginInputView.h
//  NewTest
//
//  Created by 乔杰 on 2018/1/19.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginInputView : UIView

@property (nonatomic, strong) UITextField *inputTextField;

@property (nonatomic, strong) UIButton *sendCheckCodeButton;


- (instancetype)initWithImageName:(NSString *)imageName keyboardType:(UIKeyboardType)keyboardType clearMode:(UITextFieldViewMode)clearMode secureTextEntry:(BOOL)secureTextEntry placeholder:(NSString *)placeholder appearCheckButton:(BOOL)appearCheckButton;

@end
