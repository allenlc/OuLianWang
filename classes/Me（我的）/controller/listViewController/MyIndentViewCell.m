//
//  MyIndentViewCell.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/24.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "MyIndentViewCell.h"

@implementation MyIndentViewCell

+(instancetype)cellWithTableViewCell:(UITableView *)tableView
{
    static NSString * ID = @"ID";
    MyIndentViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MyIndentViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
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
        
        goods_imgview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
//        goods_imgview.image = [UIImage imageNamed:@"cp"];
        [self.contentView addSubview:goods_imgview];
        //
        gnameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 10, self.width/2, 40 )];
        gnameLabel.numberOfLines = 0;
        gnameLabel.font = [UIFont systemFontOfSize:14];
//        mainLabel.text = @"顾家家居 皮床皮艺双人床现代欧式床 实木架床1.8m B-162";
        [self.contentView addSubview:gnameLabel];
        
        //
        numsLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 50, 70, 20)];
//        subLabel.text = @"共一件商品";
        numsLabel.textColor = [UIColor grayColor];
        numsLabel.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:numsLabel ];
        
        
        priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width-80, 10, 70, 30)];
//        priceLabel.text = @"￥39999";
        priceLabel.textAlignment =2;
        priceLabel.textColor = [UIColor redColor];
        priceLabel.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:priceLabel ];
        
        statusLable = [[UILabel alloc]initWithFrame:CGRectMake(self.width-70, 50, 60, 20)];
        statusLable.text = @"交易状态";
        statusLable.textAlignment = 2;
        statusLable.font = [UIFont systemFontOfSize:15];
        statusLable.textColor = [UIColor greenColor];
        [self.contentView addSubview:statusLable ];
        
        UIImageView * lineImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 79, self.width, 1)];
        lineImgView.backgroundColor =  ZQColor(214, 214, 214);
        [self.contentView addSubview:lineImgView];
        
        orderidLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 150, 20)];
        orderidLabel.text = @"单号：E4342345523355";
        orderidLabel.textColor = [UIColor grayColor];
        orderidLabel.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:orderidLabel];
        
        
        catchtimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width-120 , 80, 120, 20)];
//        catchtimeLabel.text = @"2015-6-17 11:09:29";
        catchtimeLabel.textColor = [UIColor grayColor];
        catchtimeLabel.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:catchtimeLabel ];
        
        UIImageView * lineImgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, self.width, 1)];
        lineImgView1.backgroundColor =  ZQColor(214, 214, 214);
        [self.contentView addSubview:lineImgView1];
        
        UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(180, 105, 60, 18)];
        [btn1 setImage:[UIImage imageNamed:@"scdd"] forState:0];
        [self.contentView addSubview:btn1];
        
        UIButton * btn2 = [[UIButton alloc]initWithFrame:CGRectMake(250, 105, 60, 18)];
        [btn2 setImage:[UIImage imageNamed:@"pjdd"] forState:0];
        [self.contentView addSubview:btn2];
        
        UIImageView * imgView5 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 129, self.width, 1)];
        imgView5.backgroundColor = ZQColor(214, 214, 214);
        [self.contentView addSubview:imgView5];
        
    
    }
    return self;
}

-(void)setItem:(MyIndentItem *)item
{
    _item = item;
    [goods_imgview setImageWithURL:[NSURL URLWithString:_item.goods_img] placeholderImage:DEFAULTIMG];
    gnameLabel.text = _item.gname;
    priceLabel.text = [NSString stringWithFormat:@"￥%@",_item.price];
    numsLabel.text = [NSString stringWithFormat:@"共%@件商品",item.nums];
    orderidLabel.text = [NSString stringWithFormat:@"单号:%@",item.orderid];
    catchtimeLabel.text = item.catchtime;
    statusLable.text = item.status;
    
}

-(void)setindexPath:(NSIndexPath *)indexPath rowInSecton:(int)rows
{
    
    
}


@end
