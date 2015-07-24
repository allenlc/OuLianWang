//
//  PinJiaTableViewCell.m
//  OuLianWang
//
//  Created by hsmj on 15/7/7.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "PinJiaTableViewCell.h"

@implementation PinJiaTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    
    _imageview=[[UIImageView  alloc]initWithFrame:CGRectMake(10,15,50, 50)];
    _imageview.layer.cornerRadius=5;
    _imageview.layer.masksToBounds=YES;
    [self.contentView  addSubview:_imageview];

    _mingzilabel=[[UILabel alloc]initWithFrame:CGRectMake(10,70, 60, 20)];
    _mingzilabel.font=[UIFont  systemFontOfSize:13];
    _mingzilabel.textAlignment=0;
    [self.contentView  addSubview:_mingzilabel];
    
    _titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(100,10, 200, 80)];
    _titlelabel.numberOfLines=0;
    _titlelabel.font=[UIFont  systemFontOfSize:14];
    [self.contentView  addSubview:_titlelabel];
    
    _shijianlabel=[[UILabel alloc]initWithFrame:CGRectMake(100,100, 100, 20)];
    _shijianlabel.font=[UIFont  systemFontOfSize:13];
    [self.contentView  addSubview:_shijianlabel];
    
    
    
    _Huibutton=[UIButton buttonWithType:UIButtonTypeCustom];
    _Huibutton.frame=CGRectMake(100, 100, 70, 30);
    _Huibutton.layer.cornerRadius=5;
    _Huibutton.backgroundColor=[UIColor  orangeColor];
    [_Huibutton  setTitle:@"回复评论" forState:UIControlStateNormal];
    _Huibutton.titleLabel.font=[UIFont  boldSystemFontOfSize:15];
    [_Huibutton  setTitleColor:[UIColor  whiteColor] forState:UIControlStateNormal];
    [self.contentView  addSubview:_Huibutton];
    
    
    _anniuButton=[UIButton  buttonWithType:UIButtonTypeCustom];
    _anniuButton.frame=CGRectMake(260,90, 25,25);
    [_anniuButton  setImage:[UIImage imageNamed:@"不选择"] forState:UIControlStateNormal];
    [_anniuButton  setImage:[UIImage  imageNamed:@"选择(1)"] forState:UIControlStateSelected];
    _anniuButton.selected=NO;
    [_anniuButton  addTarget:self action:@selector(buttonclck:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView  addSubview:_anniuButton];
    
    
    


}

-(void)buttonclck:(UIButton *)but
{
    
    
    but.selected=YES;

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
