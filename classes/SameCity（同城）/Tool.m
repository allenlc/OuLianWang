//
//  Tool.m
//  BirdMovie
//
//  Created by 夏威夷man on 15-4-26.
//  Copyright (c) 2015年 夏威夷man. All rights reserved.
//

#import "Tool.h"

@implementation Tool
- (void)createModelCodeWithDict:(NSDictionary *)dict andName:(NSString *)name{
    printf("\n@interface %s: NSObject\n",name.UTF8String);
    for (NSString *key in dict) {
        printf("@property (copy,nonatomic) NSString *%s;\n",key.UTF8String);
    }
    printf("@end\n");
}
- (NSDictionary *)exchangeDictWithModel:(JuHeCityModel *)model{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:model.id forKey:@"id"];
    [dict setValue:model.city_name forKey:@"city_name"];
    [dict setValue:model.city_pre forKey:@"city_pre"];
    [dict setValue:model.city_pinyin forKey:@"city_pinyin"];
    [dict setValue:model.city_short forKey:@"city_short"];
    [dict setValue:model.count forKey:@"count"];
    [dict setValue:model.latitude forKey:@"latitude"];
    [dict setValue:model.longtitude forKey:@"longtitude"];
    return dict;
}

@end
