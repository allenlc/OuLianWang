//
//  SingleNearCity.m
//  exex
//
//  Created by allenariel on 15/6/26.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "SingleNearCity.h"

static SingleNearCity *sing=nil;
@implementation SingleNearCity

+(instancetype)shareInstance
{
    if (sing==nil) {
        sing=[[SingleNearCity alloc]init];
        sing.nearArray=[NSMutableArray array];
        [sing.nearArray addObjectsFromArray:@[@"北京",@"上海"]];

    }
    return sing;
}



@end
