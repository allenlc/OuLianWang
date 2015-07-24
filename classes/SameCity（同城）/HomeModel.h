//
//  HomeModel.h
//  OuLianWang
//
//  Created by hsmj on 15/7/14.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject
@property(nonatomic,copy)NSString *storename;
@property(nonatomic,copy)NSString *logo;
@property(nonatomic,copy)NSArray *ad_list;
@property(nonatomic,copy)NSString *goodrate;
@property(nonatomic,copy)NSArray *store_goods;
@property(nonatomic,copy)NSString *gateimg;
@property(nonatomic,copy)NSString *storeid;
@property(nonatomic,copy)NSString *businessIf;
@property(nonatomic,copy)NSString *latitude;
@property(nonatomic,copy)NSString *longitude;
@property(nonatomic,strong)NSMutableArray *goodsArray;

@end
