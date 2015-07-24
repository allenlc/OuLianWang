//
//  ListBtn.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/15.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "ListBtn.h"

@implementation ListBtn

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
                                
        _imgView = [[UIImageView alloc]init];
        _imgView.frame = CGRectMake(5, self.height/2-2, self.width/2-5, self.height/2-5);
        [self addSubview:_imgView];
        
        _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, self.width, self.height/2-5)];
        [self addSubview:_numberLabel];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width/2, self.height/2-3, self.width/2, self.height/2-2)];
        _titleLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:_titleLabel];
       
        
    }
    return self;
}


@end
