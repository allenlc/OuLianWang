//
//  NearExpressTableView.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/2.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "NearExpressTableView.h"
#import "MyExpressCell.h"
@interface NearExpressTableView ()

@end

@implementation NearExpressTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
}



#pragma -mark 数据源和代理方法


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 15;//下载数据
    
    
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
