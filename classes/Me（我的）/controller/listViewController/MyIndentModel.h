//
//  MyIndentModel.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/10.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyIndentModel : NSObject
/***商品名字   */
@property(nonatomic,copy)NSString * userid;
/***pfprice   */
@property(nonatomic,copy)NSString * storeid;
/***rolesid   */
@property(nonatomic,copy)NSString * storename;
/***scid   */
@property(nonatomic,copy)NSString * orderid;
/***goods_thumb   */
@property(nonatomic,copy)NSString * catchtime;
/***ordersid   */
@property(nonatomic,copy)NSString * gname;
/***invoice_fare   */
@property(nonatomic,copy)NSString * goods_attr;
/*** factoryid   */
@property(nonatomic,copy)NSString * price;
/***gdiscount   */
@property(nonatomic,copy)NSString * gdiscount;
/***total   */
@property(nonatomic,copy)NSArray * total;
/***nums   */
@property(nonatomic,copy)NSArray * nums;
/***商品缩略图   */
@property(nonatomic,copy)NSArray * goods_thumb;

/***商品图片   */
@property(nonatomic,copy)NSString * goods_img;

@end
