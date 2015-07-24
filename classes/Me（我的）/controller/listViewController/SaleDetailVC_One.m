//
//  SaleDetailVC_One.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/8.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "SaleDetailVC_One.h"
#import "OLWTabBarController.h"
@interface SaleDetailVC_One ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)UITableView * tableView;
@end

@implementation SaleDetailVC_One

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"销售详情";
    [self createTableView];
    [self createBotView];
}
-(void)viewWillAppear:(BOOL)animated
{
    OLWTabBarController * VC =(OLWTabBarController *) self.tabBarController;
    VC.zqTabBar.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createTableView
{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height+10) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}
-(void)createBotView
{
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.height-40, self.view.width,40)];
    [btn addTarget:self action:@selector(selectBotBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = ZQColor(250, 49, 15);
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    [btn setTitle:@"发放通知" forState:0];
    [self.view addSubview:btn];
    
    
}
-(void)selectBotBtn:(UIButton *)sender
{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ID = @"ID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 60, 60)];
        imgView.tag = 120;
        [cell.contentView addSubview:imgView];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(90, 20, self.view.width-90, 20)];
        label.tag = 121;
        [cell.contentView addSubview:label];
        
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(90, 50, self.view.width-90, 20)];
        label1.tag = 122;
        [cell.contentView addSubview:label1];
        
        
    }
    UIImageView * imgView = (UIImageView *   )[cell.contentView viewWithTag:120];
    imgView.image = [UIImage imageNamed:@"dianpuxiangqingtouxiang"];
    
    UILabel * label = (UILabel *)[cell.contentView viewWithTag:121];
    label.text = @"2015062111订单已交易成功";
    
    UILabel * label1 = (UILabel *)[cell.contentView viewWithTag:122];
    label1.text = @"订单号为2015062111订单已交易成功";
    label1.font = [UIFont systemFontOfSize:12];
     return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
@end
