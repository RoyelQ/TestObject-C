//
//  StringHelper.h
//  NewTest
//
//  Created by 乔杰 on 2018/1/19.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringHelper : NSObject


+ (NSString *)trim:(NSString *)string;

+ (NSString *)jsonStringFromArray:(NSArray *)array;

+ (NSString *)jsonStringFromDictionary:(NSDictionary *)dictionary;

+ (NSString *)judgeStringContainNumberAndCharecterOnly:(NSString *)str;


@end
