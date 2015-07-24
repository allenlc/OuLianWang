//
//  NearTableViewCell.h
//  exex
//
//  Created by allenariel on 15/6/26.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearTableViewCell : UITableViewCell
-(void)createUIWith:(NSMutableArray *)dataArray;

@property(nonatomic,strong)UILabel *titleLabel;

@end
