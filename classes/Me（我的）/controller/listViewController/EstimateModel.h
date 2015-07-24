//
//  EstimateModel.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/13.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EstimateModel : NSObject
/***  userid   */
@property(nonatomic,copy)NSString * userid;
/***   */
@property(nonatomic,copy)NSString * grid;
/*** 名字   */
@property(nonatomic,copy)NSString * username;
/*** 头像   */
@property(nonatomic,copy)NSString * photo;
/***评价时间   */
@property(nonatomic,copy)NSString * time;
/***评价内容   */
@property(nonatomic,copy)NSString * content;

@end
