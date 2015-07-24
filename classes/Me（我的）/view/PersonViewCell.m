//
//  PersonViewCell.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/23.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "PersonViewCell.h"
#import "UIKit+AFNetworking.h"
#import "GetCurrentNaviGationController.h"
#import "CreateCodeViewController.h"
@implementation PersonViewCell

+(instancetype)cellWithTableViewCell:(UITableView *)tableView
{
    static NSString * ID = @"ID";
    PersonViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PersonViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
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
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = 0;
    }
    return self;
}
-(void)setItem:(PersonItem *)item
{
    _item = item;
    self.textLabel.text = item.title;
    
}
//让第一个cell往上面挪30
-(void)setFrame:(CGRect)frame
{
    frame.origin.y -=30;
    [super setFrame:frame];
}
-(void)setindexPath:(NSIndexPath *)indexPath rowInSecton:(int)rows
{
    if (rows==0) {

        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.width-80, 10, 60, 60)];
        [imgView setImageWithURL:[NSURL URLWithString:_item.icon] placeholderImage:[UIImage imageNamed:@"头像"]];
        [self.contentView addSubview:imgView];

    }
   else if (rows==1) {

        UIButton * scanBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width-50, 15, 30, 30)];
       [scanBtn setImage:[UIImage imageNamed:_item.icon] forState:0];
       [scanBtn addTarget:self action:@selector(createScanCode) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:scanBtn];
       
        
    }
    else{
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, self.width-100-20, 30)];
        if (![_item.subtitle isKindOfClass:[NSNull class]]) {
            label.text = _item.subtitle;
        }
        else {
            label.text = @"未知";
        }
        if (indexPath.row==1&&indexPath.section==2) {
            NSLog(@"%d %d",indexPath.row,indexPath.section);
            if ([_item.subtitle isEqualToString:@"0"]) {
                label.text=@"男";
            }
            else
                label.text=@"女";
        }

        label.textColor = ZQColor(107, 105, 106);
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = 2;
        [self.contentView addSubview:label];
    }

}
-(void)createScanCode
{
    [[GetCurrentNaviGationController viewController:self].navigationController pushViewController:[CreateCodeViewController new] animated:YES];
}
@end
