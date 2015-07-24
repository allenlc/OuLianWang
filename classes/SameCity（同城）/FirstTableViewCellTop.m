//
//  FirstTableViewCellTop.m
//  OuLianWang
//
//  Created by allenariel on 15/6/27.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "FirstTableViewCellTop.h"
#import "UIView+LCView.h"

@implementation FirstTableViewCellTop

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    self.backgroundColor=[UIColor colorWithRed:231/255.0 green:233/255.0 blue:234/255.0 alpha:1];
    UILabel *la=[self.contentView addLabelWithFrame:CGRectMakeEx(10, 15, 100, 30) text:@"当前定位的城市"];
    la.font=[UIFont systemFontOfSize:14];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMakeEx(205, 20, 16, 20)];
    imageView.image=[UIImage imageNamed:@"tongchengdingweitubiao.png"];
    [self.contentView addSubview:imageView];
    
    self.locationBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _locationBtn.frame=CGRectMakeEx(230, 15, 80, 30);
    _locationBtn.layer.cornerRadius=7;
    _locationBtn.layer.borderWidth=0.3;
    _locationBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    _locationBtn.backgroundColor=[UIColor redColor];
    [_locationBtn addTarget:self action:@selector(locationClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_locationBtn];
}
-(void)locationClick
{
    self.locationBlock();
}

@end
