//
//  MyAccount.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/15.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyAccount : NSObject<NSCoding>
//返回值字段	字段类型	字段说明

//当前授权用户的UID。
@property(nonatomic,copy) NSString * userid;
//用户名字
@property(nonatomic,copy) NSString * name;
//当前余额。
@property(nonatomic,copy) NSString * remain;
//用户好友
@property(nonatomic,copy) NSString * friends;
//用户收藏
@property(nonatomic,copy) NSString * collect;
//当前店铺id。
@property(nonatomic,copy) NSString * storeid;
//当前用户头像。
@property(nonatomic,copy) NSString * photo;
//当前guade_name。
@property(nonatomic,copy) NSString * grade_name;
//当前代金券。
@property(nonatomic,copy) NSString * points;
//当前积分。
@property(nonatomic,copy) NSString * jf;

+(instancetype)accountWithDic:(NSDictionary *)dic;
@end
