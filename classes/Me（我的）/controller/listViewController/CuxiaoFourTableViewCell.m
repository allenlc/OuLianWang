//
//  CuxiaoFourTableViewCell.m
//  OuLianWang
//
//  Created by allenariel on 15/7/7.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "CuxiaoFourTableViewCell.h"
#import "UIView+LCView.h"

@implementation CuxiaoFourTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(NSString *)myIdentify
{
    return @"CuxiaoFourTableViewCell";
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
    self.nameLabel=[self.contentView addLabelWithFrame:CGRectMake(15, 10, 180, 35) text:nil];
    _nameLabel.font=[UIFont boldSystemFontOfSize:16];
    
    self.moreLabel=[self.contentView addLabelWithFrame:CGRectMake(15, 40, 180, 35) text:nil];
    _moreLabel.font=[UIFont systemFontOfSize:14];
    _moreLabel.textColor=[UIColor grayColor];
    
    self.manyPeopleLabel=[self.contentView addLabelWithFrame:CGRectMake(220, 10, 80, 35) text:nil];
    _manyPeopleLabel.font=[UIFont systemFontOfSize:14];
    _manyPeopleLabel.textColor=[UIColor yellowColor];
    
    [self.contentView addImageViewWithFrame:CGRectMake(220, 40, 80, 30) image:@"获奖详情.png"];
    
}
@end
