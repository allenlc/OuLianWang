//
//  IntegeralTableViewCell.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/17.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntegralModel.h"
@interface IntegeralTableViewCell : UITableViewCell

@property(nonatomic,weak)UILabel * l1;
@property(nonatomic,weak)UILabel * l2;
@property(nonatomic,weak)UILabel * l3;
@property(nonatomic,strong)IntegralModel * model;
/** 类方法 供cell初始化  */
+(instancetype)cellWithTableViewCell:(UITableView *)tableView;

-(void)setindexPath:(NSIndexPath *)indexPath;
@end
