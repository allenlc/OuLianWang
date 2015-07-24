//
//  HotXHModel.m
//  OuLianWang
//
//  Created by hsmj on 15/7/15.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "HotXHModel.h"

@implementation HotXHModel
/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[@"operatime"] isKindOfClass:[NSNull class]]){
        self.operatime = dictionary[@"operatime"];
    }
    if(![dictionary[@"prom_img"] isKindOfClass:[NSNull class]]){
        self.promImg = dictionary[@"prom_img"];
    }
    if(![dictionary[@"promid"] isKindOfClass:[NSNull class]]){
        self.promid = dictionary[@"promid"];
    }
    if(![dictionary[@"storeid"] isKindOfClass:[NSNull class]]){
        self.storeid = dictionary[@"storeid"];
    }
    if(![dictionary[@"title"] isKindOfClass:[NSNull class]]){
        self.title = dictionary[@"title"];
    }	
    return self;
}

@end
