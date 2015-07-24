//
//  PersonItem.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/23.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "PersonItem.h"
@implementation PersonItem
+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    PersonItem * item = [[PersonItem alloc]init];
    item.title = title;
    item.icon = icon;
    return item;
}
+(instancetype )itemWithTitle:(NSString *)title andSubTitle:(NSString *)subTitle;
{
    PersonItem * item = [[PersonItem alloc]init];
    item.title = title;
    item.subtitle = subTitle;
    return item;
}
@end
