//
//  QJSecurityPolicy.h
//  JHH
//
//  Created by jinrongweidian on 17/1/3.
//  Copyright © 2017年 金融微店. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFSecurityPolicy.h"

@interface QJSecurityPolicy : NSObject

+ (AFSecurityPolicy *)customSecurityPolicy;

@end
