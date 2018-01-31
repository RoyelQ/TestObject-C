//
//  TransfNilHelper.h
//  NewTest
//
//  Created by 乔杰 on 2018/1/19.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransfNilHelper : NSObject


/**
 *  去掉字典 value = [NSNull null] 的数据
 *  @param dict 字典
 *
 */
+ (void)deleNullValueDictionary:(NSDictionary *)dict;

+ (NSString *)judgeIsNil:(id)value;


@end
