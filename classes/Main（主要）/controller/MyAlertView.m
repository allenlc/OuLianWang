//
//  MyAlertView.m
//  OuLianWang
//
//  Created by allenariel on 15/7/13.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "MyAlertView.h"

@implementation MyAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    if (self=[super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles,nil]) {
        [self createUI];
        
    }
    return self;
}
-(instancetype)init
{
    if (self=[super init]) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    self.title=@"更新提示";
    CGRect rect=self.frame;
    UIImageView *tsImageView=[[UIImageView alloc]initWithFrame:CGRectMake(rect.size.width/2-50, 5, 15, 15)];
    tsImageView.image=[UIImage imageNamed:@"prompt.png"];
}

@end
