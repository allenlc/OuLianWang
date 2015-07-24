//
//  ShopTableViewCell.h
//  OuLianWang
//
//  Created by hsmj on 15/7/6.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyIndentItem.h"
@interface ShopTableViewCell : UITableViewCell

@property(nonatomic,strong)MyIndentItem * item;
/** 类方法 供cell初始化  */
+(instancetype)cellWithTableViewCell:(UITableView *)tableView;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)setindexPath:(NSIndexPath *)indexPath rowInSecton:(int)rows;


@end
