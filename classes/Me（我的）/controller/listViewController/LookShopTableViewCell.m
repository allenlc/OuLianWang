//
//  LookShopTableViewCell.m
//  OuLianWang
//
//  Created by allenariel on 15/7/7.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "LookShopTableViewCell.h"
#import "UIView+LCView.h"

@implementation LookShopTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(NSString *)myIdentify
{
    return @"LookShopTableViewCell";
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
    self.iconImageView=[self.contentView addImageViewWithFrame:CGRectMake(10, 10, 60, 60) image:nil];
    self.iconImageView.layer.cornerRadius=8;
    
    self.nameLabel=[self.contentView addLabelWithFrame:CGRectMake(80, 10, 140, 25) text:nil];
    self.nameLabel.font=[UIFont systemFontOfSize:18];
    
    self.timeLabel=[self.contentView addLabelWithFrame:CGRectMake(80, 45, 140, 15) text:nil];
    self.timeLabel.font=[UIFont systemFontOfSize:14];
    self.timeLabel.textColor=[UIColor grayColor];
    
//    UIButton *chatBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    chatBtn.frame=CGRectMakeEx(220, 15, 30, 60);
//    [chatBtn setImage:[UIImage imageNamed:@"xiaoxi.png"] forState:UIControlStateNormal];
//    [chatBtn setTitle:@"聊天" forState:UIControlStateNormal];
    UIImageView *xiaoxiImageView=[self.contentView addImageViewWithFrame:CGRectMake(220, 15, 30, 30) image:@"xiaoxi.png"];
    UITapGestureRecognizer *tt1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(xiaoxiClick)];
    [xiaoxiImageView addGestureRecognizer:tt1];
    UILabel *xiaoiLabel=[self.contentView addLabelWithFrame:CGRectMake(220, 50, 30, 15) text:@"消息"];
    xiaoiLabel.textAlignment=NSTextAlignmentCenter;
    xiaoiLabel.font=[UIFont systemFontOfSize:12];

    [self.contentView addImageViewWithFrame:CGRectMake(275, 15, 30, 30) image:@"dianhua.png"];
    UITapGestureRecognizer *tt2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dianhuaClick)];
    [xiaoxiImageView addGestureRecognizer:tt2];

    UILabel *dianhLabel=[self.contentView addLabelWithFrame:CGRectMake(270, 50, 30, 15) text:@"电话"];
    dianhLabel.font=[UIFont systemFontOfSize:12];
    dianhLabel.textAlignment=NSTextAlignmentCenter;

}
-(void)xiaoxiClick
{
    self.chatBlock();
}
-(void)dianhuaClick
{
    self.callBlock();
}
@end
