//
//  IntegeralTableViewCell.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/17.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "IntegeralTableViewCell.h"
#define margin 20
@implementation IntegeralTableViewCell

+(instancetype)cellWithTableViewCell:(UITableView *)tableView
{
    static NSString * ID = @"ID";
    IntegeralTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IntegeralTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
        
    }
    return self;
}
-(void)setindexPath:(NSIndexPath *)indexPath
{
//        for (UIView * view in self.contentView.subviews) {
//            [view removeFromSuperview];
//        }
    self.l1.text = @"购物送积分";
    self.l2.text = @"2015-6 19：19：25";
    self.l3.text = @"+200";
    
    
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
-(void)setModel:(IntegralModel *)model
{
    _model = model;
    self.l1.text = _model.jftitle;
    self.l2.text = _model.operatime;
    self.l3.text = _model.jf;
    
}
@end
