//
//  MyAccountTool.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/15.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//
#define ZQAccountFilePath  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

#import "MyAccountTool.h"
#import "MyAccount.h"
@implementation MyAccountTool
+(void)save:(MyAccount*)account
{
    //归档
    [NSKeyedArchiver archiveRootObject:account toFile:ZQAccountFilePath ];
}
+(MyAccount *)account
{
    //读取账号 解挡
    MyAccount * account = [NSKeyedUnarchiver unarchiveObjectWithFile:ZQAccountFilePath];
    //判断账号是否过期
//    NSDate * now = [NSDate date];
//    if ([now compare:account.remind_in] != NSOrderedAscending   ) {
//        account = nil;
//    }
    return account;
}

/**
 NSOrderedAscending = -1L,  升序，越往右边越大
 NSOrderedSame, 相等，一样
 NSOrderedDescending 降序，越往右边越小
 */
@end
