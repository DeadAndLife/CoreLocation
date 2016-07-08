//
//  ViewController.m
//  CoreLocation
//
//  Created by qingyun on 16/7/4.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong)CLLocationManager *manager;//位置管理器

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.manager = [[CLLocationManager alloc] init];
    //设置位置管理器的Delegate
    self.manager.delegate = self;
    //向用户申请权限
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self.manager requestWhenInUseAuthorization];
    }
    
    //手机定位服务是否开启
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"在设置中打开GPS");
    }
    
    //配置location属性
    //精确度
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    //距离的频率
    self.manager.distanceFilter = 20.f;
    
    //开启定位
    [self.manager startUpdatingLocation];
    
    
}

#pragma mark - locatain manager

//授权状态改变的响应方法
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    NSLog(@"%d", status);
}
//更新位置
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"%@", locations);
    CLLocation *location = [locations lastObject];
    //经纬度
    CLLocationCoordinate2D coordinate = location.coordinate;
    //水平精度
    CLLocationAccuracy accuracy = location.horizontalAccuracy;
    //海拔高度
    CLLocationDistance distance = location.altitude;
    //垂直的精度
    CLLocationAccuracy acc = location.verticalAccuracy;
    
}

//失败,或者出错
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@", error);
}

@end
