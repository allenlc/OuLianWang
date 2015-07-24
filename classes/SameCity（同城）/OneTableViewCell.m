//
//  OneTableViewCell.m
//  OuLianWang
//
//  Created by hsmj on 15/6/29.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "OneTableViewCell.h"

@interface OneTableViewCell ()


@end

@implementation OneTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _count=1;
    //  选中的按钮
    _xuanzeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _xuanzeButton.frame=CGRectMake(5,50, 20, 20);
    [_xuanzeButton setImage:[UIImage imageNamed:@"noselect_gwc"] forState:UIControlStateNormal];
    [_xuanzeButton  setImage:[UIImage imageNamed:@"select_gwc.png"] forState:UIControlStateSelected];
    _xuanzeButton.selected=NO;
    [_xuanzeButton  addTarget:self action:@selector(xuanzebuttonclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView  addSubview:_xuanzeButton];

    //  图片
    _imageview=[[UIImageView  alloc]initWithFrame:CGRectMake(30, 20, 60, 80)];
    [self.contentView  addSubview:_imageview];
    
    //  标题文字
    _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 10, 150, 40)];
    _titleLabel.numberOfLines=0;
    _titleLabel.font=[UIFont systemFontOfSize:12];
    [self.contentView  addSubview:_titleLabel];
    
    // 长
    _changLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 60, 50 ,20)];
    _changLabel.textColor=[UIColor grayColor];
    _changLabel.font=[UIFont  systemFontOfSize:12];
    [self.contentView  addSubview:_changLabel];
    
    // 宽
    _kuanLabel=[[UILabel alloc]initWithFrame:CGRectMake(160, 60, 50 ,20)];
    _kuanLabel.textColor=[UIColor grayColor];
    _kuanLabel.font=[UIFont  systemFontOfSize:12];
    [self.contentView  addSubview:_kuanLabel];
    
    // 高
    _gaoLabel=[[UILabel alloc]initWithFrame:CGRectMake(210, 60, 50 ,20)];
    _gaoLabel.textColor=[UIColor grayColor];
    _gaoLabel.font=[UIFont  systemFontOfSize:12];
    [self.contentView  addSubview:_gaoLabel];
    
    //  型号
    _xinghaoLabel=[[UILabel alloc]initWithFrame:CGRectMake(100,80,100 ,20)];
    _xinghaoLabel.textColor=[UIColor grayColor];
    _xinghaoLabel.font=[UIFont  systemFontOfSize:12];
    [self.contentView  addSubview:_xinghaoLabel];
    
    //  颜色
    _yanseLabel=[[UILabel alloc]initWithFrame:CGRectMake(200, 80,80 ,20)];
    _yanseLabel.textColor=[UIColor grayColor];
    _yanseLabel.font=[UIFont  systemFontOfSize:12];
    [self.contentView  addSubview:_yanseLabel];
    
    // 原来价格
    _yuanpriceLabel=[[UILabel alloc]initWithFrame:CGRectMake(250, 20, 80 ,20)];
    _yuanpriceLabel.textColor=[UIColor grayColor];
    _yuanpriceLabel.font=[UIFont  systemFontOfSize:12];
    [self.contentView  addSubview:_yuanpriceLabel];
    
    //  现在价格
    _xianpriceLabel=[[UILabel alloc]initWithFrame:CGRectMake(250, 40, 80 ,20)];
    _xianpriceLabel.textColor=[UIColor redColor];
    _xianpriceLabel.font=[UIFont  systemFontOfSize:14];
    [self.contentView  addSubview:_xianpriceLabel];
    
    //  下单的数目
    _priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(280, 80, 20 ,20)];
    _priceLabel.textColor=[UIColor grayColor];
    _priceLabel.font=[UIFont  systemFontOfSize:12];
    _priceLabel.layer.borderWidth=1;
    _priceLabel.textAlignment=1;
    _priceLabel.layer.borderColor=[UIColor blackColor].CGColor;
    _priceLabel.text=[NSString stringWithFormat:@"%d",_count];
    [self.contentView  addSubview:_priceLabel];
    
    //  减一个按钮
    _jianbutton=[UIButton buttonWithType:UIButtonTypeSystem];
    _jianbutton.frame=CGRectMake(260, 80, 20, 20);
    
    [_jianbutton  addTarget:self action:@selector(jianbutton:) forControlEvents:UIControlEventTouchUpInside];
    [_jianbutton setTitle:@" - " forState:UIControlStateNormal];
    [self.contentView  addSubview:_jianbutton];
    
    //  加一个按钮
    _jiabutton=[UIButton buttonWithType:UIButtonTypeSystem];
    _jiabutton.frame=CGRectMake(300, 80, 20, 20);
    [_jiabutton  addTarget:self action:@selector(jiabutton:) forControlEvents:UIControlEventTouchUpInside];
    [_jiabutton setTitle:@" + " forState:UIControlStateNormal];
    [self.contentView  addSubview:_jiabutton];

}

-(void)xuanzebuttonclick:(UIButton *)but
{

    if (but.selected==NO) {
        
        but.selected=YES;
        self.priceblock11(self.ydModel);
        
    }
    else{
        but.selected=NO;
        self.priceblock22(self.ydModel);

    }
    
}


-(void)jianbutton:(UIButton *)but
{
    
    if (_count<1) {
        return;
    }
    _count--;
    _priceLabel.text=[NSString stringWithFormat:@"%d",_count];
    
    if (!self.xuanzeButton.selected) {
        return;
    }
    self.jianblock(self.ydModel);
    
}

-(void)jiabutton:(UIButton *)but
{
    _count++;
    _priceLabel.text=[NSString stringWithFormat:@"%d",_count];
    
    if (!self.xuanzeButton.selected) {
        return;
    }
    
    self.jiablock(self.ydModel);
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
