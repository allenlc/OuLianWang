//
//  CityModel.m
//  exexex
//
//  Created by allenariel on 15/6/30.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.operatime forKey:@"operatime"];
    [aCoder encodeObject:self.g_son forKey:@"g_son"];
    [aCoder encodeObject:self.city forKey:@"city"];
    [aCoder encodeObject:self.provid forKey:@"provid"];
    [aCoder encodeObject:self.cityid forKey:@"cityid"];
    [aCoder encodeObject:self.areas forKey:@"areas"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        self.operatime=[aDecoder decodeObjectForKey:@"operatime"];
        self.g_son=[aDecoder decodeObjectForKey:@"g_son"];
        self.city=[aDecoder decodeObjectForKey:@"city"];
        self.provid=[aDecoder decodeObjectForKey:@"provid"];
        self.cityid=[aDecoder decodeObjectForKey:@"cityid"];
        self.areas=[aDecoder decodeObjectForKey:@"areas"];

    }
    return self;
}

@end
