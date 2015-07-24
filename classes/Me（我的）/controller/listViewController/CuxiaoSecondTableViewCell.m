//
//  CuxiaoSecondTableViewCell.m
//  OuLianWang
//
//  Created by allenariel on 15/7/6.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "CuxiaoSecondTableViewCell.h"
#import "UIView+LCView.h"

@implementation CuxiaoSecondTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(NSString *)myIdentify
{
    return @"CuxiaoSecondTableViewCell";
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
    self.nameLabel=[self.contentView addLabelWithFrame:CGRectMake(10, 10, 300, 30) text:nil];
    _nameLabel.font=[UIFont boldSystemFontOfSize:18];
    
    self.moreLabel=[self.contentView addLabelWithFrame:CGRectMake(10, 40, 300, 20) text:nil];
    _moreLabel.textColor=[UIColor grayColor];
    _moreLabel.font=[UIFont systemFontOfSize:14];
    
}

@end
