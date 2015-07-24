//
//  MyShopCell.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/27.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleScrollView.h"
#import "WDDPGoodsModel.h"
#import "WDDPModel.h"
#import "StarView.h"
#import "CyclePics.h"
@interface MyShopCell : UITableViewCell
{
    UIButton * currentBtn;
    UIView * view2;
    UIImageView *imageview;
    UILabel *olabel;
    StarView * startView;
    UIView * leftview;
}
/** 类方法 供cell初始化 */
+(instancetype)cellWithTableViewCell:(UITableView *)tableView;
@property(nonatomic,strong)CycleScrollView *mainScorllView;
@property(nonatomic,copy)void(^imageBlock)();
@property(nonatomic,copy)void(^enterDetailBlock)(void);
@property(nonatomic,weak)UIButton * selectBtn;
@property(nonatomic,copy)WDDPGoodsModel * goodsModel1;
@property(nonatomic,copy)WDDPGoodsModel * goodsModel2;
@property(nonatomic,copy)WDDPModel * wddpModel;
@property(nonatomic,weak)UIImageView  * goodsImgView;
@property(nonatomic,weak)UILabel  * goodsNameLabel;
@property(nonatomic,weak)UILabel * goodsPrice;
@property(nonatomic,weak)UILabel *goodsOriginPrice;
@property(nonatomic,weak)UILabel * hasSales;
@property(nonatomic,strong)NSMutableArray * cyclePics;

-(void)setindexPath:(NSIndexPath *)indexPath;


@end
