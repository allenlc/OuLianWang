//
//  SecondTableViewCell.h
//  OuLianWang
//
//  Created by hsmj on 15/6/18.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleScrollView.h"

@interface SecondTableViewCell : UITableViewCell
{
    UIImageView * cycleImgView;
    NSMutableArray *viewsArray;
}
@property(nonatomic,strong)CycleScrollView *mainScorllView;
@property(nonatomic,strong)UIImageView *bigImageView;

@property(nonatomic,strong) NSMutableArray *imagearray;

+(CGFloat )myHeight;

@end
