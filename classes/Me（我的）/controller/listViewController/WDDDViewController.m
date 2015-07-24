//
//  WDDDViewController.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/23.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "WDDDViewController.h"
#import "MyIndentGroup.h"
#import "MyIndentItem.h"
#import "MyIndentViewCell.h"
#import "OLWTabBarController.h"
#import "ShopTableViewCell.h"
#import "DDxqViewController.h"
#import "UILabel+StringFrame.h"

@interface WDDDViewController ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  用模型来描述每一组的信息和每一行的信息
 */

{
    UIButton * btn1;
    UIButton * btn2;
    UITableView * _tableView ;
    UIView * titleView ;
    UIButton * currentBtn;
    UITableView * tableView;
    

}
@property(nonatomic,strong)NSMutableArray * groups;


@property(nonatomic,strong)NSMutableArray * groups2;

@end

@implementation WDDDViewController
#pragma -隐藏tabbar
-(void)viewWillAppear:(BOOL)animated
{
    OLWTabBarController * tabBarVC =(OLWTabBarController *) self.tabBarController;
    tabBarVC.zqTabBar.hidden = YES;
    
}
#pragma 设置导航栏
-(void)setNavigationTitle
{
    UIButton *fabubutton1=[UIButton buttonWithType:UIButtonTypeCustom];
    [fabubutton1  setImage:[UIImage imageNamed:@"kuaidisaoyisao.png"] forState:UIControlStateNormal];
    [fabubutton1 addTarget:self action:@selector(getMessage) forControlEvents:UIControlEventTouchUpInside];
    fabubutton1.frame=CGRectMake(0, 0, 25, 25);
    UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc]initWithCustomView:fabubutton1];
    self.navigationItem.rightBarButtonItem=rightBtn;
    
    titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width/2, 30)];
    titleView.layer.cornerRadius = 2;
    titleView.backgroundColor = [UIColor whiteColor];
    
    btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.titleLabel.font = [UIFont boldSystemFontOfSize:14 ];
    btn1.selected = YES;
    btn1.frame = CGRectMake(2, 2, titleView.width/2-2, titleView.height-4);
    [btn1 setTitle:@"我的订单" forState:0];
    [btn1 setTitleColor:[UIColor whiteColor] forState:0];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [btn1 addTarget:self action:@selector(myIndent) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:btn1];
    
    
    btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.titleLabel.font = [UIFont boldSystemFontOfSize:14 ];
    btn2.selected = NO;
    btn2.backgroundColor = [UIColor redColor];
    btn2.frame = CGRectMake(titleView.width/2, 2, titleView.width/2-2, titleView.height-4);
    [btn2 setTitle:@"商铺订单" forState:0];
    [btn2 setTitleColor:[UIColor whiteColor] forState:0];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [btn2 addTarget:self action:@selector(shopIndent) forControlEvents:UIControlEventTouchUpInside];

    [titleView addSubview:btn2];
    
    btn1.titleLabel.font = [UIFont boldSystemFontOfSize:16];
     btn2.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    
    self.navigationItem.titleView = titleView;
}

#pragma -mark- 请求网络数据
-(void)requestDataWithRolesid:(NSString *)rolesid
{
   
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //    获得参数
    NSString * idvalue  =@"9";
    if ([rolesid isEqualToString:@"2"]) {
        idvalue = @"1";
    }
    NSString * pageSize  = @"2";
    NSString * page  =@"1";
    NSString * osid  =@"";
    
    
    NSString * key =[NewMD5 md5:[NSString stringWithFormat:@"%@%@%@%@%@%@",idvalue,rolesid,pageSize,page,osid,@"esaafafasfafafsaff"]] ;
    NSDictionary * parames = @{@"action":@"getorderlist",@"idvalue":idvalue,@"rolesid":rolesid,@"pageSize":pageSize,@"page":page,@"osid":osid,@"key":key};
//    NSLog(@"parames=%@",parames);
//    NSLog(@"key=%@",key);
    
    
    // 2.发送POST请求
    [mgr POST:PERSONCENTER_URL parameters:parames
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          NSString * code = [responseObj objectForKey:@"code"];
                   NSLog(@"respone  = %@",responseObj);
          if ([code isEqualToString:@"0"]) {
              NSArray * list = [responseObj objectForKey:@"list"];
               [self.groups removeAllObjects];
              for (int i = 0; i<list.count; i++) {
                  MyIndentGroup * group =[MyIndentGroup objectWithKeyValues:list[i]];
//                  NSLog(@"%@",group.goods[0]);
                  NSMutableArray * items = [NSMutableArray array];
                  for (int j = 0; j<group.goods.count; j++) {
                      MyIndentItem *item =[MyIndentItem objectWithKeyValues:group.goods[j]];
                      [items addObject:item];
                      
                  }
                  group.items = items;
                  
                  [self.groups addObject:group];
                  
              }
              NSLog(@"self.group.count = %d",self.groups.count);
              
              NSLog(@"btn select%d",btn1.selected);
              [_tableView reloadData];
          }
          
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"fail");
      }];
}
-(void)viewWillDisappear:(BOOL)animated
{
    OLWTabBarController * tabBarVC =(OLWTabBarController *) self.tabBarController;
    tabBarVC.zqTabBar.hidden = NO;
}
-(void)getMessage
{
    
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)myIndent
{
    btn1.selected=YES;
    btn2.selected=NO;
    btn2.backgroundColor = [UIColor redColor];
    btn1.backgroundColor=[UIColor whiteColor];
    [self requestDataWithRolesid:@"1"];
    
    
}
-(void)shopIndent
{
    btn1.selected=NO;
    btn2.selected=YES;
    btn2.backgroundColor = [UIColor whiteColor];
    btn1.backgroundColor=[UIColor redColor];
  
    
    [self requestDataWithRolesid:@"2"];
    
     NSLog(@"商铺订单");
    
}
-(void)loadView
{
    [super loadView];
    self.view.backgroundColor = ZQColor(230, 230, 230);
    [self setNavigationTitle];
    [self creatTopView];
    [self creatTableView];
    
     [self requestDataWithRolesid:@"1"];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(void)creatTopView
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, 40)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    NSArray * arrName = @[@"全部",@"待付款",@"待发货",@"待收货",@"待评价",@"已关闭"];
    
    for (int i = 0; i<6; i++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(view.width/6*i, 0, self.view.width/6, view.height)];
        [btn setBackgroundImage:[UIImage imageNamed:@"nav-sel"] forState:UIControlStateSelected];
        [btn setTitle:arrName[i] forState:0];
        [btn setTitleColor:ZQColor(201, 0, 9) forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn addTarget:self action:@selector(selectListView:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        btn.tag = i+100;
        
    }
    currentBtn = (UIButton *)[view viewWithTag:100];
    currentBtn.selected = YES;
    
}

