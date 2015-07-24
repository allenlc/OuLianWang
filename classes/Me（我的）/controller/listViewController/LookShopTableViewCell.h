//
//  LookShopTableViewCell.h
//  OuLianWang
//
//  Created by allenariel on 15/7/7.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookShopTableViewCell : UITableViewCell
+(NSString *)myIdentify;
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,copy)void(^chatBlock)();
@property(nonatomic,copy)void(^callBlock)();


@end
