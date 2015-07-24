//
//  ApplyTableViewCell.m
//  OuLianWang
//
//  Created by allenariel on 15/6/18.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "ApplyTableViewCell.h"
#import "UIView+LCView.h"

@implementation ApplyTableViewCell

//identify
+(NSString *)myIdentify
{
    return @"applycell";
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
    self.iconImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 46, 46)];
    [self.contentView addSubview:self.iconImageView];
    
    self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(67, 0, 200, 30)];
    self.nameLabel.font=[UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:self.nameLabel];

    self.lineImageView=[self.contentView addImageViewWithFrame:CGRectMake(66, 30, 200, 1) image:@"lineline.png"];
    
    self.moreLabel=[[UILabel alloc]initWithFrame:CGRectMake(67, 30, 200, 30)];
    self.moreLabel.textColor=[UIColor grayColor];
    self.moreLabel.font=[UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.moreLabel];
    
    self.lookImageView=[self.contentView addImageViewWithFrame:CGRectMake(255, 5, 50, 50) image:nil];
}
@end
