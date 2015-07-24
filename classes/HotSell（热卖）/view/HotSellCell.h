//
//  HotSellCell.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/15.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleScrollView.h"

@interface HotSellCell : UITableViewCell

/** 类方法 供cell初始化  */
+(instancetype)cellWithTableViewCell:(UITableView *)tableView;
@property(nonatomic,strong)CycleScrollView *mainScorllView;
@property(nonatomic,copy)void(^imageBlock)();
@property(nonatomic,weak)UIButton * selectBtn;
-(void)setindexPath:(NSIndexPath *)indexPath;

@property(nonatomic,strong)NSMutableArray *  imageviewsArray;



@end
