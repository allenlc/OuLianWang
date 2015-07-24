//
//  WDHJTableViewCell.m
//  OuLianWang
//
//  Created by allenariel on 15/6/24.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "WDHJTableViewCell.h"
#import "UIView+LCView.h"

@implementation WDHJTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(CGFloat)myHeight
{
    return 90;
}
+(NSString *)myIdentify
{
    return @"wdhjcell";
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


    [self.contentView addImageViewWithFrame:CGRectMake(0, 0, 320, 1) image:@"fengeline"];
    //图标
    self.iconImageView=[self.contentView addImageViewWithFrame:CGRectMake(5, 5, 70, 70) image:nil];
    //名字
    self.nameLabel=[self.contentView addLabelWithFrame:CGRectMake(80, 0, 200, 30) text:nil];
    self.nameLabel.font=[UIFont boldSystemFontOfSize:15];
    //营业执照
    self.licenceView=[[UIView alloc]initWithFrame:CGRectMake(80, 25, 150, 60)];
    UILabel *lab1=[self.licenceView addLabelWithFrame:CGRectMake(0, 0, 85, 20) text:@"营业执照已认证"];
    lab1.font=[UIFont systemFontOfSize:12];
    lab1.textColor=[UIColor grayColor];
    self.dateLabel=[self.licenceView addLabelWithFrame:CGRectMake(0, 15, 85, 20) text:nil];
    self.dateLabel.font=[UIFont systemFontOfSize:12];
    _dateLabel.textColor=[UIColor grayColor];
    _dateLabel.textAlignment=NSTextAlignmentRight;
    [self.licenceView addImageViewWithFrame:CGRectMake(90, 10, 30, 20) image:@"认证.png"];
    UILabel *lab2=[self.licenceView addLabelWithFrame:CGRectMake(0, 30, 30, 20) text:@"好评:"];
    lab2.font=[UIFont systemFontOfSize:12];
    self.starView=[[StarView alloc]initWithFrame:CGRectMake(35, 33, 100, 30)];
    [self.licenceView addSubview:self.starView];
    [self.contentView addSubview:self.licenceView];
    //商店
    self.shopImageView=[self.contentView addImageViewWithFrame:CGRectMake(260, 10, 40, 40) image:nil];
    self.shopLabel=[self.contentView addLabelWithFrame:CGRectMake(200, 55, 120, 15) text:nil];
    self.shopLabel.font=[UIFont systemFontOfSize:10];
    self.shopLabel.textColor=[UIColor grayColor];
    self.shopLabel.textAlignment=NSTextAlignmentCenter;

}
@end
