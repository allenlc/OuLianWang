//
//  LeiBModel.m
//  OuLianWang
//
//  Created by hsmj on 15/7/10.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "LeiBModel.h"

@implementation LeiBModel
/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[@"clicks"] isKindOfClass:[NSNull class]]){
        self.clicks = dictionary[@"clicks"];
    }
    if(![dictionary[@"g_catgryname"] isKindOfClass:[NSNull class]]){
        self.gCatgryname = dictionary[@"g_catgryname"];
    }
    if(![dictionary[@"gcryid"] isKindOfClass:[NSNull class]]){
        self.gcryid = dictionary[@"gcryid"];
    }
    if(![dictionary[@"sales"] isKindOfClass:[NSNull class]]){
        self.sales = dictionary[@"sales"];
    }
    if(![dictionary[@"symbol_pic"] isKindOfClass:[NSNull class]]){
        self.symbolPic = dictionary[@"symbol_pic"];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.clicks != nil){
        dictionary[@"clicks"] = self.clicks;
    }
    if(self.gCatgryname != nil){
        dictionary[@"g_catgryname"] = self.gCatgryname;
    }
    if(self.gcryid != nil){
        dictionary[@"gcryid"] = self.gcryid;
    }
    if(self.sales != nil){
        dictionary[@"sales"] = self.sales;
    }
    if(self.symbolPic != nil){
        dictionary[@"symbol_pic"] = self.symbolPic;
    }
    return dictionary;
    
}

@end
