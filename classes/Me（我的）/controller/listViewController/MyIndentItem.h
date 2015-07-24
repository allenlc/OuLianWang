//
//  MyIndentItem.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/24.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyIndentItem : NSObject
//图片
@property(nonatomic,copy)NSString * orderid;
//描述
@property(nonatomic,copy)NSString * catchtime;
//商品数量
@property(nonatomic,copy)NSString * goods_img;
//价格
@property(nonatomic,copy)NSString * total;
//状态
@property(nonatomic,copy)NSString * price;
//单号
@property(nonatomic,copy)NSString * nums;
//时间
@property(nonatomic,copy)NSString * goods_attr;
//删除
@property(nonatomic,copy)NSString * gdiscount;
//评价
@property(nonatomic,copy)NSString * goods_thumb;
//取消
@property(nonatomic,copy)NSString * gname;
//状态
@property(nonatomic,copy)NSString * status;

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;
+(instancetype )itemWithTitle:(NSString *)title ;
@end
