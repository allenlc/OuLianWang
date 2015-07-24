//
//  ShopCardGroup.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/24.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCardGroup : NSObject
@property(nonatomic,copy)NSString * storename;
@property(nonatomic,copy)NSString * storeid;
@property(nonatomic,copy)NSArray * goods;
@property(nonatomic,strong)NSMutableArray * items;
@property(nonatomic,assign)BOOL  isSelect;
+(instancetype)group;
@end
