//
//  TwoTableViewCell.m
//  OuLianWang
//
//  Created by hsmj on 15/6/29.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "TwoTableViewCell.h"

@implementation TwoTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    
    //    收货人
    _shouhuoLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 150 ,20)];
    _shouhuoLabel.textColor=[UIColor grayColor];
    _shouhuoLabel.font=[UIFont  systemFontOfSize:12];
    [self.contentView  addSubview:_shouhuoLabel];
    
    //   联系电话
    _lianxiLabel=[[UILabel alloc]initWithFrame:CGRectMake(20,35, 150 ,20)];
    _lianxiLabel.textColor=[UIColor grayColor];
    _lianxiLabel.font=[UIFont  systemFontOfSize:12];
    [self.contentView  addSubview:_lianxiLabel];
    
    //   收货地址
    _dizhiLabel=[[UILabel alloc]initWithFrame:CGRectMake(20,60, 250 ,20)];
    _dizhiLabel.textColor=[UIColor grayColor];
    _dizhiLabel.font=[UIFont  systemFontOfSize:12];
    [self.contentView  addSubview:_dizhiLabel];
    
    //   邮政地址
    _youzhenLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 85, 150 ,20)];
    _youzhenLabel.textColor=[UIColor grayColor];
    _youzhenLabel.font=[UIFont  systemFontOfSize:12];
    [self.contentView  addSubview:_youzhenLabel];
    
    //  地图按钮
    _ditubutton=[UIButton  buttonWithType:UIButtonTypeCustom];
   // [_ditubutton  setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    _ditubutton.frame=CGRectMake(250, 60, 20 ,20);
    [self.contentView  addSubview:  _ditubutton];
    
    
 
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
