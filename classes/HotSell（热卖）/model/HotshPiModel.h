//
//  HotshPiModel.h
//  OuLianWang
//
//  Created by hsmj on 15/7/15.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotshPiModel : NSObject

@property (nonatomic, strong) NSString * gid;
@property (nonatomic, strong) NSString * gimg;
@property (nonatomic, strong) NSString * goodsname;
@property (nonatomic, strong) NSString * price;
@property (nonatomic, strong) NSString * storeid;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
