//
//  ShopCartItem.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/24.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCartItem : NSObject
//图片
@property(nonatomic,copy)NSString * goodsname;
//描述
@property(nonatomic,copy)NSString * pfprice;
//商品数量
@property(nonatomic,copy)NSString * goods_thumb;
//价格
@property(nonatomic,copy)NSString * factoryid;
//状态
@property(nonatomic,copy)NSString * storeid;
//单号
@property(nonatomic,copy)NSString * alpid;
//时间
@property(nonatomic,copy)NSString * goods_attr;
//删除
@property(nonatomic,copy)NSString * zprate;
//评价
@property(nonatomic,copy)NSString * cprate;
//取消
@property(nonatomic,copy)NSString * gname;

//状态
@property(nonatomic,copy)NSString * akind_id;
//单号
@property(nonatomic,copy)NSString * gdiscount;
//时间
@property(nonatomic,copy)NSString * unit;
//删除
@property(nonatomic,copy)NSString * gid;
//评价
@property(nonatomic,copy)NSString * is_attached;
//取消
@property(nonatomic,copy)NSString * is_show;
//状态
@property(nonatomic,copy)NSString * total;
//单号
@property(nonatomic,copy)NSString * operatime;
//时间
@property(nonatomic,copy)NSString * price;
//删除
@property(nonatomic,copy)NSString * stid;
//评价
@property(nonatomic,copy)NSString * gcryid;
//取消
@property(nonatomic,copy)NSString * hprate;

//取消
@property(nonatomic,copy)NSString * gimgid;
//状态
@property(nonatomic,copy)NSString * goods_desc;
//单号
@property(nonatomic,copy)NSString * is_book;
//时间
@property(nonatomic,copy)NSString * brandname;
//删除
@property(nonatomic,copy)NSString * inventory;
//评价
@property(nonatomic,copy)NSString * goods_img;
//取消
@property(nonatomic,copy)NSString * sales;

//单号
@property(nonatomic,copy)NSString * userid;
//时间
@property(nonatomic,copy)NSString * clicks;
//删除
@property(nonatomic,copy)NSString * number;
//评价
@property(nonatomic,copy)NSString * carid;
//取消
@property(nonatomic,copy)NSString * goodsid;
//取消
@property(nonatomic,copy)NSString * fare;

//
@property(nonatomic,assign)BOOL isSelect;

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;
+(instancetype )itemWithTitle:(NSString *)title ;
@end
