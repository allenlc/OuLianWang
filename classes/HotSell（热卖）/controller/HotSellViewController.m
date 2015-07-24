//
//  HotSellViewController.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/13.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "HotSellViewController.h"
#import "ZQSearchBar.h"
#import "HotSellCell.h"
#import "HotDetailsViewController.h"
#import "DiQuListViewController.h"
#import "FourthTableViewCell.h"
#import "NewCityViewController.h"
#import "JuHeCityModel.h"
#import "LocationManager.h"
#import "MyButton.h"
#import "SearchViewController.h"
#import "BackSingle.h"
#import "WDXXViewController.h"
#import "HotXHModel.h"
#import "HotshPiModel.h"
#import "ProModel.h"
#import "CityModel.h"
#import "AreaModel.h"
#import "HotFenLViewController.h"


@interface HotSellViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

{
    UIView * midview ;
    //UIImageView *listView;
    UIScrollView *scrollerview;
    
    
    UISearchBar *_searchbar;
    UIView *_view;
    UIView * topView;
    LocationManager *_mana;
    UILabel *_reginLabel;
    UIImageView *_reginImageView;
    UILabel *_shumulabel;
    UITableView *hotSellTableView;
    //  分类数组
    NSMutableArray *_classArray;
    //  循环图片数组
    NSMutableArray *_TuPArray;
    //  商品数组
    NSMutableArray *_SpArray;
    //   分类界面一级数组
    NSMutableArray *_brandArray;
    NSMutableArray *_categoryArray;
    NSMutableArray *_factoryArray;
    
    //
    NSString *URLString;
    int  cityid;
    int  proviceid;
    int  areaid;
    int  page;
    int  pagesize;
    
}


@property(nonatomic,weak)UITableView * hotSellTableView;
//@property(nonatomic,weak)UITableView * hotSellTableView;


@end

@implementation HotSellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZQColor(232, 233, 232);
    self.navigationItem.title = @"热卖";
    [self location];
    [self  deplyNavigationController1];
      
   
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSms) name:SMSNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSms) name:SMSAlready object:nil];
    
    //  下载数据
    [self  downloaddata];
    
    //  下载完数据创建tableview
    [self creattableview];
    
    //
    cityid=0;
    proviceid=1;
    areaid=0;
    page=0;
    pagesize=0;
    
   
}

#pragma mark --------下载数据

