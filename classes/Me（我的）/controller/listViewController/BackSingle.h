//
//  BackSingle.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/4.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BackSingle : NSObject
@property (assign, nonatomic) BOOL isBack;
@property (assign, nonatomic) BOOL isFirst;
@property (assign, nonatomic) int manySms;
@property (assign, nonatomic) BOOL isLogIn;

@property (strong, nonatomic) NSString * vipName;

@property (strong, nonatomic) NSString * selectCity;
//定位
@property(nonatomic,strong)NSString *lan;
@property(nonatomic,strong)NSString *lon;
@property(nonatomic,strong)NSString *provId;
@property(nonatomic,strong)NSString *cityId;
@property(nonatomic,strong)NSString *areaId;

+(id)shareInstance;

@end
