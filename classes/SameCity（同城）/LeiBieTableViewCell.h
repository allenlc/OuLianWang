//
//  LeiBieTableViewCell.h
//  OuLianWang
//
//  Created by hsmj on 15/6/26.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeiBieTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView *imageview;

@property(nonatomic,strong) UILabel * titlelabel;

@property(nonatomic,strong) UIImageView *imageview1;

@property(nonatomic,strong) UILabel * titlelabel1;

@property(nonatomic,strong) void (^imageblock)();

@end