//----------------------下载显示界面数据
-(void)downloaddata
{
    //  数组的初始化
    _classArray=[[NSMutableArray alloc]init];
    _TuPArray=[[NSMutableArray alloc]init];
    _SpArray=[[NSMutableArray alloc]init];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
     // ----------------------下载分类数据
    [manager  GET:HotFLUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary  *dic=responseObject;
        NSArray *arr =dic[@"goods_category"];
        for (NSDictionary *dic in arr )
        {
            [_classArray  addObject:dic[@"keyname"]];
        }
        
        [_classArray  insertObject:@"全部" atIndex:0];
        
        NSLog(@"------------%@",_classArray);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
     //  ----------------------下载循环滚动视图数据下载
    [manager  GET:HotSPUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic=responseObject;
        NSArray *array=dic[@"list"];
        for (NSDictionary *dic in array)
        {
            HotXHModel *model=[[HotXHModel alloc]initWithDictionary:dic];
            [_TuPArray  addObject:model];
        }
        NSLog(@"--------%@",_TuPArray);

        [hotSellTableView  reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
    //  -------------------------下载商品数据
    
    URLString=[NSString  stringWithFormat:HotShpiurl,page,pagesize,proviceid,cityid,areaid];
    [manager GET:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic=responseObject;
        NSArray *array=dic[@"goods"];
        for (NSDictionary *dic in array)
        {
            HotshPiModel *model=[[HotshPiModel alloc]initWithDictionary:dic];
            [_SpArray addObject:model];
        }
        
        [hotSellTableView  reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
    //-----------------------------下载分类下拉界面的数据
    _brandArray=[[NSMutableArray alloc]init];
    _categoryArray=[[NSMutableArray alloc]init];
    _factoryArray=[[NSMutableArray alloc]init];

    [manager  GET:FenLeiUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic=responseObject;
        NSArray *array=dic[@"brand"];
        //  一级品牌的数据
        for (NSDictionary *dic in array)
        {
            [_brandArray addObject:dic[@"brandname"]];
        }
        
        NSArray *array1=dic[@"category"];
        //  一级行业的数据
        for (NSDictionary *dic in array1)
        {
            [_categoryArray addObject:dic[@"g_catgryname"]];
        }
        
        NSArray *array2=dic[@"factory"];
        //  一级工厂的数据
        for (NSDictionary *dic in array2)
        {
            [_factoryArray addObject:dic[@"storename"]];
        }
     //------------------------------------
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}


#pragma mark-----开始刷新自定义方法
- (void)setupRefresh
{
    //下拉刷新
    
    [hotSellTableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [hotSellTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    //一些设置
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    hotSellTableView.headerPullToRefreshText = @"下拉可以刷新了";
    hotSellTableView.headerReleaseToRefreshText = @"松开马上刷新了";
    hotSellTableView.headerRefreshingText = @"刷新中。。。";
    
    hotSellTableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    hotSellTableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    hotSellTableView.footerRefreshingText = @"加载中。。。";
    
}
//下拉刷新
- (void)headerRereshing
{
    //一般这些个里边是网络请求，然后会有延迟，不会像现在刷新这么快
    // 1.添加假数据
    
    [self downloaddata];
    //2.结束刷新
    [hotSellTableView headerEndRefreshing];
}
//上拉加载
- (void)footerRereshing
{
    //这个一般是提取缓存的数据
    // 1.添加假数据
    [_brandArray  removeAllObjects];
    [_categoryArray  removeAllObjects];
    [_factoryArray  removeAllObjects];
    
    [self downloaddata];
    //2,结束刷新
    [hotSellTableView footerEndRefreshing];
}



#pragma mark--------改变导航栏上面消息的显示数目
-(void)changeSms
{
    BackSingle *singlele=[BackSingle shareInstance];
    _shumulabel.text=[NSString stringWithFormat:@"%d",singlele.manySms];
    if ([_shumulabel.text isEqualToString:@"0"]) {
        _shumulabel.hidden=YES;
    }
    else
        _shumulabel.hidden=NO;
}
//设置导航按钮

#pragma mark －－－－－配置导航栏

-(void)deplyNavigationController1
{
    self.navigationItem.title=@"热卖";
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
    [button1  setImage:[UIImage  imageNamed:@"搜索.png"] forState:UIControlStateNormal];
    button1.frame=CGRectMake(0,5,23,23);
    [button1  addTarget:self action:@selector(button1Click1) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right1=[[UIBarButtonItem alloc]initWithCustomView:button1];
    
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeCustom];
    [button2  setImage:[UIImage  imageNamed:@"消息图标3.png"] forState:UIControlStateNormal];
    button2.frame=CGRectMake(10,0,32,27);
    
    //        ==================================   消息数目的小label
    
    _shumulabel=[[UILabel alloc]initWithFrame:CGRectMake(19,-3, 16, 16)];
    _shumulabel.userInteractionEnabled=YES;
    _shumulabel.layer.cornerRadius=8;
    _shumulabel.font=[UIFont  systemFontOfSize:11];
    _shumulabel.layer.masksToBounds=YES;
    BackSingle *singgg=[BackSingle shareInstance];
    if (singgg.manySms>0) {
        _shumulabel.text=[NSString stringWithFormat:@"%d",singgg.manySms];
        _shumulabel.hidden=NO;
    }
    else{
        _shumulabel.text=@"";
        _shumulabel.hidden=YES;
    }
    
    _shumulabel.textAlignment=1;
    _shumulabel.layer.borderWidth=1;
    _shumulabel.layer.borderColor=[UIColor whiteColor].CGColor;
    _shumulabel.backgroundColor=[UIColor orangeColor];
    _shumulabel.textColor=[UIColor whiteColor];
    [button2  addSubview:_shumulabel];
    [button2 addTarget:self action:@selector(toRoot) forControlEvents:UIControlEventTouchUpInside];

    
    UIBarButtonItem *right2=[[UIBarButtonItem alloc]initWithCustomView:button2];
    
    self.navigationItem.rightBarButtonItems=@[right2,right1];
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0))
        
    {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                       target:nil action:nil];
        negativeSpacer.width = -10;//这个数值可以根据情况自由变化
        self.navigationItem.rightBarButtonItems = @[negativeSpacer, right2,right1];
    }
    else
        
        self.navigationItem.rightBarButtonItems=@[right2,right1];
    

    
}

-(void)button1Click1
{
    SearchViewController *search=[[SearchViewController alloc]init];
    [self.navigationController  pushViewController:search animated:YES];
    
}

#pragma mark------创建tableview
-(void)creattableview
{

    hotSellTableView = [[UITableView alloc]initWithFrame:CGRectMakeEx(0 , 0, 320, 558) style:UITableViewStylePlain];
    hotSellTableView.delegate = self;
    hotSellTableView.dataSource = self;
    hotSellTableView.delaysContentTouches=NO;
    [self.view addSubview:hotSellTableView];
    //self.hotSellTableView = hotSellTableView;
    [self setupRefresh];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section ==1)
    {
      
        if (_SpArray.count%2==0)
          {
            return _SpArray.count/2;
          }
        else
             return _SpArray.count/2+1;
        
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section ==0 )
    {
        HotSellCell * cell = [HotSellCell cellWithTableViewCell:hotSellTableView];
        NSMutableArray  *tupianArray=[[NSMutableArray alloc]init];
        for (HotXHModel *model in _TuPArray)
        {
            [tupianArray  addObject: model.promImg];
            
        }
         cell.imageviewsArray=tupianArray;
        [cell setindexPath:indexPath];
        return cell;
        
    }
    else
    {
        FourthTableViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:[FourthTableViewCell myIdentify]];
        cell=[[FourthTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[FourthTableViewCell myIdentify]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        HotshPiModel *model=_SpArray[indexPath.row*2];
        [cell.lookImageView1 setImageWithURL:[NSURL URLWithString:model.gimg]];
        cell.nameLabel1.text=model.goodsname;
        cell.priceLabel1.text=model.price;
        if (_SpArray.count>indexPath.row*2+1)
        {
            HotshPiModel *model1=_SpArray[indexPath.row*2+1];
            [cell.lookImageView2 setImageWithURL:[NSURL URLWithString:model1.gimg]];
            cell.nameLabel2.text=model1.goodsname;
            cell.priceLabel2.text=model1.price;
        
        }
        
        [cell setTapBlock1:^{
            //  传店铺的ID到详情界面
            HotDetailsViewController *detailController=[[HotDetailsViewController alloc]init];
            HotshPiModel *model=_SpArray[indexPath.row*2];
            detailController.Gidstring=model.gid;
            [self.navigationController  pushViewController:detailController animated:YES];
        }];
        [cell setTapBlock2:^{
            
            //  传店铺的ID到详情界面
            HotDetailsViewController *detailController=[[HotDetailsViewController alloc]init];
            HotshPiModel *model1=_SpArray[indexPath.row*2+1];
            detailController.Gidstring=model1.gid;
            [self.navigationController  pushViewController:detailController animated:YES];
            
        }];

          return cell;
    }
   
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section ==1) {
        
    
    //搜索条件视图
        midview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 60)];
        midview.userInteractionEnabled =YES;
        midview.backgroundColor = [UIColor whiteColor];

    for (int i = 0; i<_classArray.count; i++) {
        UIButton * classBtn = [[UIButton alloc]init];
        classBtn.tag  = i+200;
        classBtn.size = CGSizeMake((self.view.width-30)/_classArray.count, 30);
        classBtn.center = CGPointMake(classBtn.width/2+classBtn.width*i, classBtn.height/2);
        [classBtn setTitle:_classArray[i] forState:0];
        [classBtn setBackgroundImage:[UIImage resizedImageWithName:@"blue_rm"] forState:UIControlStateNormal];
        [classBtn setBackgroundImage:[UIImage resizedImageWithName:@"write_classes"] forState:UIControlStateSelected];
        classBtn.backgroundColor = ZQColor(10, 79, 192);
        [classBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [classBtn setTitleColor:[UIColor whiteColor] forState:0];
        classBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [classBtn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        [midview addSubview:classBtn];
    }
    self.selectBtn =(UIButton *) [midview viewWithTag:200];
    self.selectBtn.selected = YES;
    self.selectBtn.backgroundColor = [UIColor whiteColor];
    self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    
    //    创建下拉分类按钮
    UIButton * listBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    listBtn.frame = CGRectMake(self.view.width-30, 0, 30, 30);
        [listBtn setImage:[UIImage imageNamed:@"V_下"] forState:0];
        [listBtn setImage:[UIImage imageNamed:@"V_上"] forState:UIControlStateSelected];
    [listBtn addTarget:self action:@selector(listView:) forControlEvents:UIControlEventTouchUpInside];
    listBtn.selected = NO;
    [midview addSubview:listBtn];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 100, 25)];
    label.text = @"商品列表";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor redColor];
    [midview addSubview:label];
    
    UIImageView * leftRect = [[UIImageView alloc]initWithFrame:CGRectMake(0, 36, 10, 13)];
    leftRect.backgroundColor = [UIColor redColor];
    [midview addSubview:leftRect];
        
        UIImageView * img2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 55, self.view.width, 5)];
        img2.backgroundColor = ZQColor(232, 233, 232);
        [midview addSubview:img2];
    
        [self setListView];
        
        return midview;
        
    }
    else {
        return nil;
    }

}
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 55;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 120;
        
    }

    else{
       return [FourthTableViewCell myHeight];
    }
}



