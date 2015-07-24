//
//  ServiceTimeCell.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/17.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "ServiceTimeCell.h"
#define margin 10
@implementation ServiceTimeCell

+(instancetype)cellWithTableViewCell:(UITableView *)tableView
{
    static NSString * ID = @"ID";
    ServiceTimeCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ServiceTimeCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];//设置为黑色粗体
        
        //清除cell的颜色
        self.backgroundColor = [UIColor clearColor];
        UIImageView * bgImgView = [[UIImageView alloc]init];
        self.backgroundView =bgImgView;
        self.selectedBackgroundView = [[UIImageView alloc]init];
        self.selectionStyle = 0;
        [self creatShopViewWithView:self];
    }
    return self;
}
-(void)setindexPath:(NSIndexPath *)indexPath
{
    
    
    
}


-(void)creatShopViewWithView:(UIView *)aView
{
    
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15,80,80)];
    imgView.image = [UIImage imageNamed:@"fwsj_clock"];
    [aView addSubview:imgView];
    

    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(100, 15, aView.width-160, 40)];
    label1.textColor = ZQColor(63  , 63, 63);
    label1.text = @"每天";
//    label1.numberOfLines = 0;
    label1.font = [UIFont systemFontOfSize:15];
    [aView addSubview:label1];
    //
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), 15, self.width-CGRectGetMaxX(label1.frame), 30)];
    [btn setImage:[UIImage imageNamed:@"bianji_spgl"] forState:0];
    [btn setTitleColor:[UIColor redColor] forState:0];
    [btn setTitle:@"编辑" forState:0 ];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(5, 0, 5, 40)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [aView addSubview:btn];
    
    UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), 40, self.width-CGRectGetMaxX(label1.frame), 30)];
    [btn1 setImage:[UIImage imageNamed:@"xiazai_spgl"] forState:0];
    [btn1 setTitleColor:[UIColor redColor] forState:0];
    [btn1 setTitle:@"下架" forState:0 ];
    btn1.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn1 setImageEdgeInsets:UIEdgeInsetsMake(5, 0, 5, 40)];
    [btn1 setTitleEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
    [aView addSubview:btn1];
    
    UIButton * btn2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame)+30, 75, 20, 20)];
    [btn2 setImage:[UIImage imageNamed:@"shangpinguanlixuanze"] forState:UIControlStateSelected];
    [btn2 setImage:[UIImage imageNamed:@"不选择"] forState:0];
    btn2.titleLabel.font = [UIFont systemFontOfSize:14];
    [aView addSubview:btn2];
    [btn2 addTarget:self action:@selector(selecteGoods:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(100, 60, aView.width-150, 20)];
//    label2.textColor = [UIColor redColor];
    label2.text = @"8:30-6:30";
    label2.numberOfLines = 0;
    label2.font = [UIFont systemFontOfSize:15];
    [aView addSubview:label2];
    
   
    
}
-(void)selecteGoods:(UIButton *)sender
{
    if (sender.selected == NO) {
        sender.selected = YES;
    }
    else{
        sender.selected = NO;
    }
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
