//
//  WDDPViewController.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/23.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "WDDPViewController.h"
#import "OLWTabBarController.h"
#import "StarView.h"
#import "MyShopCell.h"
#import "HotDetailsViewController.h"
#import "ManageSController.h"
#import "ShopDetailController.h"
#import "WDDPModel.h"
#import "MJExtension.h"
#import "WDDPGoodsModel.h"
#import "CuXiaoViewController.h"
#import "NewGoodsVC.h"
#import "CyclePics.h"
#import "HeaderView.h"

@interface WDDPViewController ()<UITableViewDelegate,UITableViewDataSource,headerDelegate>
{

    UITableView * tableView;

}
@property(nonatomic,weak)UIButton * currentBtn;
@property(nonatomic,strong)WDDPModel *wddpModel;
@property(nonatomic,strong)WDDPGoodsModel *wddpGoodsModel;
@property(nonatomic,strong)NSMutableArray * indexArr;
@property(nonatomic,weak)NSMutableArray * currentModels;
@property(nonatomic,strong)NSMutableArray * allModels;
@end

@implementation WDDPViewController

#pragma mark -懒加载
-(NSMutableArray *)allModels
{
    if (_allModels == nil) {
        _allModels = [NSMutableArray array];
        
    }
    return _allModels;
}
-(NSMutableArray *)indexArr
{
    if (_indexArr == nil) {
        _indexArr = [NSMutableArray array];
        
    }
    return _indexArr;
}

-(void  )viewWillAppear:(BOOL)animated
{
    ( (OLWTabBarController *)self.tabBarController).zqTabBar.hidden = YES;
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)loadView
{
    [super loadView];
    
}

-(void)requestDataWithClassify:(NSString * )className andindex:(int)index
{

//    for (NSString  * str in self.indexArr) {
//        if ([str isEqual:[NSString stringWithFormat:@"%d",index]]) {
////            self.currentModels = self.allModels[index];
//            NSLog(@"%d",index);
//            [tableView reloadData];
//            return;
//        }
//    }
//    [self.indexArr addObject:[NSString stringWithFormat:@"%d",index]];
    
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //    获得参数
    NSString * userid  =[MyAccountTool account].userid;
    NSString * gcryid  =@"1";
    NSString * pageSize  = @"10";
    NSString * page  =@"1";
    NSString * where  =className;
    
    
    NSString * key =[NewMD5 md5:[NSString stringWithFormat:@"%@%@%@%@%@%@",userid,gcryid,pageSize,page,where,DefaultKey]] ;
    NSDictionary * parames = @{@"action":@"personshop",@"userid":userid,@"gcryid":gcryid,@"pageSize":pageSize,@"page":page,@"where":where,@"key":key};
    // 2.发送POST请求
    [MBProgressHUD showMessage:@"正在请求"];
    [mgr POST:PERSONCENTER_URL parameters:parames
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          [MBProgressHUD hideHUD];
          NSString * code = [responseObj objectForKey:@"code"];
          NSLog(@"respone  = %@",responseObj);
          if ([code isEqualToString:@"0"]) {
              NSDictionary * list = [responseObj objectForKey:@"list"];
              self.wddpModel = [WDDPModel objectWithKeyValues:list];
              NSMutableArray * goodsModels = [NSMutableArray array];
              for (int i = 0; i<self.wddpModel.store_goods.count; i++) {
                  self.wddpGoodsModel = [WDDPGoodsModel objectWithKeyValues:self.wddpModel.store_goods[i]];
                  [goodsModels addObject:self.wddpGoodsModel];
              }

              [self.allModels addObject:goodsModels];
              self.currentModels = goodsModels;

              [tableView reloadData];
          }
          
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"fail");
          [MBProgressHUD hideHUD];
          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请求数据失败"
                                                          message:@"请检查网络"
                                                         delegate:nil
                                                cancelButtonTitle:@"YES" otherButtonTitles:nil];
          [alert show];

      }];
 
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    identity =0;
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(fabu)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.title = @"我的店铺";
    self.view.backgroundColor = ZQColor(214, 214, 214);
    
    [self creatTableView];
    [self creatFootView];
    
}

-(void)fabu
{
    [self.navigationController pushViewController:[NewGoodsVC new] animated:YES];
}
#pragma -mark 创建tableView
-(void)creatTableView
{
    //
    tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];

    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator= NO;
    [self.view addSubview:tableView];

}
-(void)creatFootView
{
    UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.height-50, self.view.width, 50)];
    [self.view addSubview:footView];
     NSArray * imgArr = @[@"dianpucuxiaotuiguang",@"dianpuguanli"];
    for (int i = 0; i<2; i++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.width/2*i, 0, self.view.width/2, 50)];
        [btn setImage:[UIImage imageNamed:imgArr[i]] forState:0];
        btn.tag = i+500;
        [btn addTarget:self action:@selector(footBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
        
        [footView addSubview:btn];
    }
    
}
#pragma mark -底部按钮事件
-(void)footBtnSelect:(UIButton *)sender
{
    switch (sender.tag) {
        case 500:
        {
            [self.navigationController pushViewController:[CuXiaoViewController new] animated:YES];
            
        }
            break;
        case 501:
        {
             [self.navigationController pushViewController:[ManageSController new] animated:YES];
        }
            break;
            
        default:
            break;
    }
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
        {
            if (self.currentModels.count%2==0) {
                return self.currentModels.count/2;
            }
            else{
//                NSLog(@"%d",self.goodsModels.count);
              return self.currentModels.count/2+1;
            }
    
        }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        MyShopCell * cell = [[MyShopCell alloc]init];
        [cell setindexPath:indexPath];
          cell.wddpModel = self.wddpModel;
       [cell setEnterDetailBlock:^{
           [self.navigationController pushViewController:[ShopDetailController new] animated:YES];
       }];
        
        return cell;
    }
         
    else{
        MyShopCell * cell = [MyShopCell cellWithTableViewCell:tableView];
        [cell setindexPath:indexPath];
        if (self.currentModels.count%2==0) {
            cell.goodsModel1 = self.currentModels[indexPath.row*2];
           
            cell.goodsModel2 = self.currentModels[indexPath.row*2+1];
           
        }
        else{
            if (self.currentModels.count==indexPath.row*2+1) {
                cell.goodsModel1 = self.currentModels[indexPath.row*2];
            }
            else
            {
                cell.goodsModel1 = self.currentModels[indexPath.row*2];
                
              cell.goodsModel2 = self.currentModels[indexPath.row*2+1];
 
            }
            
        }
        
        [cell setImageBlock:^{
            
            [self.navigationController  pushViewController:[HotDetailsViewController new] animated:YES];
        }];
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
       
        HeaderView *view = [HeaderView sharedManagerWithFrame:CGRectMake(0, 0, self.view.width, 30)];
        view.delegate = self;
        if (identity ==0) {
             [view.delegate btnSelect:view andBtn:view.btn];
            identity++;
        }

       

        return view;

    }
    else{
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 200;
    }
    else{
        return 240;
    }
}
-(void)btnSelect:(HeaderView *)headerView andBtn:(UIButton *)senderBtn
{
    switch (senderBtn.tag) {
        case 300:
        {
            [self requestDataWithClassify:@"" andindex:0];
        }
            break;
        case 301:
        {
            [self requestDataWithClassify:@"sales" andindex:1];
        }
            break;
        case 302:
        {
            [self requestDataWithClassify:@"click" andindex:2];
        }
            break;
        case 303:
        {
            [self requestDataWithClassify:@"view" andindex:3];
        }
            break;
            
        default:
            break;
    }

}



@end
