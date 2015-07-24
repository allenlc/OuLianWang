//
//  ShuJuTableViewCell.m
//  OuLianWang
//
//  Created by hsmj on 15/7/8.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "ShuJuTableViewCell.h"

@implementation ShuJuTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _imageviwe=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 60, 70)];
    [self.contentView  addSubview:_imageviwe];
    
    _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(80,8,160, 60)];
    _titleLabel.textColor=[UIColor  blackColor];
    _titleLabel.numberOfLines=0;
    _titleLabel.font=[UIFont systemFontOfSize:13];
    [self.contentView  addSubview:_titleLabel];
    
    _chenjLabel=[[UILabel alloc]initWithFrame:CGRectMake(80,70, 100, 20)];
    _chenjLabel.textColor=[UIColor  redColor];
    _chenjLabel.font=[UIFont  systemFontOfSize:16];
    [self.contentView  addSubview:_chenjLabel];
    
    _liulLabel=[[UILabel alloc]initWithFrame:CGRectMake(180,70, 100, 20)];
    _liulLabel.textColor=[UIColor  redColor];
    _liulLabel.font=[UIFont  systemFontOfSize:16];
    [self.contentView  addSubview:_liulLabel];
    
    _fensLabel=[[UILabel alloc]initWithFrame:CGRectMake(245,20,50,30)];
    _fensLabel.textColor=[UIColor redColor];
    _fensLabel.font=[UIFont  systemFontOfSize:20];
    [self.contentView  addSubview:_fensLabel];
    

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
