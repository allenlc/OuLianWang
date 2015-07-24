//
//  GWCViewController.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/23.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "GWCViewController.h"
#import "ShopCell.h"
#import "ShopCardGroup.h"
#import "ShopCartItem.h"
#import "OLWTabBarController.h"
@interface GWCViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * tableView;
    UILabel * numbelLabel ;
    UILabel * accountLabel;
    
}

/**
 *  用模型来描述每一组的信息和每一行的信息
 */

@property(nonatomic,strong)NSMutableArray * groups;



@end

@implementation GWCViewController

#pragma 设置导航栏
-(void)setNavigationTitle
{
    self.navigationItem.title = @"购物车";
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"清空" style:UIBarButtonItemStyleDone target:self action:@selector(deleteAll)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

-(void)deleteAll
{
    
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    OLWTabBarController * tabBarVC =(OLWTabBarController *) self.tabBarController;
    tabBarVC.zqTabBar.hidden = YES;

}
-(void)viewWillDisappear:(BOOL)animated
{
    OLWTabBarController * tabBarVC =(OLWTabBarController *) self.tabBarController;
    tabBarVC.zqTabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    self.view.backgroundColor = ZQColor(230, 230, 231);
    [self setNavigationTitle];
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, self.view.width, self.view.height+10) style:UITableViewStyleGrouped];
       tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.separatorStyle = 0;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
//    [self setupGroups];
    [self createBotView];
    
}

