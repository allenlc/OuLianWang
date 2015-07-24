//
//  JHSCell.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/27.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleScrollView.h"
#import "JHSModel.h"

@interface JHSCell : UITableViewCell
/** 类方法 供cell初始化  */
+(instancetype)cellWithTableViewCell:(UITableView *)tableView;
@property(nonatomic,strong)CycleScrollView *mainScorllView;
@property(nonatomic,copy)void(^imageBlock)();
@property(nonatomic,weak)UIButton * selectBtn;
-(void)setindexPath:(NSIndexPath *)indexPath;

@property(nonatomic,strong) NSMutableArray *dataimageArray;
@property(nonatomic,strong) UIImageView * imgView;
@property(nonatomic,strong) UIImageView * imgView1;
@property(nonatomic,strong) UILabel * label1;
@property(nonatomic,strong) UILabel * label2;
@property(nonatomic,strong) UILabel * label3;
@property(nonatomic,strong) UILabel * label4;
@property(nonatomic,strong) UILabel * label5;
@property(nonatomic,strong) UIImageView * imgView2;
@property(nonatomic,copy) NSString *oldPrice;


@property(nonatomic,strong) JHSModel *model1;

@property(nonatomic,strong) JHSModel *model2;



@end
