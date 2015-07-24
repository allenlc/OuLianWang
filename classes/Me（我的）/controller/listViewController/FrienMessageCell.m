//
//  FrienMessageCell.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/30.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "FrienMessageCell.h"

@implementation FrienMessageCell

+(instancetype)cellWithTableViewCell:(UITableView *)tableView
{
    static NSString * ID = @"ID";
    FrienMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FrienMessageCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
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
        
        self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 60, 60)];
        _iconImageView.layer.cornerRadius=30;
        _iconImageView.image = [UIImage imageNamed:@"touxiangtouxiang1.jpg.png"];
        _iconImageView.clipsToBounds=YES;
        [self.contentView addSubview:_iconImageView];
        
        UIImageView  *imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 75, self.width, 1)];
        imgView1.backgroundColor = ZQColor(232, 232, 232);
        [self.contentView addSubview:imgView1];
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 10, 150, 20)];
        _nameLabel.text = @"我连网群聊室";
        [self.contentView addSubview:_nameLabel];
        
        self.messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 30, self.width-80, 40)];
        [self.contentView addSubview:_messageLabel];
        _messageLabel.numberOfLines = 0;
        _messageLabel.text = @"欢迎进入我连群聊室";
        _messageLabel.font=[UIFont systemFontOfSize:11];
        _messageLabel.textColor = [UIColor grayColor];
        
        self.shumulabel=[[UILabel alloc]initWithFrame:CGRectMake(270, 25, 30, 30)];
        _shumulabel.layer.cornerRadius=15;
        _shumulabel.layer.masksToBounds=YES;
        _shumulabel.textAlignment=1;
        _shumulabel.layer.borderWidth=1;
        _shumulabel.layer.borderColor=[UIColor whiteColor].CGColor;
        _shumulabel.backgroundColor=[UIColor orangeColor];
        _shumulabel.textColor=[UIColor whiteColor];
        [self.contentView addSubview:_shumulabel];
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
