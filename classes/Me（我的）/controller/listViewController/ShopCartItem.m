//
//  ShopCartItem.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/24.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "ShopCartItem.h"

@implementation ShopCartItem
+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    ShopCartItem * item = [[ShopCartItem alloc]init];
//    item.mainTitle = title;
//    item.icon = icon;
    return item;
}
+(instancetype )itemWithTitle:(NSString *)title
{
    return [self itemWithTitle:title icon:nil];
}
@end
