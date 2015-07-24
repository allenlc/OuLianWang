//
//  JuHeCityModel.h
//  BirdMovie
//
//  Created by SDA on 15-5-3.
//  Copyright (c) 2015年 夏威夷man. All rights reserved.
//
#define kCurrentCity @"currentCityKey"
#define kLocationCity @"locationCity"
#import <Foundation/Foundation.h>

@interface JuHeCityModel : NSObject
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *city_name;
@property (nonatomic,copy) NSString *city_pre;
@property (nonatomic,copy) NSString *city_pinyin;
@property (nonatomic,copy) NSString *city_short;
@property (nonatomic,copy) NSString *count;

@property (strong,nonatomic) NSNumber *latitude;
@property (strong,nonatomic) NSNumber *longtitude;

+ (instancetype)currentCity;
+ (instancetype)positionCity;

- (void)setNewCurrentCity;


- (void)setCurrentCity;
- (void)setPositionCity;

@end
