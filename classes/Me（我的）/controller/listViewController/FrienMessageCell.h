//
//  FrienMessageCell.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/30.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FrienMessageCell : UITableViewCell
/** 类方法 供cell初始化  */
+(instancetype)cellWithTableViewCell:(UITableView *)tableView;
-(void)setindexPath:(NSIndexPath *)indexPath;
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *messageLabel;
@property(nonatomic,strong)UILabel *shumulabel;
@end
