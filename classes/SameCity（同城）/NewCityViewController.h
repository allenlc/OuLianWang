//
//  NewCityViewController.h
//  OuLianWang
//
//  Created by allenariel on 15/7/2.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "ListViewController.h"

@interface NewCityViewController : ListViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UITableView* myTableView;

@end
