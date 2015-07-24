//
//  IntegralModel.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/18.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntegralModel : NSObject
/***  好友头像 */
@property(nonatomic,copy)NSString * tradeid;

/***  好友名字   */
@property(nonatomic,copy)NSString * userid;
/***  other——userid   */
@property(nonatomic,copy)NSString * jftitle;

/***  好友头像 */
@property(nonatomic,copy)NSString * tradename;

/***  好友名字   */
@property(nonatomic,copy)NSString * jftype;
/***  other——userid   */
@property(nonatomic,copy)NSString * operatime;
/***  other——userid   */
@property(nonatomic,copy)NSString * type_value;

/***  好友名字   */
@property(nonatomic,copy)NSString * jfid;
/***  other——userid   */
@property(nonatomic,copy)NSString * jf;

@end
