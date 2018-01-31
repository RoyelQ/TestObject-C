//
//  MapManager.m
//  NewTest
//
//  Created by 乔杰 on 2018/1/24.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "MapManager.h"

@interface MapManager () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, copy) DetailAdressBlock locationBlock;

@property (nonatomic, copy) HeadingBlock headingBlock;

@property (nonatomic, strong) NSTimer *mTimer;

@end

@implementation MapManager

static MapManager *shareManager = nil;

+ (MapManager *)shareManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shareManager = [[MapManager alloc] init];
        
        shareManager.locationManager = [[CLLocationManager alloc] init];
    });
    return shareManager;
}

- (BOOL)canStartLocationService {
    
    if ([CLLocationManager locationServicesEnabled]) {
        //系统定位打开
        BOOL flag;
        switch ([CLLocationManager authorizationStatus]) {
            case kCLAuthorizationStatusNotDetermined:
                //用户未选择授权，弹窗提示重新选择
                [self.locationManager requestAlwaysAuthorization];
                flag = NO;
                break;
            case kCLAuthorizationStatusRestricted:
                //此应用程序未被授权使用位置服务。由于对于位置服务的主动限制，用户不能更改。这种状态，并且可能没有个人拒绝授权。
                flag = NO;
                break;
            case kCLAuthorizationStatusDenied:
                //用户已明确拒绝此应用程序的授权，或位置服务在设置中禁用。
                flag = NO;
                break;
            case kCLAuthorizationStatusAuthorizedAlways:
                //用户已获授权在任何时间使用其位置，包括监测区域、访问或重大地点变化。
                flag = YES;
                break;
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                //用户授权只在应用程序时使用其位置。
                flag = YES;
                break;
            default:
                break;
        }
        return flag;
    }else {
        //系统定位关闭
        [QJAlertSimple alertViewControllerWithAlertTitle: @"温馨提示\n" alertMessage: @"设备未开启系统定位,前往设置->隐私->定位服务开启定位服务" cancelTitle: @"取消" confirmTitle: @"去开启" cancelHandler: nil confirmHandler:^{
            if (@available(iOS 10.0, *)) {
                if ([[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString: UIApplicationOpenSettingsURLString]]) {
                    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: UIApplicationOpenSettingsURLString]];
                }
            }else {
                if ([[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString: @"prefs:root=LOCATION_SERVICES"]]) {

                    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: @"prefs:root=LOCATION_SERVICES"]];
                }
            }
        } alertFinishHandler: nil];
        return NO;
    }
}

/**
 *  开启定位服务
 *  timeInteval 间隔时间进行定位一次
 *  locationBlock 定位成功后数据回传 传值：国家、省份、城市、区域、街道、门牌号、具体地址
 *  headingBlock  监测设备方向变化
 */
- (void)startLocationWithTimeInteval:(NSTimeInterval)timeInteval locationBlock: (DetailAdressBlock)locationBlock headingBlock:(HeadingBlock)headingBlock {
    
    if ([self canStartLocationService]) {
        //设置定位精度
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //设置定位最小监听范围
        self.locationManager.distanceFilter = 10.0;
        //设置代理
        self.locationManager.delegate = self;
        //block赋值
        self.locationBlock = locationBlock;
        self.headingBlock = headingBlock;
        //时间传0时 默认定位一次
        if (timeInteval != 0) {
            self.mTimer = [NSTimer scheduledTimerWithTimeInterval: timeInteval target: self selector: @selector(startLocation) userInfo: nil repeats: YES];
        }else {
            [self startLocation];
        }
    }
}
- (void)startLocation {
    
    [self.locationManager startUpdatingLocation];

    [self.locationManager startUpdatingHeading];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    [self getAdressWithLocation: locations[0]];
    
    [self.locationManager stopUpdatingLocation];
    
}
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    //地址范围改变超过最小距离后 回传
    [self getAdressWithLocation: newLocation];
    
    [self.locationManager stopUpdatingLocation];

}

- (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading {
    
    [self.locationManager stopUpdatingHeading];

    if (self.headingBlock) {
        
        self.headingBlock(newHeading);
    }
}

/**
 *  地理编码
 *  location CLLocation对象，进行地理编码获取定位信息
 */
- (void)getAdressWithLocation:(CLLocation *)location {
    
    [[GeoCodeManager shareManager] getAdressWithLocation: location locationBlock:^(NSString *country, NSString *province, NSString *city, NSString *district, NSString *street, NSString *subStreet, NSString *adress) {
        
        if (self.locationBlock) {

            self.locationBlock(country, province, city, district, street, subStreet, adress);
        }
    }];
}

- (void)dealloc {
  
    if (self.mTimer) {
       
        self.mTimer = nil;
        [self.mTimer invalidate];
    }
}

@end
