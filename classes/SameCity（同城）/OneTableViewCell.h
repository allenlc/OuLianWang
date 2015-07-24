//
//  OneTableViewCell.h
//  OuLianWang
//
//  Created by hsmj on 15/6/29.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YDModel;
@interface OneTableViewCell : UITableViewCell

@property(nonatomic,strong)UIButton *xuanzeButton;

@property(nonatomic,strong)UIImageView *imageview;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *changLabel;

@property(nonatomic,strong)UILabel *kuanLabel;

@property(nonatomic,strong)UILabel *gaoLabel;

@property(nonatomic,strong)UILabel *xinghaoLabel;

@property(nonatomic,strong)UILabel *yanseLabel;

@property(nonatomic,strong)UILabel *yuanpriceLabel;

@property(nonatomic,strong)UILabel *xianpriceLabel;

@property(nonatomic,strong)UIButton *jiabutton;

@property(nonatomic,strong)UIButton *jianbutton;

@property(nonatomic,strong)UILabel *priceLabel;

@property(nonatomic,strong)void (^jianblock)(YDModel *model);

@property(nonatomic,strong)void (^jiablock)(YDModel *model);

@property(nonatomic,strong)void (^priceblock11)(YDModel *model);
@property(nonatomic,strong)void (^priceblock22)(YDModel *model);

@property(nonatomic,assign)int count;

@property(nonatomic,strong)YDModel *ydModel;

@end
