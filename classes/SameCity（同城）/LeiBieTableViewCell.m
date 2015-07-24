//
//  LeiBieTableViewCell.m
//  OuLianWang
//
//  Created by hsmj on 15/6/26.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "LeiBieTableViewCell.h"

@implementation LeiBieTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    
        _imageview=[[UIImageView  alloc]initWithFrame:CGRectMake(15,30,90, 90)];
        _imageview.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapclick:)];
        [_imageview  addGestureRecognizer:tap];
        [self.contentView  addSubview:_imageview];
    
        _imageview1=[[UIImageView  alloc]initWithFrame:CGRectMake(15+110*1,30, 90, 90)];
        _imageview1.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapclick:)];
        [_imageview1  addGestureRecognizer:tap1];
        [self.contentView  addSubview:_imageview1];
    
        _titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(15+110*0, 115, 95,20)];
        [self.contentView  addSubview:_titlelabel];
        _titlelabel.font=[UIFont systemFontOfSize:14];
        _titlelabel.textAlignment=1;
    
        _titlelabel1=[[UILabel alloc]initWithFrame:CGRectMake(15+110*1, 115, 95,20)];
        [self.contentView  addSubview:_titlelabel1];
        _titlelabel1.font=[UIFont systemFontOfSize:14];
        _titlelabel1.textAlignment=1;
    
    
}

-(void)tapclick:(UITapGestureRecognizer *)tap
{
    self.imageblock();
    
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
