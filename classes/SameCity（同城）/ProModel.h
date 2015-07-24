//
//  ProModel.h
//  exexex
//
//  Created by allenariel on 15/6/30.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProModel : NSObject<NSCoding>
@property(nonatomic,copy)NSString *provid;
@property(nonatomic,copy)NSString *province;
@property(nonatomic,copy)NSString *operatime;
@property(nonatomic,copy)NSString *parentid;
@property(nonatomic,copy)NSArray *son;

@property(nonatomic,copy)NSMutableArray *cities;
@property(nonatomic,assign)BOOL open;
@end
