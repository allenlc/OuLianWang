//
//  FourthTableViewCell.m
//  OuLianWang
//
//  Created by allenariel on 15/6/19.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "FourthTableViewCell.h"
#import "UIView+LCView.h"

@implementation FourthTableViewCell

+(NSString *)myIdentify
{
    return @"thirdhomecell";
}
+(CGFloat)myHeight
{
    return 190;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        [self createUI];
    }
    return self;
}

-(void)createUI
{
    
    //图片
    self.lookImageView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 157, 150)];
    self.lookImageView1.userInteractionEnabled=YES;
    [self.contentView addSubview:_lookImageView1];
    
    self.lookImageView2=[[UIImageView alloc]initWithFrame:CGRectMake(163, 0, 157, 150)];
    self.lookImageView2.userInteractionEnabled=YES;

    [self.contentView addSubview:_lookImageView2];
   
    //手势点击
    UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap1Click:)];
    [self.lookImageView1 addGestureRecognizer:tap1];
    
    
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap2Click:)];
    [self.lookImageView2 addGestureRecognizer:tap2];

//    UITapGestureRecognizer *tap3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap3Click:)];
//   

    //名称
    self.nameLabel1=[self.contentView addLabelWithFrame:CGRectMake(0, 150, 150, 20) text:nil];
    self.nameLabel1.font=[UIFont systemFontOfSize:13];
    
    self.nameLabel2=[self.contentView addLabelWithFrame:CGRectMake(170, 150, 150, 20) text:nil];
    self.nameLabel2.font=[UIFont systemFontOfSize:12];

    //价钱
    self.priceLabel1=[self.contentView addLabelWithFrame:CGRectMake(0, 170, 150, 20) text:nil];
    self.priceLabel1.textColor=[UIColor redColor];
    self.priceLabel1.font=[UIFont systemFontOfSize:13];
    
    
    self.priceLabel2=[self.contentView addLabelWithFrame:CGRectMake(170, 170, 150, 20) text:nil];
    self.priceLabel2.textColor=[UIColor redColor];
    self.priceLabel2.font=[UIFont systemFontOfSize:13];

}

-(void)tap1Click:(UITapGestureRecognizer *)tap
{
    self.tapBlock1();
}
-(void)tap2Click:(UITapGestureRecognizer *)tap
{
    self.tapBlock2();
}
//
//-(void)tap3Click:(UITapGestureRecognizer *)tap
//{
//    self.tapBlock3();
//}

@end
