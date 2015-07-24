//
//  CityTwoTableViewCell.h
//  OuLianWang
//
//  Created by allenariel on 15/7/2.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLTreeViewNode.h"

@interface CityTwoTableViewCell : UITableViewCell
@property (retain,strong,nonatomic) CLTreeViewNode *node; //data
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,copy)void(^setCityBlock)();

@end