-(void)requestData{
    
        // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //    获得参数
    NSString * userid  =@"9";
    NSString * pageSize = @"10";
    NSString * page = @"1";
    //    获得参数
    MyAccount * Account = [MyAccountTool account];
    
    if (Account) {
//        userid =  Account.userid;
    }
    else {
        
    }
    
    NSString * key =[NewMD5 md5:[NSString stringWithFormat:@"%@%@%@%@",userid,pageSize,page,@"esaafafasfafafsaff"]] ;
    NSDictionary * parames = @{@"action":@"showshopcar",@"userid":userid,@"pageSize":pageSize,@"page":page,@"key":key};
    // 2.发送POST请求
    NSLog(@"parames = %@",parames);
    [MBProgressHUD showMessage:@"正在请求"];
    
    [mgr POST:PERSONCENTER_URL parameters:parames
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          [MBProgressHUD hideHUD];
          NSString * code = [responseObj objectForKey:@"code"];
          if ([code isEqualToString:@"0"]) {
              NSArray * list = [responseObj objectForKey:@"list"];
           NSLog(@"respone = %@",list);
              for (int i = 0; i<list.count; i++) {
                  ShopCardGroup * group = [ShopCardGroup objectWithKeyValues:list[i]];
                  
                  NSArray * arr = group.goods;
                   NSMutableArray * arr1 = [NSMutableArray array];
                  for (int j = 0; j<arr.count; j++) {
                      ShopCartItem *item = [ShopCartItem objectWithKeyValues:arr[j]];
                      [arr1 addObject:item];
                  }
                   group.items = arr1;
                  [self.groups addObject:group];
              }
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

#pragma mark -懒加载
-(NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
        
    }
    return _groups;
}


-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.groups.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ShopCardGroup * group = self.groups[section];
    return group.items.count;
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShopCell * cell = [ShopCell cellWithTableViewCell:tableView];
    ShopCardGroup * goupe = self.groups[indexPath.section];
    ShopCartItem * item = goupe.items[indexPath.row];
    cell.item = item;
    [cell setindexPath:indexPath rowInSecton:goupe.items.count];
    
    [cell setAccountBlock:^(UIButton *btn) {//选择单个计算
        
        float currentAccount = [[accountLabel.text substringFromIndex:1] floatValue];
        NSString * a  = [numbelLabel.text substringFromIndex:1];
        NSString * b = [a substringToIndex:a.length-1];
        int currentX = [b intValue];
        
        NSString * a1  = cell.numberLabel.text;
        
        int X = [a1 intValue];
        float account = [[cell.accountLabel.text substringFromIndex:1] floatValue]*X;

        if (btn.selected == YES) {
            currentAccount +=account;
            currentX +=X;
           
            
        }
        else{
            currentAccount -=account;
            currentX -=X;
        }
        accountLabel.text = [NSString stringWithFormat:@"￥%.2f",currentAccount];
        numbelLabel.text = [NSString stringWithFormat:@"共%d件",currentX];


    }];
    
    [cell setEditBlock:^(int tag) {//编辑数量
        
        [self editCardDataWithTag:tag andaCell:cell];
        
        

    }];
    [cell setRemoveBlock:^(ShopCell *aCell) {//删除计算
        
        
       NSIndexPath * aIndexPath = [tableView indexPathForCell:aCell];
      BOOL isDelete =  [self removeCardDataWithIndexPath:aIndexPath andaCell:aCell];//删除接口请求
        
    }];
    
    
   
    return cell;
}
#pragma mark -请求删除数据
-(BOOL)removeCardDataWithIndexPath:(NSIndexPath *)aIndexPath andaCell:(ShopCell *)aCell
{
    
    ShopCardGroup * agroup = self.groups[aIndexPath.section];
    
    ShopCartItem * item  = agroup.items[aIndexPath.row];
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //    获得参数
    NSString * action = @"delshopcar";
    NSString *Carids =item.carid;
    //    获得参数
    
    NSString * key =[NewMD5 md5:[NSString stringWithFormat:@"%@%@",item.carid,DefaultKey]] ;
    NSDictionary * parames = @{@"action":action,@"carids":Carids,@"key":key};
    // 2.发送POST请求
    NSLog(@"parames = %@",parames);
    [MBProgressHUD showMessage:@"正在删除"];
    
    __block BOOL isDelete;
    [mgr POST:PERSONCENTER_URL parameters:parames
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          
          NSString * code = [responseObj objectForKey:@"code"];
          NSString * message = [responseObj objectForKey:@"message"];
          [MBProgressHUD hideHUD];
          
          [MBProgressHUD showError:message];
          
          NSLog(@"responseObj = %@",responseObj);
          if ([code isEqualToString:@"0"]) {
              isDelete =YES;
              
              //去除当前的计算
              float currentAccount = [[accountLabel.text substringFromIndex:1] floatValue];
              NSString * a  = [numbelLabel.text substringFromIndex:1];
              NSString * b = [a substringToIndex:a.length-1];
              int currentX = [b intValue];
              
              if (agroup.items.count==1) {
                  [self.groups removeObjectAtIndex:aIndexPath.section];
                  [tableView reloadData];
                  return ;
              }
              [agroup.items removeObjectAtIndex:aIndexPath.row];
              [tableView reloadData];
              if (aCell.selectBtn.selected == YES) {
                  NSString * str1 = aCell.numberLabel.text;
                  NSString * str = aCell.accountLabel.text;
                  currentAccount -=[str floatValue]*[str1 intValue];
                  currentX -=[str1 intValue];
              }
              
              
          }
          
          
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"fail");
          [MBProgressHUD hideHUD];
          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请求数据失败"
                                                          message:@"请检查网络"
                                                         delegate:nil
                                                cancelButtonTitle:@"YES" otherButtonTitles:nil];
          [alert show];
          isDelete=NO;
      }];
    return isDelete;
    
}