#pragma mark -懒加载
-(NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
        
    }
    return _groups;
    
    
    
}

-(NSMutableArray *)groups2
{
    if (_groups2 == nil) {
        _groups2 = [NSMutableArray array];
        
    }
    return _groups2;
}




-(void)setupGroups
{
    

    
//    [self setupGroup0];
//    [self setupGroup1];
    


}



-(void)setupGroup0
{
    //1 创建组
    MyIndentGroup * group = [MyIndentGroup group];
    
    //2 设置每组的数据
    group.storename = @"顾家家居官方旗舰店";
   
    MyIndentItem * hotStatus = [MyIndentItem itemWithTitle:@"热门微博" icon:@"hot_status"];
    MyIndentItem * find_people = [MyIndentItem itemWithTitle:@"找人" icon:@"find_people"];
    group.items = @[hotStatus,find_people];
    [self.groups addObject:group];
    
}
-(void)setupGroup1
{
    //1 创建组
    MyIndentGroup * group = [MyIndentGroup group];
    
    //2 设置每组的数据
    group.storename = @"韩都衣舍旗舰店";
   
    MyIndentItem * run2015 = [MyIndentItem itemWithTitle:@"" icon:@""];
    MyIndentItem * gamecenter = [MyIndentItem itemWithTitle:@"" icon:@"game_center"];
    MyIndentItem * near = [MyIndentItem itemWithTitle:@"" icon:@""];
    MyIndentItem * city = [MyIndentItem itemWithTitle:@"" icon:@""];
    group.items = @[run2015,gamecenter,near,city];
    [self.groups addObject:group];
    
}



-(void)selectListView:(UIButton *)sender
{
    currentBtn.selected = NO;
    currentBtn = sender;
    currentBtn.selected = YES;
}
-(void)creatTableView
{
    //
    _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+40, self.view.width, self.view.height-104) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = 0;
    _tableView.tag = 200;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}





-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (btn1.selected == YES) {
        NSLog(@"%d",self.groups.count);
        return  self.groups.count;
    }
    else{
        return 1;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (btn1.selected == YES) {
        MyIndentGroup * group = self.groups[section];
        return group.items.count;
    }
    else {
        return 3;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (btn1.selected == YES) {
        return 40;
    }
    else{
        return 0.001f;
    }

    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (btn1.selected ==YES) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
        view.backgroundColor = [UIColor whiteColor];
        
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 10)];
        imgView.backgroundColor = ZQColor(230, 230, 230);
        [view addSubview:imgView];
        
        UIImageView * imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 20, 20)];
        imgView1.image = [UIImage imageNamed:@"shangbiao_"];
        [view addSubview:imgView1];
        
        
        UILabel * lable = [[UILabel alloc ]initWithFrame:CGRectMake(40, 10, self.view.width, 30)];
        lable.font = [UIFont systemFontOfSize:16];
        MyIndentGroup * goupe = self.groups[section];
        [view addSubview:lable];
        lable.text =goupe.storename;
        CGSize nameSize =[goupe.storename sizeWithFont:[UIFont systemFontOfSize:16]];
        lable.width =nameSize.width;
        lable.text = goupe.storename;
        
        UIImageView * imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lable.frame)+5, 20, 10, 10)];
        imgView2.image = [UIImage imageNamed:@"jiant"];
        [view addSubview:imgView2];
        
        UIImageView * imgView3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 39, self.view.width, 1)];
        imgView3.backgroundColor = ZQColor(214, 214, 214);
        [view addSubview:imgView3];

       
        return view;
    }
    
    return nil;
    

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (btn1.selected==YES)
    {
        MyIndentViewCell * cell = [MyIndentViewCell cellWithTableViewCell:tableView];
        MyIndentGroup * goupe = self.groups[indexPath.section];
        MyIndentItem * item = goupe.items[indexPath.row];
        cell.item = item;
        [cell setindexPath:indexPath rowInSecton:goupe.items.count];
        return cell;

    }
    else 
        
    {
        ShopTableViewCell * cell1 = [ShopTableViewCell cellWithTableViewCell:tableView];
        [cell1 setindexPath:indexPath rowInSecton:indexPath.section];
        return cell1;
    }
    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d",btn1.selected);
    if (btn1.selected==YES) {
        return 130  ;
    }
    else {
    return 140;
}
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    DDxqViewController * ydcontroller=[[DDxqViewController alloc]init];
    [self.navigationController  pushViewController:ydcontroller animated:YES];
    
}



@end
