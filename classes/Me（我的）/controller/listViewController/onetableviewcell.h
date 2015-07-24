//
//  onetableviewcell.h
//  OuLianWang
//
//  Created by hsmj on 15/7/6.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface onetableviewcell : UITableViewCell

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

@property(nonatomic,strong)void (^jianblock)();

@property(nonatomic,strong)void (^jiablock)();

@property(nonatomic,strong)void (^priceblock)();

@end
