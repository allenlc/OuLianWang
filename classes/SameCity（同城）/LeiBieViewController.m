//
//  LeiBieViewController.m
//  OuLianWang
//
//  Created by hsmj on 15/6/19.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "LeiBieViewController.h"
#import "LeiBieTableViewCell.h"
#import "HotDetailsViewController.h"
#import "AFNetworking.h"
#import "LeiBModel.h"
#import "UIImageView+AFNetworking.h"
#import "JuHeCityModel.h"
#import "MyButton.h"
#import "NewCityViewController.h"
#import "OLWTabBarController.h"

@interface LeiBieViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    UISearchBar * _searchbar;
    UITableView *_tableview;
    NSMutableArray *_titleArray;
    NSMutableArray *_remenArray;
    UIScrollView *scroller;
    
}
@end

@implementation LeiBieViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self  deplyNavigationController];
    
  //[self  creattableview];
    [self  loaddatasource];
    
}

#pragma mark-------配置导航栏

-(void)deplyNavigationController
{
    _searchbar=[[UISearchBar alloc]initWithFrame:CGRectMake(45,3,220, 40)];
    _searchbar.placeholder=@"搜索商铺,商店...";
    _searchbar.delegate=self;
    _searchbar.barStyle=UIBarStyleDefault;
    self.navigationItem.titleView= _searchbar;

    UIButton *diqubutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [diqubutton  setImage:[UIImage imageNamed:@"返回箭头.png"] forState:UIControlStateNormal];
    [diqubutton  addTarget:self action:@selector(diquButtonClick) forControlEvents:UIControlEventTouchUpInside];
    diqubutton.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    diqubutton.frame=CGRectMake(0, 0,20,20);
    UIBarButtonItem *leftbutton=[[UIBarButtonItem alloc]initWithCustomView:diqubutton];


    JuHeCityModel *currentModel = [JuHeCityModel currentCity];
    UIView *leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    leftView.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cityClick)];
        [leftView addGestureRecognizer:tap];
        UILabel * _reginLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,50, 30)];
        _reginLabel.font=[UIFont boldSystemFontOfSize:18];
        _reginLabel.textColor=[UIColor whiteColor];
        _reginLabel.text=currentModel.city_name;
        [leftView addSubview:_reginLabel];
        UIImageView * _reginImageView=[[UIImageView alloc]initWithFrame:CGRectMake(_reginLabel.text.length*20, 15, 15, 5)];
        _reginImageView.image=[UIImage imageNamed:@"ZX下拉.png"];
        [leftView addSubview:_reginImageView];
        //
        UIBarButtonItem  *_leftButton=[[MyBarButton alloc]initWithCustomView:leftView];

    // 调整 leftBarButtonItem 在 iOS7 下面的位置
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0))
    {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                       target:nil action:nil];
        negativeSpacer.width = -10;//这个数值可以根据情况自由变化
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftbutton];
        self.navigationItem.rightBarButtonItem= _leftButton;
    }
    else
    {
        self.navigationItem.leftBarButtonItem = leftbutton;
        self.navigationItem.rightBarButtonItem = _leftButton;
    }
}

