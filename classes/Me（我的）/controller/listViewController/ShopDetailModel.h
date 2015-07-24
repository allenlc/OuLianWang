//
//  ShopDetailModel.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/10.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopDetailModel : NSObject
/***店铺名字   */
@property(nonatomic,copy)NSString * storename;
/***电话号码   */
@property(nonatomic,copy)NSString * telephone;
/***店铺简介   */
@property(nonatomic,copy)NSString * information;
/***   */
@property(nonatomic,copy)NSString * gateimg;
/*** address  */
@property(nonatomic,copy)NSString * address;
/***businessimg   */
@property(nonatomic,copy)NSString * businessimg;
/***店铺logo   */
@property(nonatomic,copy)NSString * logo;
/***店铺storeid   */
@property(nonatomic,copy)NSString * storeid;
/***店铺manager   */
@property(nonatomic,copy)NSString * manager;
/***店铺businessIf   */
@property(nonatomic,copy)NSString * businessIf;
/***shop_photo   */
@property(nonatomic,copy)NSArray * shop_photo;
/***店铺review_list   */
@property(nonatomic,copy)NSArray * review_list;
/***店铺custom_list   */
@property(nonatomic,copy)NSArray * custom_list;

/***店铺operatime   */
@property(nonatomic,copy)NSString * operatime;



@end
