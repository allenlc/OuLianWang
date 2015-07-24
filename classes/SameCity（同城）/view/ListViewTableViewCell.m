//
//  ListViewTableViewCell.m
//  OuLianWang
//
//  Created by allenariel on 15/6/27.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "ListViewTableViewCell.h"
#import "UIView+LCView.h"
#import "ShopModel.h"

@implementation ListViewTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(NSString *)myIdentify
{
    return @"listViewcellcell";
}
+(CGFloat)myHeight
{
    return 90;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }
    return self;
}
-(void)createUI
{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    self.iconImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 80, 80)];
    [self.contentView addSubview:_iconImageView];
    
    self.storenameLabel=[self.contentView addLabelWithFrame:CGRectMake(90, 5, 200, 30) text:nil];
    _storenameLabel.font=[UIFont boldSystemFontOfSize:14];
    
    self.informationLabel=[self.contentView addLabelWithFrame:CGRectMake(90, 33, 200, 15) text:nil];
    self.informationLabel.font=[UIFont systemFontOfSize:12];
    self.informationLabel.textColor=[UIColor grayColor];
    
    UILabel *ll=[self.contentView addLabelWithFrame:CGRectMake(90, 45, 30, 30) text:@"好评: "];
    ll.font=[UIFont systemFontOfSize:12];
    ll.textColor=[UIColor grayColor];
    
    StarView *starView=[[StarView alloc]initWithFrame:CGRectMake(130, 52, 30, 30)];
    [self.contentView addSubview:starView];
    
    self.reginLabel=[self.contentView addLabelWithFrame:CGRectMake(90, 72, 100, 15) text:nil];
    _reginLabel.font=[UIFont systemFontOfSize:12];
    _reginLabel.textColor=[UIColor grayColor];
    
    self.distanceLabel=[self.contentView addLabelWithFrame:CGRectMake(240, 72, 80, 15) text:nil];
    _distanceLabel.font=[UIFont systemFontOfSize:12];
    _distanceLabel.textColor=[UIColor grayColor];
    
    [_iconImageView setImageWithURL:[NSURL URLWithString:_shopModel.logo]];
    _storenameLabel.text=_shopModel.storename;
    _informationLabel.text=_shopModel.information;
    [_starView setStar:5];
    _reginLabel.text=_shopModel.address;
    if ([_shopModel.meter floatValue]<1000) {
        _distanceLabel.text=[NSString stringWithFormat:@"< %@ m",_shopModel.meter];
    }
    else{
        _distanceLabel.text=[NSString stringWithFormat:@"< %.2f km",[_shopModel.meter floatValue]/1000];
    }
   
    
}
@end
