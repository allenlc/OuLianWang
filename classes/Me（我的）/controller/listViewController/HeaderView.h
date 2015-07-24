//
//  HeaderView.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/23.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HeaderView;
@protocol headerDelegate <NSObject>

-(void)btnSelect:(HeaderView *)headerView andBtn:(UIButton *)senderBtn;

@end
@interface HeaderView : UIView
+ (HeaderView *)sharedManagerWithFrame:(CGRect )frame;
@property(nonatomic,weak)UIButton * btn;
-(void)selectBtn:(UIButton *)btn;
@property(nonatomic,weak)id<headerDelegate>delegate;
@end
