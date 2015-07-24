//
//  PersonItem.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/23.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonItem : NSObject
@property(nonatomic,copy)NSString * icon;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * subtitle;

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;
+(instancetype )itemWithTitle:(NSString *)title andSubTitle:(NSString *)subTitle;
@end
