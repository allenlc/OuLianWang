//
//  MyDistributorVC.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/8.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "MyDistributorVC.h"
#import "MyDistributorCell.h"
#import "OLWTabBarController.h"
#import "SaleDetailVC_One.h"
#import "SaleDetailVC_Two.h"
@interface MyDistributorVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UIButton * currentBtn;
    UIImageView * topImgView ;
}
@end

@implementation MyDistributorVC

-(void)loadView
{
    [super loadView];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.size = CGSizeMake(26, 20);
    [btn setImage:[UIImage imageNamed:@"fenl"] forState:0];
    UIBarButtonItem * rithtBar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rithtBar;
}
-(void)viewWillAppear:(BOOL)animated
{
    OLWTabBarController * VC =(OLWTabBarController *) self.tabBarController;
    VC.zqTabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的分销商";
    [self creatTopBtn];
    [self createTableView];
    [self createBotView ];
}

-(void)creatTopBtn
{
    NSArray * arr = @[@"我店铺的分销商",@"我分销的店铺"];
    topImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, 40)];
    topImgView.userInteractionEnabled = YES;
    topImgView.image = [UIImage imageNamed:@"topBG1"];
    topImgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topImgView];
    for (int i = 0; i<2; i++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:arr[i] forState:0];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        btn.tag = i+100;
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.frame = CGRectMake(self.view.width/2*i, 0, self.view.width/2, 40);
        [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [topImgView addSubview:btn];
    }
    currentBtn = (UIButton *)[topImgView viewWithTag:100];
    currentBtn.selected = YES;
}
-(void)selectBtn:(UIButton *)sender
{
    topImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"topBG%d",sender.tag-99]];
    currentBtn.selected = NO;
    currentBtn = sender;
    currentBtn.selected = YES;
    [self.tableView reloadData];
    
}
-(void)createTableView
{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topImgView.frame), self.view.width, self.view.height-topImgView.height-100) style:UITableViewStylePlain];
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
    
    return 10;//下载数据
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyDistributorCell * cell = [MyDistributorCell cellWithTableViewCell:tableView];
    [cell setindexPath:indexPath];
    switch (currentBtn.tag) {
        case 100:
        {
            cell.titleLabel.text = @"小范";
            cell.iconImgView .image = [UIImage imageNamed:@"toutouxx1"];
            [cell setEnterBlock:^(MyDistributorCell *cell) {
                 [self.navigationController pushViewController:[SaleDetailVC_One new] animated:YES];
            }];

        }
            break;
        case 101:
        {
            cell.titleLabel.text = @"小范的店铺";
            cell.iconImgView .image = [UIImage imageNamed:@"wdfxs_dptx"];
            [cell setEnterBlock:^(MyDistributorCell *acell) {
                 SaleDetailVC_Two * VC = [SaleDetailVC_Two new];
                [self.navigationController pushViewController:VC animated:YES];
                VC.topCell = acell;

            }];

        }
            break;
        default:
            break;
    }
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    


}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 110;
    
}

@end
