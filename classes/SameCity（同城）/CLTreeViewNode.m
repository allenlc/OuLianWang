//
//  CLTreeViewNode.m
//  CLTreeView
//
//  Created by 钟由 on 14-9-9.
//  Copyright (c) 2014年 flywarrior24@163.com. All rights reserved.
//

#import "CLTreeViewNode.h"

@implementation CLTreeViewNode
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.nodeData forKey:@"nodeData"];
    [aCoder encodeObject:self.sonNodes forKey:@"sonNodes"];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        self.nodeData=[aDecoder decodeObjectForKey:@"nodeData"];
        self.sonNodes=[aDecoder decodeObjectForKey:@"sonNodes"];
    }
    return self;
}

@end
