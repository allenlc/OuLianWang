//
//  BalanceTableViewCell.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/17.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "BalanceTableViewCell.h"
#define margin 20
@implementation BalanceTableViewCell

+(instancetype)cellWithTableViewCell:(UITableView *)tableView
{
    static NSString * ID = @"ID";
    BalanceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[BalanceTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
        
        UILabel * l1 = [[UILabel alloc]initWithFrame:CGRectMake(margin, margin/2, self.width/2-2*margin, 20)];
        l1.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:l1];
        self.l1 = l1;
        
        UILabel * l2 = [[UILabel alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(l1.frame)+margin/2, self.width/2, 20)];
        l2.textColor = ZQColor(129, 129, 129);
        l2.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:l2];
        self.l2 = l2;
        
        UILabel * l3 = [[UILabel alloc]initWithFrame:CGRectMake(self.width-self.width/2+margin, margin/2, self.width/2-margin*2, 20)];
        l3.textAlignment = 2;
        self.l3 = l3;
        l3.textColor = [UIColor redColor];
        [self.contentView addSubview:l3];
        
        UILabel * l4 = [[UILabel alloc]initWithFrame:CGRectMake(self.width-self.width/2+margin, CGRectGetMaxY(l1.frame)+margin/2, self.width/2-margin*2, 20)];
        l4.textColor = ZQColor(129, 129, 129);
        l4.textAlignment = 2;
        l4.font = [UIFont systemFontOfSize:11];
        self.l4 = l4;
        [self.contentView addSubview:l4];


        
        
    }
    return self;
}
-(void)setindexPath:(NSIndexPath *)indexPath
{
    
//    self.l1.text = @"购物送积分";
//    self.l2.text = @"2015-6 19：19：25";
//    self.l3.text = @"+200";
//    self.l4.text = @"交易成功";
    
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

-(void)setBalanceCellModel:(BalanceCellMOdel *)balanceCellModel
{
    _balanceCellModel = balanceCellModel;
    
    if (![balanceCellModel.ctitle isKindOfClass:[NSNull class]]) {
        self.l1.text = balanceCellModel.ctitle;
    }
    if (![balanceCellModel.creattime isKindOfClass:[NSNull class]]) {
        self.l2.text =balanceCellModel.creattime;
    }
    if (![balanceCellModel.money isKindOfClass:[NSNull class]]) {
        self.l3.text = balanceCellModel.money;
    }
    
    
    self.l4.text = @"交易成功";

    
}

@end
