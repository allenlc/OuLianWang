//
//  CuXiaoButton.m
//  OuLianWang
//
//  Created by allenariel on 15/7/6.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "CuXiaoButton.h"

@implementation CuXiaoButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setCuXiaoBtnWithTitle:(NSString *)title BackNorImage:(NSString *)imgString1 SelectImage:(NSString *)imgString2
{
    self.titleLabel.font=[UIFont systemFontOfSize:16];
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateSelected];
    
    [self setBackgroundImage:[UIImage imageNamed:imgString1] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:imgString2] forState:UIControlStateSelected];

    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

}


@end
