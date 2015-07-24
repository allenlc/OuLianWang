//
//  ProductPingJiaCell.m
//  OuLianWang
//
//  Created by hsmj on 15/6/23.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "ProductPingJiaCell.h"
#import "UILabel+StringFrame.h"

@implementation ProductPingJiaCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _imagedeview=[[UIImageView alloc]initWithFrame:CGRectMake(30, 20, 40, 40)];
    _imagedeview.layer.cornerRadius=5;
    _imagedeview.layer.masksToBounds=YES;
    [self.contentView  addSubview:_imagedeview];

    
    _JianJiedeLabel=[[UILabel alloc]init];
    _JianJiedeLabel.numberOfLines=0;
    [self.contentView  addSubview:_JianJiedeLabel];
    
    _mingziLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 60, 60, 20)];
    _mingziLabel.font=[UIFont  systemFontOfSize:13];
    _mingziLabel.textColor=[UIColor grayColor];
    _mingziLabel.textAlignment=1;
    [self.contentView  addSubview:_mingziLabel];

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
