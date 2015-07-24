//
//  Tool.h
//  BirdMovie
//
//  Created by 夏威夷man on 15-4-26.
//  Copyright (c) 2015年 夏威夷man. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JuHeCityModel.h"
@interface Tool : NSObject
- (void)createModelCodeWithDict:(NSDictionary *)dict andName:(NSString *)name;
- (NSDictionary *)exchangeDictWithModel:(JuHeCityModel *)model;
@end