#pragma mark -----创建下拉视图
-(void)setListView
{
    scrollerview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,150, self.view.width,(_factoryArray.count/4+_brandArray.count/4+_categoryArray.count/4)*20+250)];
    scrollerview.contentSize=CGSizeMake(320, 600);
    scrollerview.userInteractionEnabled=YES;
    scrollerview.backgroundColor=[UIColor whiteColor];
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(25, 20, 40, 20 )];
    label1.text = @"行业";
    label1.font = [UIFont systemFontOfSize:15];
    label1.textColor = [UIColor blueColor];
    [scrollerview addSubview:label1];
    
    UIImageView * lineImgView = [[UIImageView alloc]initWithFrame:CGRectMake(25, 40, self.view.width-55, 1)];
    lineImgView.backgroundColor = [UIColor grayColor];
    [scrollerview addSubview:lineImgView];
    int n = 0;
    
    //NSArray * arr1 = @[@"全部",@"家居",@"美食",@"服装",@"鞋包",@"首饰",@"运动",@"健身",@"数码",@"家电",@"办公",@"工艺",@"玩具",@"化妆",@"家纺",@"百货"];
    for (int i = 0; i<_categoryArray.count/4; i++)
    {
        for (int j = 0; j<4; j++)
        {
            UIButton *button0 = [UIButton  buttonWithType:UIButtonTypeSystem];
            button0.frame=CGRectMake(20+((self.view.width-200)/3+30)*j,50+25*i,60, 20);
            button0.titleLabel.textAlignment=NSTextAlignmentLeft;
            [button0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button0 setTitle:_categoryArray[n] forState:UIControlStateNormal];
            [button0  addTarget:self  action:@selector(button0click:) forControlEvents:UIControlEventTouchUpInside];
            button0.titleLabel.font = [UIFont systemFontOfSize:14];
            [scrollerview addSubview:button0];
            n++;
        }
    }
    
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(25, 20+130, 40, 20 )];
    label2.text = @"品牌";
    label2.font = [UIFont systemFontOfSize:15];
    label2.textColor = [UIColor greenColor];
    [scrollerview addSubview:label2];
    
    UIImageView * lineImgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(25, 170, self.view.width-55, 1)];
    lineImgView2.backgroundColor = [UIColor grayColor];
    [scrollerview addSubview:lineImgView2];
    
    int m=0;
    for (int i = 0; i<_brandArray.count/4; i++)
    {
        for (int j = 0; j<4; j++)
        {
            UIButton *button1 = [UIButton  buttonWithType:UIButtonTypeSystem];
            button1.frame=CGRectMake(20+((self.view.width-200)/3+30)*j,180+25*i,60, 20);
            button1.titleLabel.textAlignment=NSTextAlignmentLeft;
            [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button1 setTitle:_brandArray[m ] forState:UIControlStateNormal];
            button1.titleLabel.font = [UIFont systemFontOfSize:14];
            [scrollerview addSubview:button1];
            m++;
        }
    }

    UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(25, 180+100, 40, 20 )];
    label3.text = @"厂商";
    label3.font = [UIFont systemFontOfSize:15];
    label3.textColor = [UIColor redColor];
    [scrollerview addSubview:label3];
    
    UIImageView * lineImgView3 = [[UIImageView alloc]initWithFrame:CGRectMake(25, 300, self.view.width-55, 1)];
    lineImgView3.backgroundColor = [UIColor grayColor];
    [scrollerview addSubview:lineImgView3];
    
    int x=0;
    for (int i = 0; i<_factoryArray.count/4; i++)
    {
        for (int j = 0; j<4; j++)
        {
            UIButton *button2 = [UIButton  buttonWithType:UIButtonTypeSystem];
            button2.frame=CGRectMake(20+((self.view.width-200)/3+30)*j,310+25*i,60, 20);
          //  [button2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
            [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button2 setTitle:_factoryArray[x] forState:UIControlStateNormal];
            button2.titleLabel.font = [UIFont systemFontOfSize:14];
            [scrollerview addSubview:button2];
             x++;
        }
    }
    
        scrollerview.hidden = YES;
        [hotSellTableView    addSubview:scrollerview];
    
}

