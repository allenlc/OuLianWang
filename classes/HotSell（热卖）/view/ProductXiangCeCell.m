//
//  ProductXiangCeCell.m
//  OuLianWang
//
//  Created by hsmj on 15/6/23.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "ProductXiangCeCell.h"

@implementation ProductXiangCeCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
   
    _JianJieLabel=[[UILabel alloc]initWithFrame:CGRectMake(20,0, 200, 40)];
    _JianJieLabel.textColor=[UIColor redColor];
    [self.contentView  addSubview:_JianJieLabel];
    
    _fenleiLabel=[[UILabel alloc]initWithFrame:CGRectMake(20,30, 100, 40)];
    _fenleiLabel.textColor=[UIColor grayColor];
    _fenleiLabel.font=[UIFont systemFontOfSize:12];
    [self.contentView  addSubview:_fenleiLabel];
    
    _yishouLabel=[[UILabel alloc]initWithFrame:CGRectMake(120,30, 100, 40)];
    _yishouLabel.textColor=[UIColor grayColor];
    _yishouLabel.font=[UIFont systemFontOfSize:12];
    [self.contentView  addSubview:_yishouLabel];
    
    _huoyuanLabel=[[UILabel alloc]initWithFrame:CGRectMake(220, 30, 100, 40)];
    _huoyuanLabel.textColor=[UIColor grayColor];
    _huoyuanLabel.font=[UIFont systemFontOfSize:12];
    [self.contentView  addSubview:_huoyuanLabel];
    
    _button=[UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame=CGRectMake(180,10,130,20);
    [_button setBackgroundColor:[UIColor orangeColor]];
    [self.contentView  addSubview:_button];
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
