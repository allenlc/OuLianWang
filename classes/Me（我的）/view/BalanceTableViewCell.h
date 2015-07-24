//
//  BalanceTableViewCell.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/17.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BalanceCellMOdel.h"
@interface BalanceTableViewCell : UITableViewCell
@property(nonatomic,weak)UILabel * l1;
@property(nonatomic,weak)UILabel * l2;
@property(nonatomic,weak)UILabel * l3;
@property(nonatomic,weak)UILabel * l4;
@property(nonatomic,strong)BalanceCellMOdel * balanceCellModel;
/** 类方法 供cell初始化  */
+(instancetype)cellWithTableViewCell:(UITableView *)tableView;

-(void)setindexPath:(NSIndexPath *)indexPath;
@end
