//
//  SaleDetailVC_Two.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/8.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "SaleDetailVC_Two.h"
#import "OLWTabBarController.h"
@interface SaleDetailVC_Two ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)UITableView * tableView;
@end

@implementation SaleDetailVC_Two

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
    tableView.separatorStyle = 0;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}
-(void)createBotView
{
    
    NSArray * arr = @[@"订单统计",@"推广店铺"];
    for (int i = 0; i<2; i++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.width/2*i, self.view.height-40, self.view.width/2,40)];
        [btn addTarget:self action:@selector(selectBotBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = ZQColor(250, 49, 15);
        [btn setTitleColor:[UIColor whiteColor] forState:0];
        [btn setTitle:arr[i] forState:0];
        [self.view addSubview:btn];
    }
}

-(void)selectBotBtn:(UIButton *)sender
{
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return 1;
    }
    else
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
      UITableViewCell *   cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15,60,60)];
        [cell1.contentView addSubview:imgView];
        cell1.selectionStyle=0;
        imgView.image = self.topCell.iconImgView.image;
        //
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(90, 15, 100, 20)];
        label1.textColor = ZQColor(63 , 63, 63);
        label1.font = [UIFont systemFontOfSize:14];
        [cell1.contentView addSubview:label1];
        label1.text = self.topCell.titleLabel.text;
        //
        
        UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(90, 35,80, 20)];
        label2.textColor = [UIColor grayColor];
        label2.text = @"销量：200";
        label2.font = [UIFont systemFontOfSize:13];
        [cell1.contentView addSubview:label2];
        
        UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(90, 55, 150, 20)];
        label3.textColor = [UIColor grayColor];
        label3.text = @"分销时间:2015-06-18";
        label3.font = [UIFont systemFontOfSize:13];
        [cell1.contentView addSubview:label3];
        
        UILabel * label4 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.width/2, 15, self.view.width/2-15, 20)];
        label4.textAlignment = 2;
        label4.textColor = ZQColor(63 , 63, 63);
        label4.text = @"分销收入 ￥200";
        label4.font = [UIFont systemFontOfSize:14];
        [cell1.contentView addSubview:label4];
        
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.width-90, 45, 70, 27)];
        [btn addTarget:self action:@selector(enterDetailView) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:[UIImage imageNamed:@"fenxiaoxiaoshoutuiguang"] forState:0];
        [cell1.contentView addSubview:btn];
        UIImageView * imgView1 =[[UIImageView alloc]initWithFrame:CGRectMake(0, 80, self.view.width, 1)];
        imgView1.backgroundColor = ZQColor(193, 194, 196);
        [cell1.contentView addSubview:imgView1];
        
        UIImageView * imgView2 =[[UIImageView alloc]initWithFrame:CGRectMake(0, 81, self.view.width, 9)];
        imgView2.backgroundColor = ZQColor(230, 230, 230);
        [cell1.contentView addSubview:imgView2];

        return cell1;
    }
    else{
        static NSString * ID = @"ID";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
   
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = 0;
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
        
        UIImageView * imgView1 =[[UIImageView alloc]initWithFrame:CGRectMake(0, 79, self.view.width, 1)];
        imgView1.backgroundColor = ZQColor(193, 194, 196);
        [cell.contentView addSubview:imgView1];

        return cell;
}
   
    
}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 10;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 90;
    }
else
    return 81;
}

-(void)enterDetailView
{
    
}
@end
