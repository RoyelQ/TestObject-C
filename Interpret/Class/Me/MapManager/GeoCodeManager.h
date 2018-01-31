//
//  geoCodeManager.h
//  NewTest
//
//  Created by 乔杰 on 2018/1/24.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>
#import "QJAlertSimple.h"

//可编辑 根据具体需要信息进行回传
typedef void(^DetailAdressBlock)(NSString *country, NSString *province, NSString *city, NSString *district, NSString *street,  NSString *subStreet, NSString *adress);

typedef void(^LocationBlock)(CLLocation *location);

typedef void(^HeadingBlock)(CLHeading *heading);


@interface GeoCodeManager : NSObject

+ (GeoCodeManager *)shareManager;


/**
 *  地理编码
 *  location CLLocation对象，进行地理编码获取定位信息
 *  locationBlock 回传用户详细地址信息
 */
- (void)getAdressWithLocation:(CLLocation *)location locationBlock:(DetailAdressBlock)locationBlock;

/**
 *  地理编码
 *  adress NSString对象，进行地理编码获取定位位置
 *  locationBlock 回传Location信息
 */
- (void)getLocation:(NSString *)adress  locationBlock:(LocationBlock)locationBlock;


@end
