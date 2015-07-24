//
//  ProductJianJieCell.m
//  OuLianWang
//
//  Created by hsmj on 15/6/23.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "ProductJianJieCell.h"

@implementation ProductJianJieCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    
    _imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 320)];
    [self.contentView  addSubview:_imageview];
    
    
    _JianJieLabel=[[UILabel alloc]init];
    _JianJieLabel.frame=CGRectMake(20,320,230,60);
    _JianJieLabel.font=[UIFont  systemFontOfSize:12];
    _JianJieLabel.numberOfLines=0;
    [self.contentView  addSubview:_JianJieLabel];
    
    _fenxiaoButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _fenxiaoButton.frame=CGRectMake(250, 325, 60, 40);
    [self.contentView  addSubview:_fenxiaoButton];
    

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
