//
//  ListViewTableViewCell.h
//  OuLianWang
//
//  Created by allenariel on 15/6/27.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"
@class ShopModel;
@interface ListViewTableViewCell : UITableViewCell
+(NSString *)myIdentify;
+(CGFloat)myHeight;
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *storenameLabel;
@property(nonatomic,strong)UILabel *informationLabel;
@property(nonatomic,strong)StarView *starView;
@property(nonatomic,strong)UILabel *reginLabel;
@property(nonatomic,strong)UILabel *distanceLabel;

@property(nonatomic,strong)ShopModel *shopModel;

-(void)createUI;


@end
