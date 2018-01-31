//
//  TouchAuthManager.h
//  NewTest
//
//  Created by 乔杰 on 2018/1/23.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <LocalAuthentication/LocalAuthentication.h>

@interface TouchAuthManager : NSObject

+ (TouchAuthManager *)shareMannager;

- (void)judgeTouchAuth:(void(^)(BOOL success, NSString *errorDecription))confirmHandler;


@end
