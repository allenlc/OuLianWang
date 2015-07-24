//
//  HotDModel.m
//  OuLianWang
//
//  Created by hsmj on 15/7/14.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "HotDModel.h"

@implementation HotDModel
/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[@"code"] isKindOfClass:[NSNull class]]){
        self.code = dictionary[@"code"];
    }
    if(dictionary[@"comment"] != nil && ![dictionary[@"comment"] isKindOfClass:[NSNull class]]){
        NSArray * commentDictionaries = dictionary[@"comment"];
        NSMutableArray * commentItems = [NSMutableArray array];
        for(NSDictionary * commentDictionary in commentDictionaries){
            NSDictionary * commentItem = [[NSDictionary alloc] initWithDictionary:commentDictionary];
            [commentItems addObject:commentItem];
        }
        self.comment = commentItems;
    }
    if(dictionary[@"goodspic"] != nil && ![dictionary[@"goodspic"] isKindOfClass:[NSNull class]]){
        NSArray * goodspicDictionaries = dictionary[@"goodspic"];
        NSMutableArray * goodspicItems = [NSMutableArray array];
        for(NSDictionary * goodspicDictionary in goodspicDictionaries){
            NSDictionary * goodspicItem = [[NSDictionary alloc] initWithDictionary:goodspicDictionary];
            [goodspicItems addObject:goodspicItem];
        }
        self.goodspic = goodspicItems;
    }
    if(![dictionary[@"list"] isKindOfClass:[NSNull class]]){
        self.list = [[NSDictionary alloc] initWithDictionary:dictionary[@"list"]];
    }
    
    if(![dictionary[@"message"] isKindOfClass:[NSNull class]]){
        self.message = dictionary[@"message"];
    }
    if(dictionary[@"resource"] != nil && ![dictionary[@"resource"] isKindOfClass:[NSNull class]]){
        NSArray * resourceDictionaries = dictionary[@"resource"];
        NSMutableArray * resourceItems = [NSMutableArray array];
        for(NSDictionary * resourceDictionary in resourceDictionaries){
            NSDictionary * resourceItem = [[NSDictionary alloc] initWithDictionary:resourceDictionary];
            [resourceItems addObject:resourceItem];
        }
        self.resource = resourceItems;
    }
    if(![dictionary[@"video"] isKindOfClass:[NSNull class]]){
        self.video = [[NSDictionary alloc] initWithDictionary:dictionary[@"video"]];
    }
    
    return self;
}


@end
