//
//  ShopTableViewCell.m
//  OuLianWang
//
//  Created by hsmj on 15/7/6.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "ShopTableViewCell.h"

@implementation ShopTableViewCell

+(instancetype)cellWithTableViewCell:(UITableView *)tableView
{
    static NSString * ID = @"towID";
    ShopTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ShopTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];//设置为黑色粗体
        
        //清除cell的颜色
        self.backgroundColor = [UIColor whiteColor];
        self.backgroundView = [[UIImageView alloc]init];
        self.selectedBackgroundView = [[UIImageView alloc]init];
        self.selectionStyle= NO;
        
        UIImageView * topBG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, 10)];
        topBG.backgroundColor = ZQColor(230, 230, 230);
        [self.contentView addSubview:topBG];
        
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 60, 60)];
        imgView.image = [UIImage imageNamed:@"cp"];
        [self.contentView addSubview:imgView];
//        
        UILabel * mainLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 20, self.width/2, 40 )];
        mainLabel.numberOfLines = 0;
        mainLabel.font = [UIFont systemFontOfSize:12];
        mainLabel.text = @"顾家家居 皮床皮艺双人床现代欧式床 实木架床1.8m B-162";
        [self.contentView addSubview:mainLabel];
//
        UILabel * subLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 60, 70, 20)];
        subLabel.text = @"共一件商品";
        subLabel.textColor = [UIColor grayColor];
        subLabel.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:subLabel ];
        
        
        UILabel * priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width-80, 20, 70, 30)];
        priceLabel.text = @"￥39999";
        priceLabel.textColor = [UIColor redColor];
        priceLabel.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:priceLabel ];
        
        UILabel * statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width-70, 60, 60, 20)];
        statusLabel.text = @"交易状态";
        statusLabel.font = [UIFont systemFontOfSize:15];
        statusLabel.textColor = [UIColor greenColor];
        [self.contentView addSubview:statusLabel ];
        
        UIImageView * lineImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 89, self.width, 1)];
        lineImgView.backgroundColor =  ZQColor(214, 214, 214);
        [self.contentView addSubview:lineImgView];
        
        UILabel * numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 90, 150, 20)];
        numberLabel.text = @"单号：E4342345523355";
        numberLabel.textColor = [UIColor grayColor];
        numberLabel.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:numberLabel];
        
        
        UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width-120 , 90, 120, 20)];
        timeLabel.text = @"2015-6-17 11:09:29";
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:timeLabel ];
        
        UIImageView * lineImgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 110, self.width, 1)];
        lineImgView1.backgroundColor =  ZQColor(214, 214, 214);
        [self.contentView addSubview:lineImgView1];
        
        UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(180, 115, 60, 18)];
        [btn1 setImage:[UIImage imageNamed:@"scdd"] forState:0];
        [self.contentView addSubview:btn1];
        
        UIButton * btn2 = [[UIButton alloc]initWithFrame:CGRectMake(250, 115, 60, 18)];
        [btn2 setImage:[UIImage imageNamed:@"pjdd"] forState:0];
        [self.contentView addSubview:btn2];
        
        UIImageView * imgView5 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 139, self.width, 1)];
        imgView5.backgroundColor = ZQColor(214, 214, 214);
        [self.contentView addSubview:imgView5];
        
       
        
    }
    return self;
}

-(void)setItem:(MyIndentItem *)item
{
    _item = item;

}

-(void)setindexPath:(NSIndexPath *)indexPath rowInSecton:(int)rows
{

    
}




@end
