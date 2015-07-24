//
//  BalanceCellMOdel.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/18.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BalanceCellMOdel : NSObject
/***  recevieid */
@property(nonatomic,copy)NSString * recevieid;

/***  pwid  */
@property(nonatomic,copy)NSString * pwid;
/***  ctitle   */
@property(nonatomic,copy)NSString * ctitle;

/***  tradename */
@property(nonatomic,copy)NSString * tradename;

/*** money   */
@property(nonatomic,copy)NSString * state;
/*** state   */
@property(nonatomic,copy)NSString * tradeid;
/***  style   */
@property(nonatomic,copy)NSString * type_value;

/***  creattime  */
@property(nonatomic,copy)NSString * consid;

/***  tradename */
@property(nonatomic,copy)NSString * money;

/*** money   */
@property(nonatomic,copy)NSString * creattime;
/*** state   */
@property(nonatomic,copy)NSString * userid;

@end
