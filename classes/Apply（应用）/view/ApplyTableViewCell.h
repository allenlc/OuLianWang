//
//  ApplyTableViewCell.h
//  OuLianWang
//
//  Created by allenariel on 15/6/18.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *moreLabel;
@property(nonatomic,strong)UIImageView *lineImageView;
@property(nonatomic,strong)UIImageView *lookImageView;

+(NSString *)myIdentify;

@end
