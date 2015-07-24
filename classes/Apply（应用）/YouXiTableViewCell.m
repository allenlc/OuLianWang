//
//  YouXiTableViewCell.m
//  OuLianWang
//
//  Created by hsmj on 15/7/3.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "YouXiTableViewCell.h"

@implementation YouXiTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}


-(void)createUI
{
    
    _iamgeview=[[UIImageView alloc]initWithFrame:CGRectMake(20,10,60,60)];
    _iamgeview.layer.cornerRadius=5;
    _iamgeview.layer.masksToBounds=YES;
    [self.contentView  addSubview:_iamgeview];
    
    _mingzilabel=[[UILabel alloc]initWithFrame:CGRectMake(90,6, 80, 30)];
    _mingzilabel.font=[UIFont  boldSystemFontOfSize:16];
    [self.contentView  addSubview:_mingzilabel];
    
    _geshulabel=[[UILabel alloc]initWithFrame:CGRectMake(200,50, 150, 20)];
    _geshulabel.textColor=[UIColor grayColor];
    _geshulabel.textAlignment=NSTextAlignmentLeft;
    _geshulabel.font=[UIFont  systemFontOfSize:13];
    [self.contentView  addSubview:_geshulabel];
    
    _mingciiamge=[[UIImageView alloc]initWithFrame:CGRectMake(90,35, 25, 25)];
    _mingciiamge.layer.cornerRadius=5;
    _mingciiamge.layer.masksToBounds=YES;
    [self.contentView  addSubview:_mingciiamge];
    
    _fenshulabel=[[UILabel alloc]initWithFrame:CGRectMake(115, 40, 100,20)];
    _fenshulabel.textColor=[UIColor grayColor];
    _fenshulabel.font=[UIFont  systemFontOfSize:13];
    [self.contentView  addSubview:_fenshulabel];
    
    
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
