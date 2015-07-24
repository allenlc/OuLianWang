//
//  ProModel.m
//  exexex
//
//  Created by allenariel on 15/6/30.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "ProModel.h"

@implementation ProModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
//y(nonatomic,copy)NSString *provid;
//@property(nonatomic,copy)NSString *province;
//@property(nonatomic,copy)NSString *operatime;
//@property(nonatomic,copy)NSString *parentid;
//@property(nonatomic,copy)NSArray *son;
//
//@property(nonatomic,copy)NSMutableArray *cities;

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.province forKey:@"province"];
    [aCoder encodeObject:self.provid forKey:@"provid"];
    [aCoder encodeObject:self.operatime forKey:@"operatime"];
    [aCoder encodeObject:self.parentid forKey:@"parentid"];
    [aCoder encodeObject:self.son forKey:@"son"];
    [aCoder encodeObject:self.cities forKey:@"cities"];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        self.province=[aDecoder decodeObjectForKey:@"province"];
        self.provid=[aDecoder decodeObjectForKey:@"provid"];
        self.operatime=[aDecoder decodeObjectForKey:@"operatime"];
        self.parentid=[aDecoder decodeObjectForKey:@"parentid"];
        self.son=[aDecoder decodeObjectForKey:@"son"];
        self.cities=[aDecoder decodeObjectForKey:@"cities"];
    }
    return self;
}
@end
