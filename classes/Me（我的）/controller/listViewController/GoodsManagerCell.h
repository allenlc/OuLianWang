//
//  GoodsManagerCell.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/6.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsManagerCell : UITableViewCell
/** 类方法 供cell初始化  */
+(instancetype)cellWithTableViewCell:(UITableView *)tableView;
-(void)setindexPath:(NSIndexPath *)indexPath;
@end
