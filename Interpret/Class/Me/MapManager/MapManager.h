//
//  MapManager.h
//  NewTest
//
//  Created by 乔杰 on 2018/1/24.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeoCodeManager.h"

@interface MapManager : NSObject

+ (MapManager *)shareManager;

/**
 *  开启定位服务
 *  timeInteval 间隔时间进行定位一次
 *  locationBlock 定位成功后数据回传 传值：国家、省份、城市、区域、街道、门牌号、具体地址
 *  headingBlock  监测设备方向变化
 */
- (void)startLocationWithTimeInteval:(NSTimeInterval)timeInteval locationBlock: (DetailAdressBlock)locationBlock headingBlock:(HeadingBlock)headingBlock;


@end
