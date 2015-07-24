//
//  CityModel.h
//  exexex
//
//  Created by allenariel on 15/6/30.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject<NSCoding>
@property(nonatomic,copy)NSString *operatime;
@property(nonatomic,copy)NSArray *g_son;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *provid;
@property(nonatomic,copy)NSString *cityid;
@property(nonatomic,assign)BOOL open;
@property(nonatomic,copy)NSMutableArray *areas;

@end
