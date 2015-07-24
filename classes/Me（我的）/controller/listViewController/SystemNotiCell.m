//
//  SystemNotiCell.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/30.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "SystemNotiCell.h"

@implementation SystemNotiCell
+(instancetype)cellWithTableViewCell:(UITableView *)tableView
{
    static NSString * ID = @"ID";
    SystemNotiCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SystemNotiCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];//设置为黑色粗体
        
        //清除cell的颜色
        self.backgroundColor = [UIColor whiteColor];
        UIImageView * bgImgView = [[UIImageView alloc]init];
        self.backgroundView =bgImgView;
        self.selectedBackgroundView = [[UIImageView alloc]init];
        self.selectionStyle = 0;
        
        UIImageView  *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 50, 50)];
        imgView.image = [UIImage imageNamed:@"hyxx"];
        [self.contentView addSubview:imgView];
        
        UIImageView  *imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 75, self.width, 1)];
        imgView1.backgroundColor = ZQColor(232, 232, 232);
        [self.contentView addSubview:imgView1];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(80, 10, self.width-80, 20)];
        label.text = @"促销推广信息";
        [self.contentView addSubview:label];
        
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(80, 30, self.width-80, 40)];
        [self.contentView addSubview:label1];
        label1.numberOfLines = 0;
        label1.text = @"家居大甩卖";
        label1.textColor = [UIColor grayColor];
    }
    return self;
}
-(void)setindexPath:(NSIndexPath *)indexPath
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
