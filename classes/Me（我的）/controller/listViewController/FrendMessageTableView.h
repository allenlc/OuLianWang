//
//  FrendMessageTableView.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/30.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FrendMessageTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
+ (FrendMessageTableView *)sharedManager;
@property(nonatomic,assign)int shumuSms;
@end
