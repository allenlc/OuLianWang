//
//  LeiBModel.h
//  OuLianWang
//
//  Created by hsmj on 15/7/10.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeiBModel : NSObject

@property (nonatomic, strong) NSString * clicks;
@property (nonatomic, copy) NSString * gCatgryname;
@property (nonatomic, strong) NSString * gcryid;
@property (nonatomic, strong) NSString * sales;
@property (nonatomic, strong) NSString * symbolPic;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
