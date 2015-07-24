//
//  CityOneTableViewCell.m
//  OuLianWang
//
//  Created by allenariel on 15/7/2.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "CityOneTableViewCell.h"
#import "UIView+LCView.h"
@implementation CityOneTableViewCell

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
    self.backgroundColor=ZQColor(231, 233, 234);
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(10, 0, 300, 30)];
    view.layer.borderWidth=0.3;
    view.layer.borderColor=[[UIColor grayColor]CGColor];
    view.backgroundColor=[UIColor whiteColor];
    view.layer.cornerRadius=6;
    [self.contentView addSubview:view];
    
    self.nameLabel=[view addLabelWithFrame:CGRectMake(20, 0, 150, 30) text:nil];
    self.nameLabel.font=[UIFont systemFontOfSize:16];
    self.iconImageView=[view addImageViewWithFrame:CGRectMake(270, 15, 20, 10) image:@"城市下拉_03.png"];
    self.nameLabel.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [self.nameLabel addGestureRecognizer:tap];
}

-(void)tapClick
{
    self.setCityBlock();
}







@end
