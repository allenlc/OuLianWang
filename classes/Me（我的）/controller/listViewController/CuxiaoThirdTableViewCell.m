//
//  CuxiaoThirdTableViewCell.m
//  OuLianWang
//
//  Created by allenariel on 15/7/6.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "CuxiaoThirdTableViewCell.h"
#import "UIView+LCView.h"

@implementation CuxiaoThirdTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(NSString *)myIdentify
{
    return @"CuxiaoThirdTableViewCell";
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
    self.iconImageView=[self.contentView addImageViewWithFrame:CGRectMake(15, 10, 80, 80) image:nil];
    
    self.nameLabel=[self.contentView addLabelWithFrame:CGRectMake(105, 10, 150, 20) text:nil];
    _nameLabel.font=[UIFont boldSystemFontOfSize:16];
    
    self.moreLabel=[self.contentView addLabelWithFrame:CGRectMake(105, 40, 180, 10) text:nil];
    _moreLabel.font=[UIFont systemFontOfSize:14];
    _moreLabel.textColor=[UIColor grayColor];
    
    self.dictanceLabel=[self.contentView addLabelWithFrame:CGRectMake(105, 70, 80, 15) text:nil];
    _dictanceLabel.font=[UIFont systemFontOfSize:14];
    _dictanceLabel.textColor=[UIColor grayColor];
    
    [self.contentView addImageViewWithFrame:CGRectMake(170, 65, 20, 25) image:@"jhs_tb.png"];
}
@end
