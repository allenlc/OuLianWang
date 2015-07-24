//
//  ThreeTableViewCell.m
//  OuLianWang
//
//  Created by hsmj on 15/6/29.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "ThreeTableViewCell.h"
#import "UIView+LCView.h"
#import "LCImageView.h"

@interface ThreeTableViewCell ()


@end

@implementation ThreeTableViewCell

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
    UILabel *ll1=[self.contentView addLabelWithFrame:CGRectMake(10, 10, 100, 25) text:@"选择配送方式："];
    ll1.font=[UIFont systemFontOfSize:14];
    
    UILabel *ll2=[self.contentView addLabelWithFrame:CGRectMake(190, 10, 60, 25) text:@"配送费用"];
    ll2.font=[UIFont systemFontOfSize:14];
    
    //邮寄价钱
    _muchLable=[self.contentView addLabelWithFrame:CGRectMake(ll2.frame.origin.x+ll2.frame.size.width, 10, 50, 25) text:@"20"];
    _muchLable.textColor=ZQColor(211, 85, 34);
    _muchLable.font=[UIFont systemFontOfSize:18];
    _muchLable.clipsToBounds=YES;
    
    UILabel *ll3=[self.contentView addLabelWithFrame:CGRectMake(_muchLable.frame.origin.x+_muchLable.text.length*12, 10, 15, 25) text:@"元"];
    ll3.font=[UIFont systemFontOfSize:14];
    
    //选择快递
    UIView *changeView=[[UIView alloc]initWithFrame:CGRectMake(105, 13, 80, 20)];
    changeView.layer.borderWidth=0.5;
    changeView.layer.borderColor=[UIColor grayColor].CGColor;
    UILabel *whichLabel=[changeView addLabelWithFrame:CGRectMake(6, 0, 55, 20) text:@"送货上门"];
    whichLabel.font=[UIFont systemFontOfSize:13];
    UIImageView *ii=[changeView addImageViewWithFrame:CGRectMake(60, 5, 15, 10) image:@"yddowndown"];
    ii.backgroundColor=[UIColor yellowColor];
    [self.contentView addSubview:changeView];
    //第二行
    UILabel *ll4=[self.contentView addLabelWithFrame:CGRectMake(10, 40, 85, 25) text:@"是否开发票："];
    ll4.font=[UIFont systemFontOfSize:14];
    
    UIButton *yesBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    yesBtn.frame=CGRectMake(100, 40, 20, 20);
    [yesBtn setImage:[UIImage imageNamed:@"nosel02"] forState:UIControlStateNormal];
    [yesBtn setImage:[UIImage imageNamed:@"sel02"] forState:UIControlStateSelected];
    yesBtn.selected=YES;
    [self.contentView addSubview:yesBtn];
    yesBtn.tag=333;
    [yesBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *ll5=[self.contentView addLabelWithFrame:CGRectMake(120, 40, 15, 25) text:@"是"];
    ll5.font=[UIFont systemFontOfSize:14];
    
    UIButton *noBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [noBtn setImage:[UIImage imageNamed:@"nosel02"] forState:UIControlStateNormal];
    [noBtn setImage:[UIImage imageNamed:@"sel02"] forState:UIControlStateSelected];
    noBtn.tag=334;
    [noBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    noBtn.frame=CGRectMake(140, 40, 20, 20);
    [self.contentView addSubview:noBtn];
    UILabel *ll6=[self.contentView addLabelWithFrame:CGRectMake(160, 40, 15, 25) text:@"否"];
    ll6.font=[UIFont systemFontOfSize:14];
    
    //发票钱
    UILabel *ll7=[self.contentView addLabelWithFrame:CGRectMake(230, 40, 30, 25) text:@"费用"];
    ll7.font=[UIFont systemFontOfSize:14];
    
    _youLabel=[self.contentView addLabelWithFrame:CGRectMake(ll7.frame.origin.x+ll7.frame.size.width, 40, 30, 25) text:@"2"];
    _youLabel.textColor=ZQColor(211, 85, 34);
    _youLabel.font=[UIFont systemFontOfSize:18];
    
    UILabel *ll8=[self.contentView addLabelWithFrame:CGRectMake(_youLabel.frame.origin.x+_youLabel.text.length*12, 40, 40, 25) text:@"元"];
    ll8.font=[UIFont systemFontOfSize:14];

}

-(void)btnClick:(UIButton *)btn
{
    if (btn.tag==333) {
        UIButton *bb=(UIButton *)[self.contentView viewWithTag:334];
        
        if (btn.selected) {
            btn.selected=NO;
            bb.selected=YES;
            _youLabel.text=@"0";
        }
        else{
            btn.selected=YES;
            bb.selected=NO;
            _youLabel.text=@"2";
        }
    }
    if (btn.tag==334) {
        UIButton *bb=(UIButton *)[self.contentView viewWithTag:333];
        
        if (btn.selected) {
            btn.selected=NO;
            bb.selected=YES;
            _youLabel.text=@"2";
        }
        else{
            btn.selected=YES;
            bb.selected=NO;
            _youLabel.text=@"0";
        }
    }
}

@end
