//
//  FirstTableViewCell.h
//  OuLianWang
//
//  Created by hsmj on 15/6/15.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"
#import "DianPModel.h"
@interface FirstTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *lookImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)StarView *starView;
@property(nonatomic,strong)UIView *licenceView;
@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,strong)UILabel *lichengLabel;
@property(nonatomic,strong)UIImageView *dituView;
@property(nonatomic,strong)UILabel  *nowIsNo;

-(void)createUI;
+(CGFloat )myHeight;

@end
