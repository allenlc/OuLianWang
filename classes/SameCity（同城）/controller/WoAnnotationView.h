//
//  WoAnnotationView.h
//  OuLianWang
//
//  Created by allenariel on 15/6/23.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <AMapNaviKit/AMapNaviKit.h>
#import "ShopModel.h"

@interface WoAnnotationView : MAAnnotationView
@property(nonatomic,strong)UIImageView *annoImageView;
@property(nonatomic,strong)UIImageView *logoImageView;

//起泡
@property(nonatomic,strong)UIImageView *photoImageView;
@property(nonatomic,strong)UILabel *bigNameLabel;
@property(nonatomic,strong)UILabel *moreNameLabel;
@property(nonatomic,copy)void(^mapBlcok)(ShopModel *mm);
@property (nonatomic, strong) ShopModel *model;

@end
