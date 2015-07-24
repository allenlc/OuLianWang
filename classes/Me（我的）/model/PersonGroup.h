//
//  PersonGroup.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/23.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonGroup : NSObject
@property(nonatomic,copy)NSString * groupHeader;
@property(nonatomic,copy)NSString * groupFooter;
@property(nonatomic,copy)NSArray * items;
+(instancetype)group;
@end
