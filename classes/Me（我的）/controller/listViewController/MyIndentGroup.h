//
//  MyIndentGroup.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/24.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyIndentGroup : NSObject
@property(nonatomic,copy)NSString * storename;
@property(nonatomic,copy)NSArray * goods;
@property(nonatomic,strong)NSMutableArray * items;
+(instancetype)group;
@end
