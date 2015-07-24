//
//  CorrectViewController.h
//  OuLianWang
//
//  Created by allenariel on 15/7/23.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//
typedef enum Type
{
    Name,
    PhoneNumber,
    MyAddress,
    HomeAddress,
    Email,
    ChatNumber,
    School,
    Company,
    QQ
}Type;

#import "ListViewController.h"

@interface CorrectViewController : ListViewController
@property(nonatomic,strong)NSString * text;
@property(nonatomic,assign)Type  type;

@end
