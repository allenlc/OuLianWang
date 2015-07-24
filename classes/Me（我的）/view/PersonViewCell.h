//
//  PersonViewCell.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/23.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonItem.h"
@interface PersonViewCell : UITableViewCell
@property(nonatomic,strong)PersonItem * item;
/** 类方法 供cell初始化  */
+(instancetype)cellWithTableViewCell:(UITableView *)tableView;
-(void)setindexPath:(NSIndexPath *)indexPath rowInSecton:(int)rows;
@end
