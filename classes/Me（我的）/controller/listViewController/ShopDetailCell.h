//
//  ShopDetailCell.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/27.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EstimateModel.h"
@interface ShopDetailCell : UITableViewCell
/** 类方法 供cell初始化  */
+(instancetype)cellWithTableViewCell:(UITableView *)tableView;
@property(nonatomic,strong  )EstimateModel * estimateModel;
@end
