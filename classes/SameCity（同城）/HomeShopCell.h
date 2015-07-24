//
//  HomeShopCell.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/29.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleScrollView.h"
@class HomeShopModel;
@class HomeModel;
@interface HomeShopCell : UITableViewCell
{
    UIButton * currentBtn;
    UIView * view2;
}
/** 类方法 供cell初始化  */
+(instancetype)cellWithTableViewCell:(UITableView *)tableView;
@property(nonatomic,strong)CycleScrollView *mainScorllView;
@property(nonatomic,copy)void(^imageBlock)();
@property(nonatomic,copy)void(^enterDetailBlock)(void);
@property(nonatomic,weak)UIButton * selectBtn;
-(void)setindexPath:(NSIndexPath *)indexPath;

@property(nonatomic,strong)HomeModel *homeModel;
@property(nonatomic,copy)NSString *meter;


@property(nonatomic,strong)HomeShopModel *model1;
@property(nonatomic,strong)HomeShopModel *model2;
@property(nonatomic,copy)void(^daoHangBlock)(HomeModel *myModel);


@end
