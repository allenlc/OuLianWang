//
//  MyExpressVController.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/2.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "MyExpressVController.h"
#import "MyExpressCell.h"
#import "NearExpressTableView.h"
#import "MyExpressTableView.h"
#import "ScanIndentNumber.h"
@interface MyExpressVController ()<UIScrollViewDelegate>
{
    UIScrollView * myScrollView;
    UIButton * currentSelectBtn;
    UIView * titleView ;
}
@end

@implementation MyExpressVController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle];
    myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height+64)];
    myScrollView.contentSize = CGSizeMake(self.view.width*2, self.view.height-64);
    myScrollView.pagingEnabled = YES;
    myScrollView.bounces = NO;
    myScrollView.delegate = self;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myScrollView];
     [self creatTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma 设置导航栏
-(void)setNavigationTitle
{
    
    UIButton *fabubutton1=[UIButton buttonWithType:UIButtonTypeCustom];
    [fabubutton1  setImage:[UIImage imageNamed:@"kuaidisaoyisao"] forState:UIControlStateNormal];
    [fabubutton1 addTarget:self action:@selector(scan) forControlEvents:UIControlEventTouchUpInside];
    fabubutton1.frame=CGRectMake(0, 0, 25, 25);
    UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc]initWithCustomView:fabubutton1];
    self.navigationItem.rightBarButtonItem=rightBtn;
    
    titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width/2, 30)];
    titleView.layer.cornerRadius = 2;
    titleView.backgroundColor = [UIColor whiteColor];
    
    NSArray * arr = @[@"附近的快递",@"我发的快递"];
    
    for (int i = 0; i<2; i++) {
        UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.backgroundColor = ZQColor(201, 0, 9);
        btn1.tag = 100+i;
        btn1.titleLabel.font = [UIFont systemFontOfSize:14];
        btn1.frame = CGRectMake(2+titleView.width/2*i, 2, titleView.width/2-4, titleView.height-4);
        [btn1 setTitle:arr[i] forState:0];
        [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn1 setTitleColor:ZQColor(201, 0, 9) forState:UIControlStateSelected];
        [btn1 addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:btn1];

    }
     self.navigationItem.titleView = titleView;
    currentSelectBtn = (UIButton *)[titleView viewWithTag:100];
    currentSelectBtn.backgroundColor = [UIColor whiteColor];
    currentSelectBtn.selected = YES;
   
}

-(void)selectBtn:(UIButton *)sender
{
    currentSelectBtn.selected = NO;
    currentSelectBtn.backgroundColor = ZQColor(201, 0, 9);
    currentSelectBtn = sender;
    currentSelectBtn.selected = YES;
    currentSelectBtn.backgroundColor = [UIColor whiteColor];
    
    myScrollView.contentOffset = CGPointMake(self.view.width*(sender.tag-100), -64);
}

#pragma mark -creatTableView
-(void)creatTableView
{
    NearExpressTableView * tableView = [[NearExpressTableView alloc]initWithStyle:UITableViewStylePlain];
    tableView.view.frame = CGRectMake(0, 0, self.view.width, self.view.height-64);
   tableView.tableView.separatorStyle = 0;
    [self addChildViewController:tableView];
    [myScrollView addSubview:tableView.view];
    
    MyExpressTableView * tableView1 = [[MyExpressTableView alloc]initWithStyle:UITableViewStylePlain];
    tableView1.view.frame = CGRectMake(self.view.width, 0, self.view.width, self.view.height-64);
    tableView1.tableView.separatorStyle = 0;
    [self addChildViewController:tableView1];
    [myScrollView addSubview:tableView1.view];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   
    
    currentSelectBtn.selected = NO;
    currentSelectBtn.backgroundColor = ZQColor(201, 0, 9);
    currentSelectBtn = (UIButton *)[titleView viewWithTag:scrollView.contentOffset.x/self.view.width+100];
    currentSelectBtn.selected = YES;
    currentSelectBtn.backgroundColor = [UIColor whiteColor];

    
}

#pragma mark -扫描订单号方法-
-(void)scan
{
    [self.navigationController pushViewController:[ScanIndentNumber new] animated:YES];
}
@end
