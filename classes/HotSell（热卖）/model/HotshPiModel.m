//
//  HotshPiModel.m
//  OuLianWang
//
//  Created by hsmj on 15/7/15.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "HotshPiModel.h"

@implementation HotshPiModel
/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[@"gid"] isKindOfClass:[NSNull class]]){
        self.gid = dictionary[@"gid"];
    }
    if(![dictionary[@"gimg"] isKindOfClass:[NSNull class]]){
        self.gimg = dictionary[@"gimg"];
    }
    if(![dictionary[@"goodsname"] isKindOfClass:[NSNull class]]){
        self.goodsname = dictionary[@"goodsname"];
    }
    if(![dictionary[@"price"] isKindOfClass:[NSNull class]]){
        self.price = dictionary[@"price"];
    }
    if(![dictionary[@"storeid"] isKindOfClass:[NSNull class]]){
        self.storeid = dictionary[@"storeid"];
    }	
    return self;
}


@end
