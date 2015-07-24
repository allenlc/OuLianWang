//
//  WDHJTableViewCell.h
//  OuLianWang
//
//  Created by allenariel on 15/6/24.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"

@interface WDHJTableViewCell : UITableViewCell
+(NSString *)myIdentify;
+(CGFloat)myHeight;

@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)StarView *starView;
@property(nonatomic,strong)UIView *licenceView;
@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,strong)UIImageView *shopImageView;
@property(nonatomic,strong)UILabel *shopLabel;

@end
