//
//  HotDModel.h
//  OuLianWang
//
//  Created by hsmj on 15/7/14.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotDModel : NSObject

@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSArray * comment;
@property (nonatomic, strong) NSArray * goodspic;
@property (nonatomic, strong) NSDictionary * list;
@property (nonatomic, strong) NSString * message;
@property (nonatomic, strong) NSArray * resource;
@property (nonatomic, strong) NSDictionary * video;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
