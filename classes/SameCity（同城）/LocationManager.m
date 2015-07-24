//
//  LocationManager.m
//  BirdMovie
//
//  Created by SDA on 15-5-3.
//  Copyright (c) 2015年 夏威夷man. All rights reserved.
//

#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "BackSingle.h"
static LocationManager *_locationManager;

@interface LocationManager ()<CLLocationManagerDelegate>


@property (assign,nonatomic) BOOL isFirst;
@end

@implementation LocationManager
+ (instancetype)shareLocationManager{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (_locationManager == nil) {
            _locationManager = [[LocationManager alloc] init];
        }
    });
    return _locationManager;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        _isFirst = YES;
        _manager = [[CLLocationManager alloc] init];
        _manager.delegate=self;
        [self configuretLocationManager];
        _cityName = @"NULL";
    }
    return self;
}
- (void)configuretLocationManager{
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"不能使用定位");
    }
    else{
        //请求权限ios8中使用
        if ([UIDevice currentDevice].systemVersion.doubleValue>=8.0) {
            [_manager requestAlwaysAuthorization];//这个方法是8.0之后才有的
        
            NSLog(@"授权");
        
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
            [_manager requestWhenInUseAuthorization];
            [self configManager];
            }
        }
    }
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
        [self configManager];
    }
}

- (void)updatingLoaction{
    NSLog(@"定位开始");
    [_manager startUpdatingLocation];
}

- (void)configManager{
    _manager.delegate = self;
    _manager.desiredAccuracy = kCLLocationAccuracyBest;
    _manager.distanceFilter = 100.0;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    _location = [[CLLocation alloc] initWithLatitude:manager.location.coordinate.latitude longitude:manager.location.coordinate.longitude];
    [coder reverseGeocodeLocation:_location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error != nil) {
            NSLog(@"定位失败");
            
        }
        else{
            NSLog(@"定位成功");

            CLPlacemark *mark = [placemarks firstObject];
            NSLog(@"%f %f",mark.location.coordinate.latitude,mark.location.coordinate.longitude);
            BackSingle *single=[BackSingle shareInstance];
            single.lan=[NSString stringWithFormat:@"%f",mark.location.coordinate.latitude];
            single.lon=[NSString stringWithFormat:@"%f",mark.location.coordinate.longitude];
            
            
            if (mark.addressDictionary[@"City"]) {
                _cityName = mark.addressDictionary[@"City"];
                [self positionLoaction];
                [self actionBlockDo];
                NSString *str = [NSString stringWithFormat:@"您当前的城市:%@",_positionModel.city_name];
                NSLog(@"%@",str);
            }
        }
        
    }];
    [_manager stopUpdatingLocation];
}

- (void)actionBlockDo{
    if (_actionBlock) {
        _actionBlock(_positionModel);
    }
}

- (void)positionLoaction{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CityList" ofType:@"plist"];
    NSDictionary *cityDict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSArray *cityArr = cityDict[@"list"];
    for (NSDictionary *city in cityArr) {
        if (([_cityName rangeOfString:city[@"city_name"]].location != NSNotFound) || [city[@"city_pinyin"] isEqualToString:self.cityName]) {
            JuHeCityModel *cityModel = [[JuHeCityModel alloc] init];
            [cityModel setValuesForKeysWithDictionary:city];
            cityModel.latitude = @(_location.coordinate.latitude);
            cityModel.longtitude = @(_location.coordinate.longitude);
            self.positionModel = cityModel;
            [cityModel setPositionCity];
            if (_isFirst) {
                [cityModel setCurrentCity];
                _isFirst = NO;
            }
        }
    }
}






@end
