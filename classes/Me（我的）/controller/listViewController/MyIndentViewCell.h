//
//  MyIndentViewCell.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/24.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyIndentItem.h"
@interface MyIndentViewCell : UITableViewCell
{
    UILabel * orderidLabel;
    UILabel * gnameLabel;
    UILabel * priceLabel;
    UILabel * totalLabel;
    UILabel * numsLabel;
     UILabel * catchtimeLabel;
    UIImageView * goods_imgview;
    UILabel * statusLable;
}
@property(nonatomic,strong)MyIndentItem * item;
/** 类方法 供cell初始化  */

+(instancetype)cellWithTableViewCell:(UITableView *)tableView;
-(void)setindexPath:(NSIndexPath *)indexPath rowInSecton:(int)rows;

@end
