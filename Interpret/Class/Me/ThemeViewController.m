

//
//  ThemeViewController.m
//  Interpret
//
//  Created by 乔杰 on 2018/1/31.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "ThemeViewController.h"

#import "EATheme.h"
#import "EAThemesConfiguration.h"

@interface ThemeViewController ()

@end

@implementation ThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"主题设置";
    [self addBackButton];
    

    [self.view ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {

        if ([currentThemeIdentifier isEqualToString: EAThemeNormal]) {
            
            self.view.backgroundColor = Main_background_color;
            
        }else if ([currentThemeIdentifier isEqualToString: EAThemeBlack]) {
           
            self.view.backgroundColor = Main_text_color_light_gray;
            
        }else if ([currentThemeIdentifier isEqualToString: EAThemeBlue]) {
            
            self.view.backgroundColor = [UIColor blueColor];

        }else if ([currentThemeIdentifier isEqualToString: EAThemeRed]) {
            
            self.view.backgroundColor = [UIColor redColor];

        }else if ([currentThemeIdentifier isEqualToString: EAThemeOrange]) {
            
            self.view.backgroundColor = [UIColor orangeColor];
        }
    }];
}

static int count = 0;
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    switch (count%5) {
        case 0:
            [[EAThemeManager shareManager] displayThemeContentsWithThemeIdentifier: EAThemeNormal];
            break;
        case 1:
            [[EAThemeManager shareManager] displayThemeContentsWithThemeIdentifier: EAThemeBlack];
            break;
        case 2:
            [[EAThemeManager shareManager] displayThemeContentsWithThemeIdentifier: EAThemeBlue];
            break;
        case 3:
            [[EAThemeManager shareManager] displayThemeContentsWithThemeIdentifier: EAThemeRed];
            break;
        case 4:
            [[EAThemeManager shareManager] displayThemeContentsWithThemeIdentifier: EAThemeOrange];
            break;
        default:
            break;
    }
    count ++;

    if (count == 5) {
        count = 0;
    }
}


@end
