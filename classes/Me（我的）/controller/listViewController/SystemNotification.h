//
//  SystemNotification.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/30.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SystemNotification : UITableView<UITableViewDelegate,UITableViewDataSource>
+ (SystemNotification *)sharedManager;
@end
