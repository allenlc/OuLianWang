//
//  jiamKTableViewCell.m
//  OuLianWang
//
//  Created by hsmj on 15/6/26.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "jiamKTableViewCell.h"

@implementation jiamKTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.backgroundColor=ZQColor(220, 220, 220);
    imageView.frame=CGRectMake(0, 0, 40, 40);
    [self.contentView  addSubview:imageView];
    
    
    UIImageView *imageView2=[[UIImageView alloc]init];
    imageView2.backgroundColor=ZQColor(220, 220, 220);
    imageView2.frame=CGRectMake(230,0, 90, 40);
    [self.contentView  addSubview:imageView2];
    
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(50,10,40,20)];
    label.text=@"筛选";
    label.textColor=[UIColor blackColor];
    label.textColor=ZQColor(140, 140, 140);
    label.font=[UIFont  systemFontOfSize:18];
    [imageView2 addSubview:label];
    
//    
//    UIImageView *image2=[[UIImageView alloc]init];
//    image2.frame=CGRectMake(65, 10, 20,20);
//    image2.image=[UIImage imageNamed:@"down.png"];
//    [imageView2  addSubview:image2];
    
    UIImageView *image=[[UIImageView alloc]init];
    image.frame=CGRectMake(10, 10, 20,20);
    image.image=[UIImage imageNamed:@"down.png"];
    [imageView  addSubview:image];
    
    _searchbar=[[UISearchBar alloc]initWithFrame:CGRectMake(40, 0, 240, 40)];
    _searchbar.placeholder=@"搜索商铺,商店...";
    _searchbar.barStyle=UIBarStyleDefault;
    _searchbar.barTintColor=ZQColor(220, 220, 220);
    _searchbar.layer.borderColor=ZQColor(220, 220, 220).CGColor;
    _searchbar.layer.borderWidth=0.5;
    [self.contentView addSubview:_searchbar];
    
        NSArray *titltArray=@[@"咨询",@"我的"];
        NSArray *colorArray=@[ZQColor(153, 206, 126),ZQColor(80, 203, 175)];
    
          //创建button
            _btn=[UIButton buttonWithType:UIButtonTypeCustom];
            _btn.layer.cornerRadius=30;
            _btn.frame=CGRectMake(70,55, 60, 60);
            _btn.backgroundColor=colorArray[0];
            [_btn setTitle:titltArray[0] forState:UIControlStateNormal];
            _btn.tag=250+0;
            [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:_btn];
            
            _btn2=[UIButton buttonWithType:UIButtonTypeCustom];
            _btn2.layer.cornerRadius=30;
            _btn2.frame=CGRectMake(70+120*1,55, 60, 60);
            _btn2.backgroundColor=colorArray[1];
            [_btn2 setTitle:titltArray[1] forState:UIControlStateNormal];
            _btn2.tag=250+1;
            [_btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:_btn2];
    


}

-(void)btnClick:(UIButton *)button
{
 


}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