-(void)cityClick
{
    //    CityListController *cityListVC = [[CityListController alloc] init];
    //    [self.navigationController pushViewController:cityListVC animated:YES];
    NewCityViewController *vc=[[NewCityViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)diquButtonClick
{
    [self.navigationController  popViewControllerAnimated:YES];
    
}


-(void)loaddatasource
{
    
    _titleArray=[[NSMutableArray alloc]init];
    _remenArray=[[NSMutableArray alloc]init];
    
    
    
    NSString *urlString = LEIBIE_URL;
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer  serializer];
    [manager  GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
    NSDictionary *dict=[NSJSONSerialization  JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dict);
        NSArray  *titlearray=[dict  objectForKey:@"nav"];
       // NSLog(@"%@",titlearray);
        
        for (NSDictionary  *dic  in  titlearray)
        {
            
             [_titleArray  addObject:[dic objectForKey:@"g_catgryname"]];
    
        }
        
        [_titleArray  insertObject:@"热门分类" atIndex:0];
        
        
        [self creatbuttonview];
        
        
        //  ===========
        NSArray  *titlearray2=[dict  objectForKey:@"hot_recommend"];
        
         NSLog(@"%@",titlearray2);
        for (NSDictionary *dict in titlearray2)
        {
            LeiBModel *model=[[LeiBModel alloc]initWithDictionary:dict];
            [_remenArray  addObject:model];
            
        }
        
        NSLog(@"%@",_remenArray);
        [self  creattableview];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark--------创建ButtonView
-(void)creatbuttonview
{
    scroller=[[UIScrollView alloc]initWithFrame:CGRectMake(0,64, 80, 568-64)];
    NSLog(@"%f",scroller.frame.origin.y);
    scroller.contentSize=CGSizeMake(80, 45*_titleArray.count);
    scroller.userInteractionEnabled=YES;
    scroller.showsVerticalScrollIndicator=NO;
    [self.view  addSubview:scroller];
    
    for(int i=0;i<_titleArray.count;i++)
    {
        
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=270+i;
        button.titleLabel.font=[UIFont  boldSystemFontOfSize:16];
        
        [button setBackgroundImage :[UIImage imageNamed:@"分类640_正常.png"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"分类640_点击后.png"] forState:UIControlStateSelected];
        
        [button  setTitle:[NSString stringWithFormat:@"%@",_titleArray[i]] forState:UIControlStateNormal];
        [button  setTitleColor:[UIColor  blackColor] forState:UIControlStateNormal];
        [button  setTitleColor:[UIColor  redColor] forState:UIControlStateSelected];
        [button  addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor=ZQColor(220, 220, 220);
        button.frame=CGRectMake(0,45*i,80,45);
        button.selected=NO;
        
        if (i == 0)
        {
            button.selected = YES;
        }
        
        [scroller addSubview:button];

    }
    
}
//  BUTTON 点击事件
-(void)buttonclick:(UIButton *)btn
{
    for (int i=270;i<270+_titleArray.count; i++)
    {
        UIButton *b = (UIButton *)[self.view viewWithTag:i];
        b.selected = NO;
    }
    btn.selected = YES;
    
    NSLog(@"1234");
    
}

#pragma mark--------创建tableView

-(void)creattableview
{
    
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(85,64, 235, 568) style:UITableViewStylePlain];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    [self.view  addSubview:_tableview];
    
    
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _remenArray.count/2;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LeiBieTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:nil];
    if(cell==nil)
    {
        cell=[[LeiBieTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
    }
    cell.selectionStyle=0;
    //  +++++++++++++++++++热门推荐
    if (indexPath.row==0)
      {
        UILabel * _titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0,0, 95,20)];
        [cell  addSubview:_titlelabel];
        _titlelabel.textAlignment=1;
        _titlelabel.font=[UIFont systemFontOfSize:14];
        _titlelabel.text=@"热门推荐";
        _titlelabel.textColor=[UIColor blackColor];
       }
    //  ================数据显示
   
            LeiBModel *model = _remenArray[indexPath.row*2];
            cell.titlelabel.text=model.gCatgryname;
            NSLog(@"%@",model.gCatgryname);
            [cell.imageview  setImageWithURL:[NSURL  URLWithString:model.symbolPic]];
            if (_remenArray.count>indexPath.row*2+1)
            {
            LeiBModel *model1=_remenArray[indexPath.row*2+1];
            //NSLog(@"%@",model1.gCatgryname);
            cell.titlelabel1.text=model1.gCatgryname;
            [cell.imageview1  setImageWithURL:[NSURL  URLWithString:model1.symbolPic]];
            }
            
     
    
 
     [cell  setImageblock:^{
       
       HotDetailsViewController *hot=[[HotDetailsViewController alloc]init];
       [self.navigationController  pushViewController:hot animated:YES];
       
   }];
    
    return cell;
    
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135;
}

#pragma mark------标签栏的隐藏和现实
-(void)viewWillAppear:(BOOL)animated
{
    scroller.frame=CGRectMake(0, 0, 320, 568);
    NSLog(@"%f",scroller.frame.origin.y);
    OLWTabBarController * tabBarVC =(OLWTabBarController *) self.tabBarController;
    tabBarVC.zqTabBar.hidden = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
   // [super viewWillDisappear:animated];
    OLWTabBarController * tabBarVC =(OLWTabBarController *) self.tabBarController;
    tabBarVC.zqTabBar.hidden =NO;
    
}



- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
