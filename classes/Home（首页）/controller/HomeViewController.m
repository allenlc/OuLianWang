//
//  HomeViewController.m
//  OuLianWang 
//
//  Created by 皇室美家 on 15/6/13.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "HomeViewController.h"
#import "MJViewController.h"
#import "UIView+LCView.h"
#import "FirstTableViewCell.h"
#import "SecondTableViewCell.h"
#import "ThirdTableViewCell.h"
#import "FourthTableViewCell.h"
#import "UIKit+AFNetworking.h"
#import "HuangShiViewController.h"
#import "JuHuaViewController.h"
#import "CZhiViewController.h"
#import "LeiBieViewController.h"
#import "HotDetailsViewController.h"
#import "ShopDetailController.h"
#import "NewCityViewController.h"
#import "SearchViewController.h"
#import "LocationManager.h"
#import "JuHeCityModel.h"
#import "MyButton.h"
#import "GDViewController.h"
#import "SaoViewController.h"
#import "XunHGdModel.h"
#import "DianPModel.h"
#import "GoodsModel.h"
#import "SameCityViewController.h"
#import "AreaModel.h"
#import "CityModel.h"
#import "ProModel.h"
#import "RoutePlanViewController.h"

#define Home_Data @"Home_Data"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UISearchBar *_searchbar;
    UIView *_view;
    UIView *_topVIew;
    UIImageView *_reginImageView;
    UILabel *_reginLabel;
    NSArray *_titltArray;
    NSArray *_twoArray;
    BOOL a;
    LocationManager *_mana;
    NSMutableArray *_imageArray;
    DianPModel *_dianPuModel;
    NSMutableArray *_ShuJuArray;
    
    //  为了刷新数据定义全局变量
    NSString   *URLString;
    int goodstab;
    int page;
    BackSingle *_single;
    BOOL b;
    BOOL _isShangLa;
}
@property(nonatomic,strong)ThirdTableViewCell *thirdTableViewCell;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation HomeViewController
-(ThirdTableViewCell *)thirdTableViewCell
{
    if (_thirdTableViewCell==nil) {
        _thirdTableViewCell=[[ThirdTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    return _thirdTableViewCell;
}
-(NSMutableArray *)dataArray
{
    if (_dataArray==nil)
    {
        _dataArray=[NSMutableArray array];
        
    }
    return _dataArray;
}

static UITableView *_onetableView = nil;

- (UITableView *)defaultManager
{
    if (!_onetableView)
    {
         _onetableView = [[UITableView alloc] init];

    }
     return _onetableView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];


    [self deplyNavigationController1];
    
    _titltArray=@[@"类别",@"",@"品牌",@"",@"厂商",@""];
    
    _twoArray=@[@"全部",@"家居",@"美食",@"服装",@"全部",@"家居",@"美食",@"服装",@"全部",@"家居",@"美食",@"服装",@"全部",@"家居",@"美食",@"服装",@"全部",@"家居",@"美食",@"服装",@"全部",@"家居",@"美食",@"服装",@"全部",@"家居",@"美食",@"服装"];
    

    _dianPuModel=[[DianPModel alloc]init];
    _ShuJuArray=[NSMutableArray array];
    _imageArray=[[NSMutableArray alloc]init];
    _single=[BackSingle shareInstance];
    _isShangLa=YES;


    //设置Label
    [self locationmy];

    //  创建tableview
    [self createTableView];
    [self loadLastData];
    [self downloaddata];
    //配置刷新
    [self setupRefresh];

}

#pragma mark －－－－－配置导航栏

-(void)deplyNavigationController1
{
    self.navigationItem.title=@"首页";

    UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
    [button1  setImage:[UIImage  imageNamed:@"搜索.png"] forState:UIControlStateNormal];
    button1.frame=CGRectMake(0,5,23,23);
    [button1  addTarget:self action:@selector(button1Click1) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right1=[[UIBarButtonItem alloc]initWithCustomView:button1];
    
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeCustom];
    [button2  setImage:[UIImage  imageNamed:@"扫一扫图标3.png"] forState:UIControlStateNormal];
    button2.frame=CGRectMake(5,0,27,25);
    [button2  addTarget:self action:@selector(button2Click2) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right2=[[UIBarButtonItem alloc]initWithCustomView:button2];
    
    self.navigationItem.rightBarButtonItems=@[right2,right1];
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0))
    {
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                       target:nil action:nil];
        negativeSpacer.width = -5;//这个数值可以根据情况自由变化
        self.navigationItem.rightBarButtonItems = @[negativeSpacer, right2,right1];
        
    
    }
    
    else
        
        self.navigationItem.rightBarButtonItems=@[right2,right1];
    

}
#pragma mark - 加载缓冲
-(void)loadLastData
{
    NSDictionary *dic=[[NSUserDefaults standardUserDefaults]valueForKey:Home_Data];
    //循环滚动的的接口数据
    NSArray *imageArray=[dic objectForKey:@"proimg"];
    for (NSDictionary *dict in imageArray)
    {
        XunHGdModel *model=[[XunHGdModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [_imageArray addObject:model];
    }
    
    //店铺的接口数据
    [_dianPuModel setValuesForKeysWithDictionary:dic[@"storemsg"]];
    
    //下面详细商品的接口
    NSArray *arr=[dic objectForKey:@"goods"];
    for (NSDictionary *dd in arr) {
        
        GoodsModel *mm=[[GoodsModel alloc]init];
        [mm setValuesForKeysWithDictionary:dd];
        [_ShuJuArray addObject:mm];
    }
    [_tableView reloadData];
}

#pragma mark-------下载数据
-(void)downloaddata
{
    NSLog(@"首页URL %@",URLString);
    [MBProgressHUD showMessage:@"正在加载中"];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [manager  GET:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
         NSDictionary *dic=[NSJSONSerialization  JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //===
//        [[NSUserDefaults standardUserDefaults]setObject:dic forKey:Home_Data];
        //是否是下拉刷新
        if (_isShangLa) {
            [_ShuJuArray removeAllObjects];
            [_imageArray removeAllObjects];
            _isShangLa=NO;
        }
        //循环滚动的的接口数据
        NSArray *imageArray=[dic objectForKey:@"proimg"];
        for (NSDictionary *dict in imageArray)
        {
            XunHGdModel *model=[[XunHGdModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [_imageArray addObject:model];
        }

        //店铺的接口数据
        [_dianPuModel setValuesForKeysWithDictionary:dic[@"storemsg"]];

        //下面详细商品的接口
        NSArray *arr=[dic objectForKey:@"goods"];
        for (NSDictionary *dd in arr) {

            GoodsModel *mm=[[GoodsModel alloc]init];
            [mm setValuesForKeysWithDictionary:dd];
            [_ShuJuArray addObject:mm];
        }
        [MBProgressHUD hideHUD];
        [_tableView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        
    }];
    

}




-(void)button1Click1
{
    SearchViewController *search=[[SearchViewController alloc]init];
    [self.navigationController  pushViewController:search animated:YES];
}

-(void)button2Click2
{
    SaoViewController *sao=[[SaoViewController alloc]init];
    [self.navigationController  pushViewController:sao animated:YES];
    

}

-(void)searchClick
{
    SearchViewController *svc=[[SearchViewController alloc]init];
    [self.navigationController pushViewController:svc animated:YES];
}




//#pragma mark －－－－－ 创建顶部四个Button
-(void)creatButton
{
    NSArray *imageArray=@[@"tongchengmeijia.png",@"tongchenggouwuche.png",@"tongchengchongzhi.png",@"tongchengleibie.png"];
    NSArray *titltArray=@[@"皇室美家",@"巨划算",@"充值",@"类别"];
    for(int i=0;i<4;i++)
    {
        //创建button
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius=27;
        btn.frame=CGRectMake(13+80*i,20,54,54);
        [btn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        btn.tag=100+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_topVIew addSubview:btn];
        //创建label
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(80*i ,80, 80, 20)];
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont boldSystemFontOfSize:14];
        label.text=titltArray[i];
        [_topVIew  addSubview:label];
    }

}

#pragma mark - 按钮点击事件
-(void)btnClick:(UIButton *)tap
{
    
    if(tap.tag==100)
    {
        HuangShiViewController *huacontroller=[[HuangShiViewController alloc]init];
        [self.navigationController  pushViewController:huacontroller animated:YES];
        
    }
    else if (tap.tag==101)
    {
       
        JuHuaViewController *jucontroller=[[JuHuaViewController alloc]init];
        [self.navigationController  pushViewController:jucontroller animated:YES];
        
    }
    else if (tap.tag==102)
    {
        CZhiViewController *conController=[[CZhiViewController alloc]init];
        [self.navigationController  pushViewController:conController animated:YES];
    }
    else if (tap.tag==103)
    {
        LeiBieViewController *leicontroller=[[LeiBieViewController alloc]init];
        [self.navigationController pushViewController:leicontroller animated:YES];
        
    }
    
}


#pragma mark--------显示tableview

-(void)createTableView
{
    _topVIew =[[UIView  alloc]initWithFrame:CGRectMake(0,0, 320, 115)];
    _topVIew.backgroundColor=[UIColor whiteColor];
    
    [self  creatButton];
    float ab=575;
    if (self.view.width==320) {
        ab=300;
    }

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,60,320,ab) style:UITableViewStylePlain];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableHeaderView=_topVIew;
    [self.view addSubview:_tableView];
}
//开始刷新自定义方法
- (void)setupRefresh
{
    //下拉刷新

    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
//    [_tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    //一些设置
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    _tableView.headerPullToRefreshText = @"下拉可以刷新了";
    _tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    _tableView.headerRefreshingText = @"刷新中。。。";
    
    _tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    _tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    _tableView.footerRefreshingText = @"加载中。。。";
}
//下拉刷新
- (void)headerRereshing
{
    //一般这些个里边是网络请求，然后会有延迟，不会像现在刷新这么快
    _isShangLa=YES;
    
    page=1;
    id model = [NSKeyedUnarchiver unarchiveObjectWithFile: SelectCity_Path];
    
    if ([model isKindOfClass:[CityModel class]]) {
        CityModel *mm=model;
        URLString=[NSString stringWithFormat:HomeCity_URL,_single.lon,_single.lan,[mm.cityid intValue],goodstab,page];
    }
    else if ([model isKindOfClass:[ProModel class]]) {
        ProModel *mm=model;
        URLString=[NSString stringWithFormat:HomePro_URL,_single.lon,_single.lan,[mm.provid intValue],goodstab,page];
    }
    else if ([model isKindOfClass:[AreaModel class]]) {
        AreaModel *mm=model;
        URLString=[NSString stringWithFormat:HomeArea_URL,_single.lon,_single.lan,[mm.areaid intValue],goodstab,page];
    }

    [self downloaddata];

    [_tableView headerEndRefreshing];
}

//上拉加载
- (void)footerRereshing
{
    //这个一般是提取缓存的数据
    // 1.添加数据
    page++;
    id model = [NSKeyedUnarchiver unarchiveObjectWithFile: SelectCity_Path];

    if ([model isKindOfClass:[CityModel class]]) {
        CityModel *mm=model;
        URLString=[NSString stringWithFormat:HomeCity_URL,_single.lon,_single.lan,[mm.cityid intValue],goodstab,page];
    }
    else if ([model isKindOfClass:[ProModel class]]) {
        ProModel *mm=model;
        URLString=[NSString stringWithFormat:HomePro_URL,_single.lon,_single.lan,[mm.provid intValue],goodstab,page];
    }
    else if ([model isKindOfClass:[AreaModel class]]) {
        AreaModel *mm=model;
        URLString=[NSString stringWithFormat:HomeArea_URL,_single.lon,_single.lan,[mm.areaid intValue],goodstab,page];
    }

    [self downloaddata];
    //2,结束刷新
    [_tableView footerEndRefreshing];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==_onetableView) {
        return 1;
    }
    return 4;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_onetableView)
    {
        return 2;
    }
    
    if (section==0)
        return 1;
    else if(section==1)
        return 1;
    else if(section==2)
        return 1;
    else if(section==3)
    {
        if (_ShuJuArray.count==0) {
            return 0;
        }
        else if(_ShuJuArray.count%2==0)
           {
             return _ShuJuArray.count/2;
           }
        else
             return _ShuJuArray.count/2+1;//下载数据
    }
    return 0;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==_onetableView  )
    {
        UITableViewCell*tableviewcell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        if (indexPath.row%2 ==0) {
           
                    tableviewcell.textLabel.text=_titltArray[indexPath.row];
                    tableviewcell.textLabel.font=[UIFont  boldSystemFontOfSize:18];
                    tableviewcell.textLabel.textColor=[UIColor purpleColor];
                    UIButton *button1=[UIButton buttonWithType:UIButtonTypeSystem];
                    [button1  setTitle:@"更多..." forState:UIControlStateNormal];
                    [button1  setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
                    [button1  addTarget:self action:@selector(button1Click) forControlEvents:UIControlEventTouchUpInside];
                    button1.frame=CGRectMake(250,5,320/4,30);
                    [tableviewcell  addSubview:button1];
            
        }
        else
          {
            int x=0;
            int y=0;
            
        for (int i=0; i<16; i++)
            {
            
                if(i%4==0&&i!=0)
                {
                    y++;
                    x=0;
                }
                    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
                    [button  setTitle:_twoArray[i] forState:UIControlStateNormal];
                    [button  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
                    button.frame=CGRectMake(80*x,30*y,320/4,30);
                    [tableviewcell  addSubview:button];
                    x++;
                
            }
              
          }
        
        return tableviewcell;

    }
    
    //  店铺的数据
    if (indexPath.section==0)
    {
        FirstTableViewCell *cellone=[[FirstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cellone.selectionStyle=UITableViewCellSelectionStyleNone;
        [cellone.lookImageView setImageWithURL:[NSURL URLWithString:_dianPuModel.gateimg] placeholderImage:DEFAULTIMG];
        cellone.nameLabel.text=_dianPuModel.storename;
        cellone.dateLabel.text=[_dianPuModel.operatime substringToIndex:10];
        cellone.lichengLabel.text=[NSString  stringWithFormat:@"%@ km",_dianPuModel.kilometer];
        cellone.lichengLabel.font=[UIFont systemFontOfSize:12];
        cellone.dituView.image=[UIImage imageNamed:@"dtjjdp.png"];
        cellone.dituView.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(daohang)];
        [cellone.dituView addGestureRecognizer:tap];
        
        if ([_dianPuModel.hprate isEqualToString:@"未评论"]) {
            cellone.nowIsNo.hidden=NO;
        }
        float star=[_dianPuModel.hprate  floatValue];
        [cellone.starView setStar:star/2.0];

        return cellone;
    }
    else if (indexPath.section==1)
    {
        //  滚动的视图，在这里加入图片
        SecondTableViewCell  *celltwo=[[SecondTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [celltwo setImagearray:_imageArray];
        
        celltwo.bigImageView.image=[UIImage imageNamed:@"img.png"];
        return celltwo;
    }
    else if (indexPath.section==2)
    {
        __weak typeof (self)weakSelf=self;
        _thirdTableViewCell=self.thirdTableViewCell;
        [self.thirdTableViewCell setMyBlock1:^(UIButton * btn) {
            [weakSelf  defaultManager];
            //  布尔类型判断_onetableView是否需要被隐藏
            if (a==NO)
            {
                _onetableView.hidden=NO;
                a=YES;
            }
            else
            {
                _onetableView.hidden=YES;
                a=NO;
            }
            _onetableView.delegate=self;
            _onetableView.dataSource=self;
            _onetableView.userInteractionEnabled=YES;
            _onetableView.frame=CGRectMake(0, 370, 320, 0);
            _onetableView.alpha=0.9;
            //这个方法中得completion是指结束的动画。。。
            [UIView animateWithDuration:1.0 animations:^{
            _onetableView.frame=CGRectMake(0, 370, 320, 568);
                
            } completion:^(BOOL finished) {

            }];

            [_tableView addSubview:_onetableView];
   
        }];
        
        [_thirdTableViewCell setMyBlock2:^(UIButton * btn) {
            
            [_onetableView  removeFromSuperview];
            if (goodstab==1) {
                return ;
            }
            goodstab=1;
            [weakSelf changeGoodtabWith:1];
            
            [weakSelf downloaddata];
      
            NSLog(@"销量排行");
            
        }];
        [_thirdTableViewCell setMyBlock3:^(UIButton * btn) {
           
            [_onetableView  removeFromSuperview];
            if (goodstab==2) {
                return ;
            }
            goodstab=2;
            [weakSelf changeGoodtabWith:2];
            [weakSelf downloaddata];
            
             NSLog(@"人气排行");
        }];
        [_thirdTableViewCell setMyBlock4:^(UIButton * btn) {
            
            [_onetableView  removeFromSuperview];
            if (goodstab==3) {
                return ;
            }
            goodstab=3;
            [weakSelf changeGoodtabWith:3];
            [weakSelf downloaddata];
            
            NSLog(@"评价排行");
        }];
    
        return _thirdTableViewCell;
    }
    
    else if (indexPath.section==3)
    {
        //  下面两个图片型tableview的数据接入
        FourthTableViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:[FourthTableViewCell myIdentify]];
        cell=[[FourthTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[FourthTableViewCell myIdentify]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
       
        GoodsModel *model1=_ShuJuArray[indexPath.row*2];
        
        [cell.lookImageView1 setImageWithURL:[NSURL URLWithString:model1.goods_img] placeholderImage:DEFAULTIMG];
        cell.nameLabel1.text=model1.goodsname;
        cell.priceLabel1.text=model1.price;

        if (_ShuJuArray.count>indexPath.row*2+1)
        {
            GoodsModel *model2=_ShuJuArray[indexPath.row*2];
            [cell.lookImageView1 setImageWithURL:[NSURL URLWithString:model2.goods_thumb]placeholderImage:[UIImage imageNamed:@"shafa1"]];
            cell.nameLabel1.text=model2.goodsname;
            cell.priceLabel1.text=model2.price;

            if (_ShuJuArray.count>indexPath.row*2+1)
            {
                GoodsModel *model2=_ShuJuArray[indexPath.row*2+1];
                [cell.lookImageView2 setImageWithURL:[NSURL URLWithString:model2.goods_img] placeholderImage:DEFAULTIMG];
                cell.nameLabel2.text=model2.goodsname;
                cell.priceLabel2.text=model2.price;
            }
        }
    
        
        [cell setTapBlock1:^{
            HotDetailsViewController *detailController=[[HotDetailsViewController alloc]init];
            [self.navigationController  pushViewController:detailController animated:YES];
            
        }];
        
        [cell setTapBlock2:^{
            HotDetailsViewController *detailController=[[HotDetailsViewController alloc]init];
            [self.navigationController  pushViewController:detailController animated:YES];
            
        }];
       
        return cell;
    }
    else
        return nil;
}

#pragma mark ------  全部分类界面点击事件
-(void)buttonClick
{
    //NSLog(@"213");

}

#pragma mark ------  全部分类更多的点击事件
-(void)button1Click
{
    [_onetableView  removeFromSuperview];
    GDViewController *gdcontroller=[[GDViewController alloc]init];
    [self.navigationController  pushViewController:gdcontroller animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_onetableView)
    {
        if (indexPath.row%2==0) {
            return 40;
        }
        else
            
            return 120;
    }
    
    else
    {
        if(indexPath.section==0)
        {
            return [FirstTableViewCell myHeight];
        }
        else if(indexPath.section==1)
            return [SecondTableViewCell myHeight];
        
        else if(indexPath.section==2)
            return [ThirdTableViewCell myHeight];
        else
            return [FourthTableViewCell myHeight];
    
    }

}

//  选中Cell跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tableView) {
        if(indexPath.section==0)
        {
            ShopDetailController *dianpuCOntroller=[[ShopDetailController alloc]init];
            [self.navigationController pushViewController:dianpuCOntroller animated:YES];
        }
        

    }
    else
        NSLog(@"!!!!");
    
}

#pragma mark - 定位
    
-(void)locationmy{
    [self layOutUI];
    
}

- (void)layOutUI{
    UIView *leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    leftView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cityClick)];
    [leftView addGestureRecognizer:tap];
    _reginLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    _reginLabel.font=[UIFont boldSystemFontOfSize:18];
    _reginLabel.textColor=[UIColor whiteColor];
    [leftView addSubview:_reginLabel];
    _reginImageView=[[UIImageView alloc]initWithFrame:CGRectMake(_reginLabel.text.length*20, 15, 15, 5)];
    _reginImageView.image=[UIImage imageNamed:@"ZX下拉.png"];
    [leftView addSubview:_reginImageView];
    
    id model = [NSKeyedUnarchiver unarchiveObjectWithFile: SelectCity_Path];
    NSString *name;
    goodstab=0;
    page=1;

    if ([model isKindOfClass:[CityModel class]]) {
        CityModel *mm=model;
        name=mm.city;
        URLString=[NSString stringWithFormat:HomeCity_URL,_single.lon,_single.lan,[mm.cityid intValue],goodstab,page];
    }
    else if ([model isKindOfClass:[ProModel class]]) {
        ProModel *mm=model;
        name=mm.province;
        URLString=[NSString stringWithFormat:HomePro_URL,_single.lon,_single.lan,[mm.provid intValue],goodstab,page];
    }
    else if ([model isKindOfClass:[AreaModel class]]) {
        AreaModel *mm=model;
        name=mm.area;
        URLString=[NSString stringWithFormat:HomeArea_URL,_single.lon,_single.lan,[mm.areaid intValue],goodstab,page];
    }
    
    if (name.length>4) {
        _reginLabel.text=[name substringToIndex:4];
        _reginImageView.frame=CGRectMake(_reginLabel.text.length*20, 15, 15, 5);
    }
    else{
        _reginLabel.text=name;
        _reginImageView.frame=CGRectMake(_reginLabel.text.length*20, 15, 15, 5);
    }
    
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

#pragma mark - 城市点击
-(void)cityClick
{
    NewCityViewController *cityListVC = [[NewCityViewController alloc] init];
    [self.navigationController pushViewController:cityListVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _tableView.frame=CGRectMake(0, 0, 320, 558);
    
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
        [_ShuJuArray removeAllObjects];
        [_imageArray removeAllObjects];
        page=1;
        goodstab=0;
        [_thirdTableViewCell setFirstClick];
        //这是第一次扫描进来的情况
        if (_reginLabel.text==nil) {
            _mana=[LocationManager shareLocationManager];
            [_mana updatingLoaction];
            [_mana setActionBlock:^(JuHeCityModel *model) {
                //定位成功触发
                //赋予一个城市字符串
                NSString *urlString=[NSString stringWithFormat:LOCATION_URL,model.city_name];
                NSString *ss = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSLog(@"定位获取城市url %@",ss);
                AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
                manager.responseSerializer=[AFHTTPResponseSerializer serializer];
                [manager GET:ss parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    CityModel *mm=[[CityModel alloc]init];
                    [mm setValuesForKeysWithDictionary:dict];
                    BOOL flag = [NSKeyedArchiver archiveRootObject:mm toFile:SelectCity_Path];
                    if(!flag) {
                        NSLog(@"归档失败！");
                    }
                    NSString *str=mm.city;
                    if (str.length>4) {
                        _reginLabel.text=[str substringToIndex:4];
                        _reginImageView.frame=CGRectMake(_reginLabel.text.length*20, 15, 15, 5);
                    }
                    else{
                        _reginLabel.text=str;
                        _reginImageView.frame=CGRectMake(_reginLabel.text.length*20, 15, 15, 5);
                    }
                    BackSingle *single=[BackSingle shareInstance];
                    single.provId=dict[@"provid"];
                    single.cityId=dict[@"cityid"];
                    //下载数据
                    URLString=[NSString stringWithFormat:HomeCity_URL,single.lon,single.lan,[single.cityId intValue],goodstab,page];
                    [self downloaddata];
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
                
            }];
            
            return;
        }

        if ([model isKindOfClass:[CityModel class]]) {
            CityModel *mm=model;
            URLString=[NSString stringWithFormat:HomeCity_URL,_single.lon,_single.lan,[mm.cityid intValue],goodstab,page];
        }
        else if ([model isKindOfClass:[ProModel class]]) {
            ProModel *mm=model;
            URLString=[NSString stringWithFormat:HomePro_URL,_single.lon,_single.lan,[mm.provid intValue],goodstab,page];
        }
        else if ([model isKindOfClass:[AreaModel class]]) {
            AreaModel *mm=model;
            URLString=[NSString stringWithFormat:HomeArea_URL,_single.lon,_single.lan,[mm.areaid intValue],goodstab,page];
        }
        [self downloaddata];
    }
}

//得到Document目录
-(NSString *) getFilePathWithModelKey:(NSString *)modelkey
{
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[array objectAtIndex:0] stringByAppendingPathComponent:modelkey];
}

#pragma mark - goodtab切换
-(void)changeGoodtabWith:(int)tab
{
    id model = [NSKeyedUnarchiver unarchiveObjectWithFile: SelectCity_Path];
    NSString *name;
    page=1;
    
    if ([model isKindOfClass:[CityModel class]]) {
        CityModel *mm=model;
        name=mm.city;
        URLString=[NSString stringWithFormat:HomeCity_URL,_single.lon,_single.lan,[mm.cityid intValue],tab,page];
    }
    else if ([model isKindOfClass:[ProModel class]]) {
        ProModel *mm=model;
        name=mm.province;
        URLString=[NSString stringWithFormat:HomePro_URL,_single.lon,_single.lan,[mm.provid intValue],tab,page];
        
    }
    else if ([model isKindOfClass:[AreaModel class]]) {
        AreaModel *mm=model;
        name=mm.area;
        URLString=[NSString stringWithFormat:HomeArea_URL,_single.lon,_single.lan,[mm.areaid intValue],tab,page];
    }
    [_ShuJuArray removeAllObjects];
    [_imageArray removeAllObjects];
    
}

-(void)daohang
{
    HomeModel *mm=[[HomeModel alloc]init];
    mm.latitude=_dianPuModel.latitude;
    mm.longitude=_dianPuModel.longitude;
    
    RoutePlanViewController *plan=[[RoutePlanViewController alloc]initWithModel:mm];
    [self.navigationController pushViewController:plan animated:YES];
}


@end
