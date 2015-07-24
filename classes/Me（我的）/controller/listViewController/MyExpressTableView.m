//
//  MyExpressTableView.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/2.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "MyExpressTableView.h"
#import "MyExpressCell.h"
@interface MyExpressTableView ()

@end

@implementation MyExpressTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma -mark 数据源和代理方法


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 5;//下载数据
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    MyExpressCell * cell = [[MyExpressCell alloc]init];
    
    return cell;
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 82;
}


@end
