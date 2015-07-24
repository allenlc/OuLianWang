//
//  CollectTableViewCell.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/17.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "CollectTableViewCell.h"
#define margin 20
@implementation CollectTableViewCell

+(instancetype)cellWithTableViewCell:(UITableView *)tableView
{
    static NSString * ID = @"ID";
    CollectTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CollectTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
        self.selectionStyle = 0;
        
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(margin, margin/2, 60, 60)];
        [self.contentView addSubview:imgView];
        self.imgView = imgView;
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(90, margin/2, self.width-imgView.width*2-70, 60)];
        label.numberOfLines = 0;
        label.textColor = ZQColor(42, 42, 42);
        label.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:label];
        self.titleLabel = label;
        
        UILabel * priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width-90, margin/2, 80, 30)];
        [self.contentView addSubview: priceLabel];
        priceLabel.textColor = [UIColor redColor];
        self.priceLabel = priceLabel;
        
    }
    return self;
}
-(void)setindexPath:(NSIndexPath *)indexPath
{
    self.imgView.image = [UIImage imageNamed:@"t1"];
    self.titleLabel.text = @"韩都衣舍哈发货发了后发了发回来收发货乐山大佛爱上风骚发货哦啊是否";
    self.priceLabel.text = @"￥189.0";
    
//        for (UIView * view in self.contentView.subviews) {
//            [view removeFromSuperview];
//        }
//        self.imageView.image = [UIImage imageNamed:@"u=699637347,1919879869&fm=21&gp=0.jpg"];
//        self.textLabel.text = @"text";
//        self.detailTextLabel.text = @"text";
    
}
-(void)selectRecord:(UIButton *)sender
{
    switch (sender.tag) {
        case 1000:
        {
            
        }
            break;
        case 1001:
        {
            
        }
            break;
        case 1002:
        {
            
        }
            break;
            
        default:
            break;
    }
}

@end
