//
//  FirstTableViewCell.m
//  OuLianWang
//
//  Created by hsmj on 15/6/15.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "FirstTableViewCell.h"
#import "UIView+LCView.h"

@implementation FirstTableViewCell
+(CGFloat)myHeight
{
    return 90;
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
    //图标
    self.lookImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 70, 80)];
    [self.contentView addSubview:self.lookImageView];
    
    //名字
    self.nameLabel=[self.contentView addLabelWithFrame:CGRectMake(90, 5, 200, 30) text:nil];
    self.nameLabel.font=[UIFont boldSystemFontOfSize:15];
    //营业执照
    self.licenceView=[[UIView alloc]initWithFrame:CGRectMake(90, 30, 150, 60)];
    UILabel *lab1=[self.licenceView addLabelWithFrame:CGRectMake(0, 0, 85, 20) text:@"营业执照已认证"];
    lab1.font=[UIFont systemFontOfSize:12];
    lab1.textColor=[UIColor grayColor];
    self.dateLabel=[self.licenceView addLabelWithFrame:CGRectMake(0, 17, 85, 20) text:nil];
    self.dateLabel.font=[UIFont systemFontOfSize:12];
    _dateLabel.textColor=[UIColor grayColor];
    _dateLabel.textAlignment=NSTextAlignmentRight;
    [self.licenceView addImageViewWithFrame:CGRectMake(90, 10, 30, 20) image:@"认证.png"];
    UILabel *lab2=[self.licenceView addLabelWithFrame:CGRectMake(0, 35, 30, 20) text:@"好评:"];
    lab2.font=[UIFont systemFontOfSize:12];
    self.starView=[[StarView alloc]initWithFrame:CGRectMake(35, 38, 100, 30)];
    [self.licenceView addSubview:self.starView];
    [self.contentView addSubview:self.licenceView];
    self.nowIsNo=[self.licenceView addLabelWithFrame:CGRectMake(35, 33, 50, 25) text:@"暂无"];
    _nowIsNo.font=[UIFont systemFontOfSize:12];
    _nowIsNo.hidden=YES;
    //down图片
    
   _dituView= [self.contentView addImageViewWithFrame:CGRectMake(270, 35, 25, 25) image:@"down1.png"];
   _lichengLabel=[self.contentView addLabelWithFrame:CGRectMake(260,55,50, 25) text:@""];

}
@end
