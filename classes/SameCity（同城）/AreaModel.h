//
//  AreaModel.h
//  exexex
//
//  Created by allenariel on 15/6/30.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaModel : NSObject<NSCoding>
@property(nonatomic,copy)NSString *areaid;
@property(nonatomic,copy)NSString *area;
@property(nonatomic,copy)NSString *operatime;
@property(nonatomic,copy)NSString *cityid;
@property(nonatomic,strong)NSString *provid;
@end
