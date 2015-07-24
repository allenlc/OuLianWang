//
//  MyExpressCell.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/2.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "MyExpressCell.h"

@implementation MyExpressCell

+(instancetype)cellWithTableViewCell:(UITableView *)tableView
{
    static NSString * ID = @"ID";
    MyExpressCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MyExpressCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
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
        
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 60, 60)];
        imgView.image = [UIImage imageNamed:@"dingdanchanpin"];
        [self.contentView addSubview:imgView];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(80, 20, 160, 20)];
        label.text = @"2015433434订单待送货";
        label.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:label];
        
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(80, 50, 80, 20)];
        label1.font = [UIFont systemFontOfSize:14];
        label1.text = @"距离12km";
        label1.textColor = [UIColor grayColor  ];
        [self.contentView addSubview:label1];
        
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(150, 50, 80, 20)];
        [btn setImage:[UIImage imageNamed:@"dianpuditutubiao"] forState:0];
        [btn setTitle:@"送货路线" forState:0];
        [btn setTitleColor:[UIColor orangeColor] forState:0];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 60, 0, 0)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -60, 0, 0)];
        [self.contentView addSubview:btn];
        
        UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(self.width-80, 25, 60, 30)];
        btn1.layer.cornerRadius = 5;
        btn1.backgroundColor = [UIColor orangeColor];
        [btn1 setTitle:@"抢单" forState:0];
        [self.contentView addSubview:btn1];
       
        
        UIImageView * imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0 , 80, self.width , 2)];
        imgView2.backgroundColor = ZQColor(232, 232, 232);
        
        [self.contentView addSubview:imgView2];

        
        
    }
    return self;
}
-(void)setindexPath:(NSIndexPath *)indexPath rowInSecton:(int)rows
{
  
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
