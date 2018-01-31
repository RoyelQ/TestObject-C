//
//  ScanCodeAnimationView.h
//  NewTest
//
//  Created by 乔杰 on 2018/1/26.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height

#define ScanWidth 200                            //扫描区域宽度
#define ScanHeight 200                           //扫描区域高度
#define ScanY (SCREENH_HEIGHT - 64 - ScanHeight)/2.0  //扫描区域y

@interface ScanCodeAnimationView : UIView

-(void)startAnimaion;

-(void)stopAnimaion;


@end
