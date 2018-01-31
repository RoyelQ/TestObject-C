//
//  StringHelper.m
//  NewTest
//
//  Created by 乔杰 on 2018/1/19.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "StringHelper.h"

@implementation StringHelper

+ (NSString *)trim:(NSString *)string {
    
    //过滤掉字符串中的空格符号
    NSString *temp = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return temp;
}

+ (NSString *)jsonStringFromArray:(NSArray *)array {
    //将数组转化为json字符串
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:0 error:nil];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}


+ (NSString *)jsonStringFromDictionary:(NSDictionary *)dictionary {
    //将字典转化为json字符串
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:nil];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}


+ (NSString *)judgeStringContainNumberAndCharecterOnly:(NSString *)str {
    
    NSString *regex = @"^[0-9a-zA-Z]+$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@ ", regex];
    
    if ([predicate evaluateWithObject: [self trim:str]] == YES) {
        
        if ([self trim:str].length < 6 ) {
            //密码太短
            return @"-1";
            
        }else if ([self trim:str].length > 16 ){
            //密码过长
            return @"-2";
            
        }else {
            return @"1";
        }
    }else {
        //密码包含了特殊字符
        return @"-3";
    }
}


@end
