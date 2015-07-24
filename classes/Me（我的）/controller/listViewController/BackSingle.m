//
//  BackSingle.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/4.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "BackSingle.h"
static BackSingle *single =nil;
@implementation BackSingle
+(id)shareInstance
{
    if (single==nil) {
        single=[[BackSingle alloc]init];
        single.isBack=NO;
        single.manySms=0;
        single.isFirst=YES;
    }
    return single;
}
@end
