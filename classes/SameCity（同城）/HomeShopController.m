//
//  HomeShopController.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/29.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "HomeShopController.h"
#import "HomeShopCell.h"
#import "YDViewController.h"
#import "OLWTabBarController.h"
#import "HomeModel.h"
#import "HomeShopModel.h"
#import "RoutePlanViewController.h"

@interface HomeShopController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIButton * currentBtn;
    UIView * view2;
    HomeModel *_homeModel;
    UITableView * _tableView;
}
@end

@implementation HomeShopController


-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = ZQColor(214, 214, 214);

    [self creatTableView];
   
    [self  creatfootView];
    
    [self startDownloadData];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    ( (OLWTabBarController *)self.tabBarController).zqTabBar.hidden = YES;
}


#pragma -mark 创建tableView
-(void)creatTableView
{
    _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark---------底部视图
-(void)creatfootView
{
    UIView *footview=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.height-60, 320, 60)];
    footview.backgroundColor=[UIColor  whiteColor];
    [self.view  addSubview:footview];
    footview.userInteractionEnabled=YES;
    
    UIButton *onebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [onebutton  setImage:[UIImage imageNamed:@"商品详情_03.png"] forState:UIControlStateNormal];
    onebutton.frame=CGRectMake(10, 10, 40, 40) ;
    [onebutton  addTarget:self action:@selector(onebuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [onebutton    setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [footview  addSubview:onebutton];
    
    UILabel *onelabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 10, 70, 40)];
    onelabel.text=@"联系客服";
    onelabel.font=[UIFont systemFontOfSize:14];
    [footview  addSubview:onelabel];
    
    UIButton *twobutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [twobutton  setImage:[UIImage imageNamed:@"商品详情_07.png"] forState:UIControlStateNormal];
    twobutton.frame=CGRectMake(320/3+10, 10, 40, 40);
    [twobutton  addTarget:self action:@selector(twobuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [twobutton    setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [footview  addSubview:twobutton];
    
    UILabel *twolabel=[[UILabel alloc]initWithFrame:CGRectMake(320/3+50, 10, 70, 40)];
    twolabel.text=@"加入收藏";
    twolabel.font=[UIFont systemFontOfSize:14];
    [footview  addSubview:twolabel];
    
    UIButton *fifvebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    fifvebutton.backgroundColor=[UIColor redColor];
    [fifvebutton  setTitle:@"立即预定" forState:UIControlStateNormal];
    [fifvebutton  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    fifvebutton.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    [fifvebutton addTarget:self action:@selector(lijiGOumaiClick) forControlEvents:UIControlEventTouchUpInside];
    fifvebutton.frame=CGRectMake(640/3+10, 0, 110, 60) ;
    [footview  addSubview:fifvebutton];
    
}
#pragma mark - 下载数据
-(void)startDownloadData
{
    [MBProgressHUD showMessage:@"正在加载"];
    
    NSString *urlString=[NSString stringWithFormat:TC_JiaJuStore_URL,self.storeId];
    NSLog(@"家具店铺URL %@",urlString);
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        _homeModel=[[HomeModel alloc]init];
        [_homeModel setValuesForKeysWithDictionary:dict[@"list"]];
        for (NSDictionary *dd in dict[@"list"][@"store_goods"]) {
            HomeShopModel *model =[[HomeShopModel alloc]init];
            [model setValuesForKeysWithDictionary:dd];
            [_homeModel.goodsArray addObject:model];
        }
        self.title=_homeModel.storename;
        [_tableView reloadData];
        [MBProgressHUD hideHUD];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",[error description]);
        [MBProgressHUD hideHUD];
    }];
    
}


#pragma mark - 最下面三个按钮的点击事件

-(void)onebuttonClick
{
    
    
}

-(void)twobuttonClick
{
    
    
    
}

-(void)lijiGOumaiClick
{
    
    MyAccount * Account = [MyAccountTool account];
    
    if (Account) {
        YDViewController *controller=[[YDViewController  alloc]init];
        [self.navigationController  pushViewController:controller animated:YES];

    }
    else {
        //2 从没登陆过
        //             * vc =self.viewControllers[self.currentSelectedIndex];
        [self.navigationController pushViewController:[LogInViewController new] animated:YES];
    }

    }


-(void)selectBtn:(UIButton *)sender
{
    currentBtn.selected = NO;
    
    sender.selected = YES;
    currentBtn = sender;
    switch (sender.tag) {
        case 300:
        {
            
        }
            break;
        case 301:
        {
            
        }
            break;
        case 302:
        {
            
        }
            break;
        case 303:
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
        return 1;
    else
        return _homeModel.goodsArray.count/2;//下载数据
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.section == 0) {
        HomeShopCell * cell = [[HomeShopCell alloc]init];

        cell.homeModel=_homeModel;
        cell.meter=self.meter;
        [cell setDaoHangBlock:^(HomeModel * hhMo) {
 
            
            RoutePlanViewController *dvc=[[RoutePlanViewController alloc]initWithModel:hhMo];

            [self.navigationController pushViewController:dvc animated:YES];
        }];

        [cell setindexPath:indexPath];
        
        [cell setEnterDetailBlock:^{
        }];
        return cell;
    }
    
    else{
        HomeShopCell * cell = [HomeShopCell cellWithTableViewCell:tableView];
        cell.model1=_homeModel.goodsArray[indexPath.row*2];
        cell.model2=_homeModel.goodsArray[indexPath.row*2+1];
        [cell setindexPath:indexPath];
        
        return cell;
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return 30;
    }
    else {
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 30)];
        view2.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:view2];
        
        NSArray * listArr = @[@"全部分类",@"销量排行",@"人气排行",@"评价最高"];
        
        for (int i = 0; i<4; i++) {
            UIButton * btn = [UIButton new];
            btn.frame = CGRectMake(self.view.width/4*i, 0, self.view.width/4, view2.height);
            [btn setTitle:listArr[i] forState:0];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setBackgroundImage:[UIImage imageNamed:@"paihangbeijing2"] forState:0];
            [btn setBackgroundImage:[UIImage imageNamed:@"wodedianpuxiala"] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor whiteColor] forState:0];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            btn.tag = 300+i;
            [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
            [view2 addSubview:btn];
            
        }
        currentBtn = (UIButton *)[view2 viewWithTag:300];
        currentBtn.selected = YES;
        
        return view2;
        
    }
    else{
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 160;
    }
    else{
        return 240;
    }
}


-(void)viewWillDisappear:(BOOL)animated
{
    
    OLWTabBarController *tabbarcontroller=(OLWTabBarController *)self.tabBarController;
    tabbarcontroller.zqTabBar.hidden=YES;
    
}


@end