#pragma mark -请求编辑数量
-(void)editCardDataWithTag:(int)tag andaCell:(ShopCell *)aCell
{
    

    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    int x = [aCell.numberLabel.text intValue];
    if (tag == 300) {
        x--;
    }
    else{
        x++;
    }
    NSString * number = [NSString stringWithFormat:@"%d",x];
    //    获得参数
    NSString * action = @"editshopcar";
    NSArray * cararr = @[@{@"carid":aCell.item.carid,@"number":number}];
    NSLog(@"%@",cararr);
    //    获得参数

    NSString * key =[NewMD5 md5:[NSString stringWithFormat:@"%@%@%@",aCell.item.carid,number,DefaultKey]] ;
    NSDictionary * parames = @{@"action":action,@"carid":aCell.item.carid,@"number":number,@"key":key};
    // 2.发送POST请求
    NSLog(@"parames = %@",parames);
    [MBProgressHUD showHUDAddedTo:tableView animated:YES];
    
    [mgr POST:PERSONCENTER_URL parameters:parames
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          NSLog(@"%@",responseObj);
          NSString * code = [responseObj objectForKey:@"code"];
          NSString * message = [responseObj objectForKey:@"message"];
          [MBProgressHUD hideAllHUDsForView:tableView animated:YES];
          [MBProgressHUD showError:message];
          
          NSLog(@"responseObj = %@",responseObj);
          if ([code isEqualToString:@"0"]) {
              if (aCell.selectBtn.selected ==NO) {
                  return ;
              }
              
              float currentAccount = [[accountLabel.text substringFromIndex:1] floatValue];
              NSString * a  = [numbelLabel.text substringFromIndex:1];
              NSString * b = [a substringToIndex:a.length-1];
              int currentX = [b intValue];
              float account = [[aCell.accountLabel.text substringFromIndex:1] floatValue];
              switch (tag) {
                  case 300:
                  {
                      currentAccount -=account;
                      currentX -=1;
                  }
                      break;
                  case 301:
                  {
                      currentAccount +=account;
                      currentX +=1;
                  }
                      break;
                  default:
                      break;
              }
              
              accountLabel.text = [NSString stringWithFormat:@"￥%.2f",currentAccount];
              numbelLabel.text = [NSString stringWithFormat:@"共%d件",currentX];
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}
#pragma -mark 设置标题头的view
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =  CGRectMake(7.5, 5, 20, 20);
    btn.tag = section+400;
    [btn addTarget:self action:@selector(selectAllCell:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"noselect_gwc"] forState:0];
    [btn setImage:[UIImage imageNamed:@"select_gwc"] forState:UIControlStateSelected];
    [view addSubview:btn];
    self.selectAllBtn = btn;
    
    UIImageView * icon = [[UIImageView alloc]initWithFrame:CGRectMake(35, 5, 20, 20)];
    icon.image = [UIImage imageNamed:@"shop_gwc"];
       [view addSubview:icon];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(65, 0, 320-70, 28)];
    [view addSubview:label];
      ShopCardGroup * goupe = self.groups[section];
        label.text =goupe.storename;
    
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 29, self.view.width, 1)];
    imgView.backgroundColor = ZQColor(214, 214, 214);
    [view addSubview:imgView];
    
    self.selectAllBtn.selected = goupe.isSelect;
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 10)];
    view.backgroundColor =  ZQColor(230, 230, 231);
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//分组选择方法
-(void)selectAllCell:(UIButton *)sender
{
    ShopCardGroup * goupe = self.groups[sender.tag-400];
    float account = 0;
    int x =0;
    float currentAccount = [[accountLabel.text substringFromIndex:1] floatValue];
    NSString * a  = [numbelLabel.text substringFromIndex:1];
    NSString * b = [a substringToIndex:a.length-1];
    int currentX = [b intValue];

    if (sender.selected ==NO) {
        sender.selected = YES;
        self.selectAllBtn = sender;
        
        for (int row=0; row<goupe.items.count; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:sender.tag-400];
            ShopCell * cell =  (ShopCell *) [tableView cellForRowAtIndexPath:indexPath];
            ShopCartItem *item = goupe.items[row];
            if (item.isSelect == NO) {//判断选择
                
                NSString * str1 = item.number;
                x+=[str1 intValue];
                
                NSString * str = item.price;
                account +=[str floatValue]*[str1 intValue];
            }
            cell.selectBtn.selected = sender.selected;
            item.isSelect = sender.selected;
            
        }
        currentAccount +=account;
        currentX +=x;
        
        }
    else{//不选择
        sender.selected = NO;
        account =0;
        x=0;
        for (int row=0; row<goupe.items.count; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:sender.tag-400];
            ShopCell * cell =  (ShopCell *) [tableView cellForRowAtIndexPath:indexPath];
             ShopCartItem *item = goupe.items[row];
            if (item.isSelect == YES) {
               
                NSString * str1 = item.number ;
                x+=[str1 intValue];
                NSString * str = item.price ;
                NSLog(@"%@",item.price);
                account +=([str floatValue]*[str1 intValue]);

            }
            item.isSelect = sender.selected;
                           cell.selectBtn.selected = sender.selected;
                
            }

        currentAccount -=account;
        currentX -=x;


    }
    goupe.isSelect = self.selectAllBtn.selected ;
    accountLabel.text = [NSString stringWithFormat:@"￥%.2f",currentAccount];
    numbelLabel.text = [NSString stringWithFormat:@"共%d件",currentX];


    
    
}
//创建底部视图
-(void)createBotView
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.height-40, self.view.width, 40)];
    view.backgroundColor = ZQColor(219, 216, 218);
    [self.view addSubview:view];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =  CGRectMake(7.5, 10, 20, 20);
    btn.tag = 555;
    [btn addTarget:self action:@selector(selectAllCell1:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"noselect_gwc"] forState:0];
    [btn setImage:[UIImage imageNamed:@"select_gwc"] forState:UIControlStateSelected];
    [view addSubview:btn];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame)+3, 10, 40, 20)];
    label.text = @"全选";
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor blackColor];
    [view addSubview:label];
    
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 50, 20)];
    label1.font = [UIFont systemFontOfSize:12];
    label1.textColor = [UIColor blackColor];
    [view addSubview:label1];
    numbelLabel = label1;
    label1.text = @"共0件";
    
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 30, 20)];
    label2.text = @"合计:";
    label2.font = [UIFont systemFontOfSize:12];
    label2.textColor = [UIColor blackColor];
    [view addSubview:label2];
    
    accountLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 10, 70, 20)];
    accountLabel.font = [UIFont systemFontOfSize:12];
    accountLabel.textColor = [UIColor redColor];
    accountLabel.text = @"￥0.00";
    [view addSubview:accountLabel];
    //     label2.backgroundColor = ZQRandomColor;
    
    
    UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.width-120, 10, 60, 20)];
    label3.text = @"不包含运费";
    label3.font = [UIFont systemFontOfSize:12];
    label3.textColor = [UIColor blackColor];
    [view addSubview:label3];
