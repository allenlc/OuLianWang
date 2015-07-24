//
//  MyIndentItem.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/24.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "MyIndentItem.h"

@implementation MyIndentItem
+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    MyIndentItem * item = [[MyIndentItem alloc]init];
    item.gname = title;
    item.goods_img = icon;
    return item;
}
+(instancetype )itemWithTitle:(NSString *)title
{
    return [self itemWithTitle:title icon:nil];
}
@end
