//
//  MyDistributorCell.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/8.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "MyDistributorCell.h"

@implementation MyDistributorCell

+(instancetype)cellWithTableViewCell:(UITableView *)tableView
{
    static NSString * ID = @"ID";
    MyDistributorCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MyDistributorCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
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
    [aView addSubview:imgView];
    self.iconImgView = imgView;

    //
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(100, 15, 100, 20)];
    label1.textColor = ZQColor(63 , 63, 63);
    label1.font = [UIFont systemFontOfSize:14];
    [aView addSubview:label1];
    self.titleLabel = label1;
    //
    
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(100, 45,80, 20)];
    label2.textColor = [UIColor grayColor];
    label2.text = @"销量：200";
    label2.font = [UIFont systemFontOfSize:13];
    [aView addSubview:label2];
    
    UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(100, 75, 150, 20)];
    label3.textColor = [UIColor grayColor];
    label3.text = @"分销时间:2015-06-18";
    label3.font = [UIFont systemFontOfSize:13];
    [aView addSubview:label3];
    
    UILabel * label4 = [[UILabel alloc]initWithFrame:CGRectMake(self.width/2, 15, self.width/2-15, 20)];
    label4.textAlignment = 2;
    label4.textColor = ZQColor(63 , 63, 63);
    label4.text = @"分销收入 ￥200";
    label4.font = [UIFont systemFontOfSize:14];
    [aView addSubview:label4];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(self.width-100, 45, 80, 30)];
    [btn addTarget:self action:@selector(enterDetailView) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"Sale"] forState:0];
    [aView addSubview:btn];
    
    
}
-(void)enterDetailView
{
    self.enterBlock(self);
}

@end