//分类选择按钮方法
-(void)choose:(UIButton *)sender
{
    self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.selectBtn.selected = NO;
    sender.selected = YES;
    self.selectBtn = sender;
    self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
}
#pragma mark -----具体分类弹出框
-(void)listView:(UIButton *)sender
{
    if (sender.selected == NO)
    {
        scrollerview.hidden = sender.selected;
        sender.selected = YES;
        
    }
    else
    {
        scrollerview.hidden = sender.selected;
        sender.selected = NO;
        
    }
    
}

-(void)button0click:(UIButton *)butt
{
    scrollerview.hidden=YES;
    
    HotFenLViewController *controller=[[HotFenLViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
    
    
}



#pragma mark -----具体定位数据
-(void)location
{

    [self layOutUI];
    
}

- (void)layOutUI
{
    UIView *leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    leftView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cityClick)];
    [leftView addGestureRecognizer:tap];
    _reginLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    _reginLabel.font=[UIFont boldSystemFontOfSize:18];
    _reginLabel.textColor=[UIColor whiteColor];
    NSDictionary *dic=[[NSUserDefaults standardUserDefaults]valueForKey:SelectedCity];
    _reginLabel.text=dic[@"name"];
    [leftView addSubview:_reginLabel];
    _reginImageView=[[UIImageView alloc]initWithFrame:CGRectMake(_reginLabel.text.length*20, 15, 15, 5)];
    _reginImageView.image=[UIImage imageNamed:@"ZX下拉.png"];
    [leftView addSubview:_reginImageView];
    //==
    id model = [NSKeyedUnarchiver unarchiveObjectWithFile: SelectCity_Path];
    NSString *name;
 
    if ([model isKindOfClass:[CityModel class]]) {
        CityModel *mm=model;
        name=mm.city;
    }
    else if ([model isKindOfClass:[ProModel class]]) {
        ProModel *mm=model;
        name=mm.province;
    }
    else if ([model isKindOfClass:[AreaModel class]]) {
        AreaModel *mm=model;
        name=mm.area;
    }
    
    if (name.length>4) {
        _reginLabel.text=[name substringToIndex:4];
        _reginImageView.frame=CGRectMake(_reginLabel.text.length*20, 15, 15, 5);
    }
    else{
        _reginLabel.text=name;
        _reginImageView.frame=CGRectMake(_reginLabel.text.length*20, 15, 15, 5);
    }
    
    
    //----
    MyBarButton *leftButton=[[MyBarButton alloc]initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0))
    {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                       target:nil action:nil];
        negativeSpacer.width = -10;//这个数值可以根据情况自由变化
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftButton];
    }else
        self.navigationItem.leftBarButtonItem = leftButton;
    
    
    
}


