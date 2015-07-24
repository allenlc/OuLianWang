//
//  SingleNearCity.h
//  exex
//
//  Created by allenariel on 15/6/26.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SingleNearCity : NSObject
@property(nonatomic,strong)NSMutableArray *nearArray;
@property(nonatomic,strong)NSString *alreadyLocationCity;

+(instancetype)shareInstance;

@end