//     label3.backgroundColor = ZQRandomColor;
    
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame =  CGRectMake(self.view.width-60, 0, 60, 40);
    btn1.layer.cornerRadius = 5;
    [btn1 setTitle:@"结算" forState:0];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(accountAll) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn1];

    

}
-(void)accountAll
{
    
}

//底部全选
-(void)selectAllCell1:(UIButton *)btn
{
    
    
    if (btn.selected ==NO) {
        btn.selected = YES;
    }
        else{
            btn.selected = NO;
            
        }
    static float account = 0;
    static int x=0;
        for (int i = 0; i<self.groups.count; i++) {
            ShopCardGroup * goupe = self.groups[i];
            for (int row=0; row<goupe.items.count; row++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:i];
                ShopCell * cell =  (ShopCell *) [tableView cellForRowAtIndexPath:indexPath];
                cell.selectBtn.selected = btn.selected;

                ShopCartItem *item = goupe.items[row];
                item.isSelect = btn.selected;

                NSString * str1 = item.number;
                x+=[str1 intValue];
                NSString * str = item.price ;
                account +=[str floatValue]*[str1 intValue];
            }
           
            UIButton * btn1 = (UIButton * )[self.view viewWithTag:i+400];

            btn1.selected = btn.selected;
            goupe.isSelect = btn.selected;
            
        }
    if (btn.selected==YES) {
        accountLabel.text = [NSString stringWithFormat:@"￥%.2f",account];
        numbelLabel.text = [NSString stringWithFormat:@"共%d件",x];
        
    }
    else{
        x=0;
        account =0.00;
        accountLabel.text = [NSString stringWithFormat:@"￥%.2f",account];
         numbelLabel.text = [NSString stringWithFormat:@"共%d件",x];
    }
    

        
}


    
    

@end
