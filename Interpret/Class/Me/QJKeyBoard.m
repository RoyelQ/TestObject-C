//
//  QJKeyBoard.m
//  JHHQB
//
//  Created by jinrongweidian on 17/3/27.
//  Copyright © 2017年 我爱微点. All rights reserved.
//

#import "QJKeyBoard.h"

static __weak id currentFirstResponder;

@implementation UIResponder (FirstResponder)


+ (id)QJ_currentFirstResponder
{
    currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(QJ_findFirstResponder:) to:nil from:nil forEvent:nil];
    return currentFirstResponder;
}
#pragma clang diagnostic pop

- (void)QJ_findFirstResponder:(id)sender
{
    currentFirstResponder = self;
}

@end

#define KEY_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define KEY_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define KEYBOARD_SEPARATA_LINE_COLOR     [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0f];

#define KEYBOARD_TEXT_COLOR              [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0f]

#define KEYBOARD_ESPECIAL_BACK_COLOR     [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0f]

@implementation QJKeyBoard

//初始化界面
- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        self.frame = CGRectMake(0, SCREEN_HEIGHT - 244, SCREEN_WIDTH, 244);
        self.string = [NSMutableString string];

        self.backgroundColor = KEYBOARD_SEPARATA_LINE_COLOR;
        float keyboard_width =  (KEY_SCREEN_WIDTH - 4)/3.0;
        
        for (int i = 0; i < 12; i++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:KEYBOARD_TEXT_COLOR forState:UIControlStateNormal];
            button.frame = CGRectMake(1 + (1 + keyboard_width)*(i%3), 1+(1+60) * (i/3), keyboard_width, 60);
            if (i == 9) {

                button.userInteractionEnabled = NO;
                button.backgroundColor = KEYBOARD_ESPECIAL_BACK_COLOR;
                
            }else if (i == 10) {
            
                [button setTitle:@"0" forState:UIControlStateNormal];
                [button titleLabel].font = [UIFont systemFontOfSize:25];;

            }else if (i == 11) {
            
                [button setImage:[[UIImage imageNamed:@"MMNumberKeyboardDeleteKey"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                button.backgroundColor = KEYBOARD_ESPECIAL_BACK_COLOR;

            }else {
                [button setTitle:[NSString stringWithFormat:@"%d", i+1] forState:UIControlStateNormal];
                [button titleLabel].font = [UIFont systemFontOfSize:25];;
            }
            [self addSubview:button];
            button.tag = i + 1;
            
            [button addTarget:self action:@selector(clickNumberAndInput:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}

- (void)clickNumberAndInput:(UIButton *)button {
    
    if(button.tag == 12) {
    
        if (self.string > 0) {
            
            [self.string deleteCharactersInRange:NSMakeRange(self.string.length - 1, 1)];
        }
    } else {
        [self.string appendString:button.currentTitle];
    }
    
    if ([self.delegate respondsToSelector:@selector(keyboard:didClickButton:withFieldString:)]) {
        
        [self.delegate keyboard:self didClickButton:button withFieldString:self.string];
    }
    
}
@end
