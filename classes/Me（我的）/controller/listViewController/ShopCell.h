//
//  ShopCell.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/24.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCartItem.h"
@interface ShopCell : UITableViewCell
@property(nonatomic,strong)ShopCartItem * item;
@property(nonatomic,weak)UIButton * selectBtn;
@property(nonatomic,weak)UILabel * titleLabel;
@property(nonatomic,weak)UILabel * shuxinLabel;
@property(nonatomic,strong)UILabel * accountLabel;
@property(nonatomic,strong)UILabel * numberLabel;
@property(nonatomic,weak)UIImageView *iconImg;
@property(nonatomic,copy)void(^accountBlock)(UIButton * btn);
@property(nonatomic,copy)void(^removeBlock)(ShopCell * cell);
@property(nonatomic,copy)void(^editBlock)(int tag);

/** 类方法 供cell初始化  */
+(instancetype)cellWithTableViewCell:(UITableView *)tableView;
-(void)setindexPath:(NSIndexPath *)indexPath rowInSecton:(int)rows;
@end
