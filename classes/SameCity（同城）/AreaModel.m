//
//  AreaModel.m
//  exexex
//
//  Created by allenariel on 15/6/30.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "AreaModel.h"

@implementation AreaModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.area forKey:@"area"];
    [aCoder encodeObject:self.operatime forKey:@"operatime"];
    [aCoder encodeObject:self.areaid forKey:@"areaid"];
    [aCoder encodeObject:self.cityid forKey:@"cityid"];
    
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        self.areaid =[aDecoder decodeObjectForKey:@"areaid"];
        self.area=[aDecoder decodeObjectForKey:@"area"];
        self.operatime=[aDecoder decodeObjectForKey:@"operatime"];
        self.cityid=[aDecoder decodeObjectForKey:@"cityid"];
    }
    return self;
}
@end
