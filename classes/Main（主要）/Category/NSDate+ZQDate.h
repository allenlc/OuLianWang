//
//  NSDate+ZQDate.h
//  ZQ微博
//
//  Created by Ibokan on 15/4/20.
//  Copyright (c) 2015年 HZQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZQDate)
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;
@end