#pragma mark ----- 城市点击

-(void)cityClick
{
    NewCityViewController *cityListVC = [[NewCityViewController alloc] init];
    [self.navigationController pushViewController:cityListVC animated:YES];
}



#pragma mark-----城市选择后传参数
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    id model = [NSKeyedUnarchiver unarchiveObjectWithFile: SelectCity_Path];
    NSString *name;
    
    if ([model isKindOfClass:[CityModel class]]) {
        CityModel *mm=model;
        name=mm.city;
    }
    else if ([model isKindOfClass:[ProModel class]]) {
        ProModel *mm=model;
        name=mm.province;
        
    }
    else if ([model isKindOfClass:[AreaModel class]]) {
        AreaModel *mm=model;
        name=mm.area;
    }
    //城市需要切换
    //=============================================================
    if (![_reginLabel.text isEqualToString:name]) {
        if (name.length>4) {
            _reginLabel.text=[name substringToIndex:4];
            _reginImageView.frame=CGRectMake(_reginLabel.text.length*20, 15, 15, 5);
        }
        else{
            _reginLabel.text=name;
            _reginImageView.frame=CGRectMake(_reginLabel.text.length*20, 15, 15, 5);
        }
        NSLog(@"City Change");
        //清空数组
 
    

        if ([model isKindOfClass:[CityModel class]]) {
            CityModel *mm=model;
            name=mm.city;
            cityid=mm.cityid.intValue;
            [_SpArray  removeAllObjects];
            //  商品数据
            URLString=[NSString  stringWithFormat:HotShpiurl,page,pagesize,proviceid,cityid,areaid];
        
           [self  downloaddata];
            
        }
        else if ([model isKindOfClass:[ProModel class]]) {
            ProModel *mm=model;
            name=mm.province;
            
            proviceid=mm.provid.intValue;
            [_SpArray  removeAllObjects];
            //  商品数据
            URLString=[NSString  stringWithFormat:HotShpiurl,page,pagesize,proviceid,cityid,areaid];
            [self  downloaddata];
            
        }
        else if ([model isKindOfClass:[AreaModel class]]) {
            AreaModel *mm=model;
            name=mm.area;
            areaid=mm.areaid.intValue;
            [_SpArray  removeAllObjects];
            //  商品数据
            URLString=[NSString  stringWithFormat:HotShpiurl,page,pagesize,proviceid,cityid,areaid];
            NSLog(@"...........%@",URLString);
            [self  downloaddata];
            [hotSellTableView  reloadData];
            
        }
        
        if (![_reginLabel.text isEqualToString:name]) {
            if (name.length>4) {
                _reginLabel.text=[name substringToIndex:4];
                _reginImageView.frame=CGRectMake(_reginLabel.text.length*20, 15, 15, 5);
            }
            else{
                _reginLabel.text=name;
                _reginImageView.frame=CGRectMake(_reginLabel.text.length*20, 15, 15, 5);
            }
            
        }
    
    }
}

#pragma mark - 跳到rootViewC
-(void)toRoot
{
    WDXXViewController *rvc=[[WDXXViewController alloc]init];
    [self.navigationController pushViewController:rvc animated:YES];
}

@end
