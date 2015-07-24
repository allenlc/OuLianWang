//
//  onetableviewcell.m
//  OuLianWang
//
//  Created by hsmj on 15/7/6.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "onetableviewcell.h"

@implementation onetableviewcell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    
    //  图片
    _imageview=[[UIImageView  alloc]initWithFrame:CGRectMake(20, 20, 60, 80)];
    [self.contentView  addSubview:_imageview];
    
    //  标题文字
    _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 10, 250, 40)];
    _titleLabel.numberOfLines=0;
    _titleLabel.font=[UIFont systemFontOfSize:12];
    [self.contentView  addSubview:_titleLabel];
    
    // 长
    _changLabel=[[UILabel alloc]initWithFrame:CGRectMake(100,40, 250 ,20)];
    _changLabel.textColor=[UIColor grayColor];
    _changLabel.font=[UIFont  systemFontOfSize:12];
    [self.contentView  addSubview:_changLabel];
    
    
    
    // 原来价格
    _yuanpriceLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 80, 280 ,20)];
    _yuanpriceLabel.textColor=[UIColor grayColor];
    _yuanpriceLabel.font=[UIFont  systemFontOfSize:12];
    [self.contentView  addSubview:_yuanpriceLabel];
    
    //  现在价格
    _xianpriceLabel=[[UILabel alloc]initWithFrame:CGRectMake(100,60, 280 ,20)];
    _xianpriceLabel.textColor=[UIColor redColor];
    _xianpriceLabel.font=[UIFont  systemFontOfSize:14];
    [self.contentView  addSubview:_xianpriceLabel];
    
    //  下单的数目
    _priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(280, 80, 50 ,20)];
    _priceLabel.textColor=[UIColor orangeColor];
    _priceLabel.font=[UIFont  systemFontOfSize:14];
    _priceLabel.textAlignment=1;
    [self.contentView  addSubview:_priceLabel];
    
    //  减一个按钮
//    _jianbutton=[UIButton buttonWithType:UIButtonTypeSystem];
//    _jianbutton.frame=CGRectMake(260, 80, 20, 20);
//    
//    [_jianbutton  addTarget:self action:@selector(jianbutton:) forControlEvents:UIControlEventTouchUpInside];
//    [_jianbutton setTitle:@" - " forState:UIControlStateNormal];
//    [self.contentView  addSubview:_jianbutton];
    
    //  加一个按钮
//    _jiabutton=[UIButton buttonWithType:UIButtonTypeSystem];
//    _jiabutton.frame=CGRectMake(300, 80, 20, 20);
//    [_jiabutton  addTarget:self action:@selector(jiabutton:) forControlEvents:UIControlEventTouchUpInside];
//    [_jiabutton setTitle:@" + " forState:UIControlStateNormal];
//    [self.contentView  addSubview:_jiabutton];
    
}
-(void)xuanzebuttonclick:(UIButton *)but
{
    NSLog(@"1234");
    if (but.selected==NO) {
        
        but.selected=YES;
    }
    else
        but.selected=NO;
    
    
}


-(void)jianbutton:(UIButton *)but
{
    
    self.jianblock();
    
}

-(void)jiabutton:(UIButton *)but
{
    
    self.jiablock();
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
