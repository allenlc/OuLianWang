//
//  CollectTableViewCell.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/17.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectTableViewCell : UITableViewCell
@property(nonatomic,weak)UIImageView  * imgView;
@property(nonatomic,weak)UILabel * titleLabel;
@property(nonatomic,weak)UILabel * priceLabel;

/** 类方法 供cell初始化  */
+(instancetype)cellWithTableViewCell:(UITableView *)tableView;
-(void)setindexPath:(NSIndexPath *)indexPath;
@end
