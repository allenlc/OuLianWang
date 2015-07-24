//
//  ShopDetailCell.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/27.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "ShopDetailCell.h"

@implementation ShopDetailCell

+(instancetype)cellWithTableViewCell:(UITableView *)tableView
{
    static NSString * ID = @"ID";
    ShopDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ShopDetailCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];//设置为黑色粗体
        
                //清除cell的颜色
                self.backgroundColor = [UIColor clearColor];
                self.backgroundView = [[UIImageView alloc]init];
                self.selectedBackgroundView = [[UIImageView alloc]init];
                        
        
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
        icon.tag = 100;
        icon.image = [UIImage imageNamed:@"xiangqingpingjiatouxiang"];
        icon.layer.cornerRadius = icon.width/2;
        icon.userInteractionEnabled = YES;
        [self.contentView addSubview:icon];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 60, 10)];
        label.tag = 101;
         label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = 1;
        [self.contentView addSubview:label];
        
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, self.width-70, 50)];
        label1.tag = 102;
        label1.text=@"服务态度好，老板很热情";
        label1.font = [UIFont systemFontOfSize:11];
         label1.textColor = [UIColor grayColor];
        label1.numberOfLines = 0;
        [self.contentView addSubview:label1];
        
        UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(self.width-120, 50, 100, 10)];
        label2.tag = 103;
        label2.textColor = [UIColor grayColor];
        label2.font = [UIFont systemFontOfSize:10];
        label2.text=@"2015-06-21 12:00:00";
        [self.contentView addSubview:label2];
        

    }
    return self;
}

-(void)setEstimateModel:(EstimateModel *)estimateModel
{
    _estimateModel = estimateModel;
    UIImageView * icon = (UIImageView * )[self viewWithTag:100];
    [icon setImageWithURL:[NSURL URLWithString:estimateModel.photo] placeholderImage:[UIImage imageNamed:@"xiangqingpingjiatouxiang"]];
    
    UILabel  * label= (UILabel * )[self viewWithTag:101];
    label.text = estimateModel.username;

    UILabel * label1 = (UILabel * )[self viewWithTag:102];
    label1.text = estimateModel.content;

    UILabel * label2 = (UILabel * )[self viewWithTag:103];
    label2.text = estimateModel.time;

    
}
@end
