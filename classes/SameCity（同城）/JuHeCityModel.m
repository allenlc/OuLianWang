//
//  JuHeCityModel.m
//  BirdMovie
//
//  Created by SDA on 15-5-3.
//  Copyright (c) 2015年 夏威夷man. All rights reserved.
//

#import "JuHeCityModel.h"

#import "Tool.h"

@interface JuHeCityModel ()

@end

@implementation JuHeCityModel


+ (instancetype)currentCity{
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] valueForKey:kCurrentCity];
    JuHeCityModel *model = [[JuHeCityModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
+ (instancetype)positionCity{
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] valueForKey:kLocationCity];
    JuHeCityModel *model = [[JuHeCityModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
- (void)setCurrentCity{
    Tool *tool = [[Tool alloc] init];
    NSDictionary *dict = [tool exchangeDictWithModel:self];
    [[NSUserDefaults standardUserDefaults] setValue:dict forKey:kCurrentCity];
}
- (void)setPositionCity{
    Tool *tool = [[Tool alloc] init];
    NSDictionary *dict = [tool exchangeDictWithModel:self];
    [[NSUserDefaults standardUserDefaults] setValue:dict forKey:kLocationCity];
}
-(void)setNewCurrentCity
{
    Tool *tool = [[Tool alloc] init];
    NSDictionary *dict = [tool exchangeDictWithModel:self];
    [[NSUserDefaults standardUserDefaults] setValue:dict forKey:kCurrentCity];

}
@end
