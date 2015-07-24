//
//  XiTongTableViewCell.h
//  OuLianWang
//
//  Created by allenariel on 15/6/24.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XiTongTableViewCell : UITableViewCell
+(NSString *)myIdentify;
+(CGFloat)myHeight;
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *namaLabel;

@end
