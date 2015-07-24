//
//  YOUXICell.m
//  OuLianWang
//
//  Created by hsmj on 15/7/4.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "YOUXICell.h"

@implementation YOUXICell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI

{
    
    _imageview=[[UIImageView alloc]initWithFrame:CGRectMake(20,10,60,60)];
    _imageview.layer.cornerRadius=5;
    _imageview.layer.masksToBounds=YES;
    [self.contentView  addSubview:_imageview];

    
    _titltlabel=[[UILabel alloc]initWithFrame:CGRectMake(90,6,150, 30)];
    _titltlabel.font=[UIFont  boldSystemFontOfSize:16];
    [self.contentView  addSubview:_titltlabel];
    
    
    _geshulabel=[[UILabel alloc]initWithFrame:CGRectMake(90,53, 150, 20)];
    _geshulabel.textColor=[UIColor grayColor];
    _geshulabel.textAlignment=NSTextAlignmentLeft;
    _geshulabel.font=[UIFont  systemFontOfSize:13];
    [self.contentView  addSubview:_geshulabel];
    
    
    _typeabel =[[UILabel alloc]initWithFrame:CGRectMake(90,32,30,20)];
    _typeabel.textAlignment=1;
    _typeabel.layer.cornerRadius=2;
    _typeabel.layer.masksToBounds=YES;
    _typeabel.font=[UIFont  boldSystemFontOfSize:14];
    _typeabel.textColor=[UIColor whiteColor];
    [self.contentView  addSubview:_typeabel];


}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
