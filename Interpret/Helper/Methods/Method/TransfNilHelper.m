//
//  TransfNilHelper.m
//  NewTest
//
//  Created by 乔杰 on 2018/1/19.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "TransfNilHelper.h"

@implementation TransfNilHelper

/**
 *  去掉字典 value = [NSNull null] 的数据
 *  @param dict 字典
 *
 */
+ (void)deleNullValueDictionary:(NSDictionary *)dict
{
    //将字典中值为空的对象的值替换为@“”空字符串
    NSArray *keys = [dict allKeys];
    
    id key, value;
    
    for (int i = 0; i < [keys count]; i++) {
       
        key = [keys objectAtIndex: i];
        
        value = [dict objectForKey: key];
        
        [dict setValue: [self judgeIsNil: value] forKey: key];
    }
}

+ (NSString *)judgeIsNil:(id)value {
    if (!value) {
        return @"";
    }
    if ([value isKindOfClass:[NSNull class]]) {
        return  @"";
    }
    if ([[NSString stringWithFormat: @"%@", value] isEqualToString: @"<null>"]) {
        return @"";
    }
    return [NSString stringWithFormat: @"%@", value];
}

@end
