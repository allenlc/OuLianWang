//
//  MyAccountTool.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/15.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MyAccount;
@interface MyAccountTool : NSObject
/**
 *  存储帐号
 */
+ (void)save:(MyAccount *)account;

/**
 *  读取帐号
 */
+ (MyAccount *)account;
@end
