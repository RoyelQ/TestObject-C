//
//  KeychainManager.h
//  NewTest
//
//  Created by 乔杰 on 2018/1/23.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeychainManager : NSObject



+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;


+ (void)save:(NSString *)service data:(id)data;


+ (id)load:(NSString *)service;


+ (void)delete:(NSString *)serviece;



@end
