//
//  HotXHModel.h
//  OuLianWang
//
//  Created by hsmj on 15/7/15.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotXHModel : NSObject

@property (nonatomic, strong) NSString * operatime;
@property (nonatomic, strong) NSString * promImg;
@property (nonatomic, strong) NSString * promid;
@property (nonatomic, strong) NSString * storeid;
@property (nonatomic, strong) NSString * title;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end
