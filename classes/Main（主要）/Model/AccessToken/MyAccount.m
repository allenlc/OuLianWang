//
//  MyAccount.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/15.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "MyAccount.h"

@implementation MyAccount
+(instancetype)accountWithDic:(NSDictionary *)dic
{
    MyAccount * account = [[self alloc]init];
    account.userid = dic[@"userid"];
    account.name = dic[@"name"];
    account.remain = dic[@"remain"];
    account.friends = dic[@"friends"];
    account.collect = dic[@"collect"];
    account.jf = dic[@"jf"];
    account.photo = dic[@"photo"];
    account.storeid = dic[@"storeid"];
    account.points = dic[@"points"];
    account.grade_name = dic[@"grade_name"];
    return account;
}

/**
 *  当从文件中解析出一个对象的时候调用
 *  在这个方法中写清楚：怎么解析文件中的数据
 */
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {

        self.userid =[aDecoder decodeObjectForKey:@"userid"];
        self.name =[aDecoder decodeObjectForKey:@"name"];
        self.remain =[aDecoder decodeObjectForKey:@"remain"];
        self.friends =[aDecoder decodeObjectForKey:@"friends"];
        self.collect =[aDecoder decodeObjectForKey:@"collect"];
        self.jf =[aDecoder decodeObjectForKey:@"jf"];
        self.photo =[aDecoder decodeObjectForKey:@"photo"];
        self.storeid =[aDecoder decodeObjectForKey:@"storeid"];
        self.points =[aDecoder decodeObjectForKey:@"points"];
        self.grade_name =[aDecoder decodeObjectForKey:@"grade_name"];
    }
    return self;
}
/**
 *  将对象写入文件的时候调用
 *  在这个方法中写清楚：要存储哪些对象的哪些属性，以及怎样存储属性
 */
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userid forKey:@"userid"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.remain forKey:@"remain"];
    [aCoder encodeObject:self.friends forKey:@"friends"];
    [aCoder encodeObject:self.collect forKey:@"collect"];
    [aCoder encodeObject:self.jf forKey:@"jf"];
    [aCoder encodeObject:self.photo forKey:@"photo"];
    [aCoder encodeObject:self.storeid forKey:@"storeid"];
    [aCoder encodeObject:self.points forKey:@"points"];
    [aCoder encodeObject:self.grade_name forKey:@"grade_name"];
}

@end
