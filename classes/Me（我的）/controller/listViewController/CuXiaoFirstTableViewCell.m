//
//  CuXiaoFirstTableViewCell.m
//  OuLianWang
//
//  Created by allenariel on 15/7/6.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "CuXiaoFirstTableViewCell.h"
#import "UIView+LCView.h"

@implementation CuXiaoFirstTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(NSString *)myIdentify
{
    return @"CuXiaoFirstTableViewCell";
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
    self.iconImageView=[self.contentView addImageViewWithFrame:CGRectMake(10, 10, 80, 80) image:nil];
    
    self.nameLabel=[self.contentView addLabelWithFrame:CGRectMake(105, 5, 200, 45) text:nil];
    _nameLabel.font=[UIFont systemFontOfSize:16];
    _nameLabel.numberOfLines=0;
    
    self.moreLabel=[self.contentView addLabelWithFrame:CGRectMake(105, 70, 240, 15) text:nil];
    _moreLabel.font=[UIFont systemFontOfSize:14];
    _moreLabel.textColor=[UIColor grayColor];
}


@end
