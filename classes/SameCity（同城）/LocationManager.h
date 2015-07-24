//
//  LocationManager.h
//  BirdMovie
//
//  Created by SDA on 15-5-3.
//  Copyright (c) 2015年 夏威夷man. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "JuHeCityModel.h"

@interface LocationManager : NSObject<CLLocationManagerDelegate>

+ (instancetype)shareLocationManager;

- (void)updatingLoaction;

@property (strong,nonatomic) CLLocationManager *manager;

@property (strong,nonatomic) NSString *cityName;

@property (strong,nonatomic) CLLocation *location;

@property (strong,nonatomic) JuHeCityModel *positionModel;

@property (copy,nonatomic) void(^actionBlock)(JuHeCityModel *city);

@end
