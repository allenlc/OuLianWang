//
//  CuxiaoFourTableViewCell.h
//  OuLianWang
//
//  Created by allenariel on 15/7/7.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CuxiaoFourTableViewCell : UITableViewCell
+(NSString *)myIdentify;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *moreLabel;
@property(nonatomic,strong)UILabel *manyPeopleLabel;
@property(nonatomic,copy)void(^moreBlock)();

@end
