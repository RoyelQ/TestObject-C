
//
//  geoCodeManager.m
//  NewTest
//
//  Created by 乔杰 on 2018/1/24.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "GeoCodeManager.h"

@interface GeoCodeManager ()

@property (nonatomic, strong) CLGeocoder *geoCoder;

@end

@implementation GeoCodeManager

static GeoCodeManager *shareManager = nil;

+ (GeoCodeManager *)shareManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shareManager = [[GeoCodeManager alloc] init];
        
        shareManager.geoCoder = [[CLGeocoder alloc] init];
    });
    return shareManager;
}

/**
 *  地理编码
 *  location CLLocation对象，进行地理编码获取定位信息
 *  locationBlock 回传用户详细地址信息
 */
- (void)getAdressWithLocation:(CLLocation *)location locationBlock:(DetailAdressBlock)locationBlock {
    
    [self.geoCoder reverseGeocodeLocation: location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            [QJAlertSimple alertWithMessage: error.localizedDescription delay: 2];
        }else {
            CLPlacemark *placeMark = [placemarks firstObject];
            if (locationBlock) {
                //  country 国家 administrativeArea 州/省 locality 城市 subLocality  区 thoroughfare 街道 subThoroughfare 子街道或门牌号 name 具体位置
                locationBlock(placeMark.country, placeMark.administrativeArea, placeMark.locality, placeMark.subLocality, placeMark.thoroughfare, placeMark.subThoroughfare, placeMark.name);
            }
        }
    }];
}
/**
 *  地理编码
 *  adress NSString对象，进行地理编码获取定位位置
 *  locationBlock 回传Location信息
 */
- (void)getLocation:(NSString *)adress locationBlock:(LocationBlock)locationBlock {
        
    [self.geoCoder geocodeAddressString: adress completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       
        if (error) {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            [QJAlertSimple alertWithMessage: error.localizedDescription delay: 2];
        }else {
            
            CLPlacemark *placeMark = [placemarks firstObject];
            if (locationBlock) {
                locationBlock(placeMark.location);
            }
        }
    }];
}



@end
