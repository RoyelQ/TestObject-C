//
//  ImageHelper.h
//  NewTest
//
//  Created by 乔杰 on 2018/1/19.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageHelper : NSObject

/**
 *  根据颜色绘制图片
 *
 *  @param color 目标图片颜色
 *
 *  @return 返回的图片文件
 */
+ (UIImage *)imageWithColor: (UIColor *)color;
/**
 *  压缩图片到指定文件大小
 *
 *  @param image 目标图片
 *  @param size  目标大小（最大值）
 *
 *  @return 返回的图片文件
 */
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;

@end
