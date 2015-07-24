//
//  MyExpressCell.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/2.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyExpressCell : UITableViewCell
/** 类方法 供cell初始化  */
+(instancetype)cellWithTableViewCell:(UITableView *)tableView;
-(void)setindexPath:(NSIndexPath *)indexPath rowInSecton:(int)rows;
@end
