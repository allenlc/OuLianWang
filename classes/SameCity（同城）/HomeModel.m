//
//  HomeModel.m
//  OuLianWang
//
//  Created by hsmj on 15/7/14.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel
-(instancetype)init
{
    if (self=[super init]) {
        self.goodsArray=[NSMutableArray array];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
