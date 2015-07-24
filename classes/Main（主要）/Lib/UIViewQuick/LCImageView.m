//
//  LCImageView.m
//  OuLianWang
//
//  Created by allenariel on 15/7/18.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "LCImageView.h"

@implementation LCImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init
{
    if (self=[super init]) {
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        self.userInteractionEnabled=YES;
        [self addGestureRecognizer:tap];
    }
    return self;
}
-(void)tapClick
{
    self.myBlock();
    
}
@end

