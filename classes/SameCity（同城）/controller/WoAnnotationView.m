//
//  WoAnnotationView.m
//  OuLianWang
//
//  Created by allenariel on 15/6/23.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "WoAnnotationView.h"
//#import "WoAnnotation.h"

@interface WoAnnotationView ()
{
    UIView *_backView;
}
@property(nonatomic,weak)UIImageView *iconView;
@end

@implementation WoAnnotationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    self.canShowCallout=YES;
    self.centerOffset=CGPointMake(0, -22);
    self.calloutOffset=CGPointMake(-10, 0);
    //设置掉下效果
    self.annoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, -400, 44, 44)];
    _annoImageView.image=[UIImage imageNamed:@"marker_inside_pink.png"];
    [self addSubview:_annoImageView];
    
    [UIView animateWithDuration:0.5 animations:^{
        _annoImageView.frame=CGRectMake(0, 0, 30, 47);
    }];
    //设置气泡
    self.logoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 57, 57)];
    self.leftCalloutAccessoryView=self.logoImageView;
    self.logoImageView.userInteractionEnabled=YES;
    
    UIImageView *biaoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 20)];
    biaoImageView.image=[UIImage imageNamed:@"huoyuanjinrudianpujiantou.png"];
    biaoImageView.userInteractionEnabled=YES;
    self.rightCalloutAccessoryView=biaoImageView;
    
    //点击手势
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [self.logoImageView addGestureRecognizer:tap];

    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [biaoImageView addGestureRecognizer:tap2];
   

}

#pragma mark - tapClick
-(void)tapClick:(UITapGestureRecognizer *)tap
{
    self.mapBlcok(self.model);

}


@end
