//
//  ThirdTableViewCell.h
//  OuLianWang
//
//  Created by hsmj on 15/6/18.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^myBlock)(UIButton *btn);

@interface ThirdTableViewCell : UITableViewCell
@property(nonatomic,weak)UIButton * currentBtn;
@property(nonatomic,strong)NSMutableArray *allBtn;
@property(nonatomic,copy)void(^myBlock1)(UIButton *btn);
@property(nonatomic,copy)void(^myBlock2)(UIButton *btn);
@property(nonatomic,copy)void(^myBlock3)(UIButton *btn);
@property(nonatomic,copy)void(^myBlock4)(UIButton *btn);

-(void)setFirstClick;


+(CGFloat )myHeight;

@end
