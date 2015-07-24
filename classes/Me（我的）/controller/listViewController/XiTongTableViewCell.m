//
//  XiTongTableViewCell.m
//  OuLianWang
//
//  Created by allenariel on 15/6/24.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "XiTongTableViewCell.h"
#import "UIView+LCView.h"

@implementation XiTongTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(CGFloat)myHeight
{
    return 60;
}
+(NSString *)myIdentify
{
    return @"xitongCell";
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
    self.iconImageView=[self.contentView addImageViewWithFrame:CGRectMake(5, 5, 50, 50) image:nil];
    self.namaLabel=[self.contentView addLabelWithFrame:CGRectMake(75, 5, 200, 50) text:nil];
    
}
@end
