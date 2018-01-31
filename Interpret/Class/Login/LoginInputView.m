//
//  LoginInputView.m
//  NewTest
//
//  Created by 乔杰 on 2018/1/19.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "LoginInputView.h"

@interface LoginInputView () <UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) NSString *imageName;

@property (nonatomic, assign) UIKeyboardType keyboardType;

@property (nonatomic, assign) UITextFieldViewMode clearMode;

@property (nonatomic, assign) BOOL secureTextEntry;

@property (nonatomic, strong) NSString *placeholder;

@property (nonatomic, assign) BOOL appearCheckButton;

@end

@implementation LoginInputView

- (instancetype)initWithImageName:(NSString *)imageName keyboardType:(UIKeyboardType)keyboardType clearMode:(UITextFieldViewMode)clearMode secureTextEntry:(BOOL)secureTextEntry placeholder:(NSString *)placeholder appearCheckButton:(BOOL)appearCheckButton {
    
    self = [super init];
    if (self) {
        self.imageName = imageName;
        self.keyboardType = keyboardType;
        self.clearMode = clearMode;
        self.secureTextEntry = secureTextEntry;
        self.placeholder = placeholder;
        self.appearCheckButton = appearCheckButton;

        self.backgroundColor = Main_background_color;
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews {
     
    if (!self.imageView) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.image = [UIImage imageNamed: self.imageName];
        [self addSubview: self.imageView];
    }
    self.imageView.frame = CGRectMake(10, (VIEW_HEIGHT(self) - AdaptX(20))/2.0, AdaptX(20), AdaptX(20));
    
    if (!self.inputTextField) {
        self.inputTextField = [[UITextField alloc] init];
        self.inputTextField.delegate = self;
        [self addSubview: self.inputTextField];
        self.inputTextField.textColor = Main_text_color;
        self.inputTextField.clearButtonMode = self.clearMode;
        self.inputTextField.keyboardType = self.keyboardType;
        self.inputTextField.font = FONT(17);
        self.inputTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString: self.placeholder attributes: @{NSFontAttributeName : FONT(15), NSForegroundColorAttributeName : Main_text_color_light_gray}];
        self.inputTextField.secureTextEntry = self.secureTextEntry;
    }

    if (!self.sendCheckCodeButton && self.appearCheckButton) {
        self.sendCheckCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.sendCheckCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.sendCheckCodeButton setTitleColor: White_color forState:UIControlStateNormal];
        [self.sendCheckCodeButton setBackgroundColor: Main_color];
        [self.sendCheckCodeButton.titleLabel setFont: FONT(15)];
        [self addSubview:self.sendCheckCodeButton];
        
        self.sendCheckCodeButton.layer.cornerRadius = 3;
        self.sendCheckCodeButton.layer.masksToBounds = YES;
    }
    if (self.appearCheckButton) {
        self.sendCheckCodeButton.frame = CGRectMake(VIEW_WIDTH(self) - AdaptX(100), 1, AdaptX(100), VIEW_HEIGHT(self) - 2);
    }
    self.inputTextField.frame = CGRectMake(VIEW_RIGHT(self.imageView) + 10, (VIEW_HEIGHT(self) - AdaptX(30))/2.0, VIEW_WIDTH(self) - self.appearCheckButton * (VIEW_WIDTH(self.sendCheckCodeButton) + 10) - 30, AdaptX(30));
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    self.imageView.image = [UIImage imageNamed: [NSString stringWithFormat:@"%@-input", self.imageName]];

    return  YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if ([StringHelper trim:self.inputTextField.text].length != 0) {
        
        self.imageView.image = [UIImage imageNamed: [NSString stringWithFormat:@"%@-input", self.imageName]];
        
    }else {
        
        self.imageView.image = [UIImage imageNamed: self.imageName];
    }
    
    [textField resignFirstResponder];
}


@end

