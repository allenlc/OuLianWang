//
//  MyDistributorCell.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/8.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyDistributorCell : UITableViewCell

@property(nonatomic,weak)UIImageView * iconImgView;
@property(nonatomic,weak)UILabel * titleLabel;
/** 类方法 供cell初始化  */
+(instancetype)cellWithTableViewCell:(UITableView *)tableView;
-(void)setindexPath:(NSIndexPath *)indexPath;
@property(nonatomic,copy)void(^enterBlock)(MyDistributorCell *cell);
@end
