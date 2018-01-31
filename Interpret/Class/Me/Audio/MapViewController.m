//
//  MapViewController.m
//  NewTest
//
//  Created by 乔杰 on 2018/1/24.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "MapViewController.h"

#import <MapKit/MapKit.h>
#import "MapManager.h"

@interface MapViewController () <MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.title = @"地图";
    [self addBackButtonWithClickBlock: nil];


    [self layoutMapView];

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear: animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.rdv_tabBarController.tabBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear: animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.rdv_tabBarController.tabBarHidden = NO;
}




- (void)layoutMapView {
    //开启定位  显示当前定位地图
    [[MapManager shareManager] startLocationWithTimeInteval: 0 locationBlock: nil headingBlock: nil];
    
    self.mapView = [[MKMapView alloc] initWithFrame: self.view.bounds];
    
    if (@available(iOS 9.0, *)) {
       
        self.mapView.showsCompass = NO;
        
        self.mapView.showsScale = YES;
    }
    self.mapView.delegate = self;
    
    //跟踪用户当前位置 MKUserTrackingModeFollowWithHeading带设备方向跟踪
    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    
    [self.view addSubview: self.mapView];
    
    
    // 显示建筑物
    self.mapView.showsBuildings = YES;
    // 兴趣点
    self.mapView.showsPointsOfInterest = YES;
    // 交通
    if (@available(iOS 9.0, *)) {
        self.mapView.showsTraffic = YES;
    } else {

    }
}

#pragma mark - MKMapViewDelegate用户位置更新后调用代理
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {


}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {


}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {

    [[GeoCodeManager shareManager] getAdressWithLocation: userLocation.location  locationBlock:^(NSString *country, NSString *province, NSString *city, NSString *district, NSString *street, NSString *subStreet, NSString *adress) {
       
        userLocation.title = [NSString stringWithFormat: @"%@%@%@", province, city, district];
        userLocation.subtitle = adress;
    }];
//    MKPinAnnotationView
//    // 控制区域中心
//    CLLocationCoordinate2D center = userLocation.location.coordinate;
//    // 设置区域跨度
//    MKCoordinateSpan span = MKCoordinateSpanMake(0.077919, 0.044529);
//    // 创建一个区域
//    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
//    // 设置地图显示区域
//    [self.mapView setRegion:region animated:YES];
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error {

}


- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    // 如果是系统的大头针数据模型, 那么使用系统默认的大头针视图,
    if([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    
    return [[MKPinAnnotationView alloc] init];
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views {
    
    
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    
    NSLog(@"%@", mapView.annotations);

}

@end
