//
//  LocationViewController.m
//  OuLianWang
//
//  Created by allenariel on 15/6/22.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "LocationViewController.h"
#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import <CoreLocation/CoreLocation.h>
#import "CLLocation+Sino.h"
#import "CustomTabBar.h"
#import "ShopModel.h"
#import "ListViewTableViewCell.h"
#import "HomeShopController.h"
#import "NewCityViewController.h"
#import "ProModel.h"
#import "CityModel.h"
#import "AreaModel.h"

@interface LocationViewController ()<MAMapViewDelegate,
AMapSearchDelegate,UIGestureRecognizerDelegate,CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    
    AMapSearchAPI *_search;
    
    UIView *_Dituview;
    
    UIButton *_reginBtn;
    UILabel *_reginLabel;
    UIImageView *_reginImageView;
    
    NSMutableArray *_qieHuanArr;
}
@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self deplynavigationController1];
    [self creatSegmentAndMap];
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    CustomTabBar *tabBar=(CustomTabBar*)self.navigationController.tabBarController;
    tabBar.zqTabBar.hidden=YES;
    id model = [NSKeyedUnarchiver unarchiveObjectWithFile: SelectCity_Path];
    NSString *name;
    //    goodstab=1;
    //    page=1;
    
    if ([model isKindOfClass:[CityModel class]]) {
        CityModel *mm=model;
        name=mm.city;
        //        URLString=[NSString stringWithFormat:HomeCity_URL,_single.lon,_single.lan,[mm.cityid intValue],goodstab,page];
    }
    else if ([model isKindOfClass:[ProModel class]]) {
        ProModel *mm=model;
        name=mm.province;
        //        URLString=[NSString stringWithFormat:HomePro_URL,_single.lon,_single.lan,[mm.provid intValue],goodstab,page];
        
    }
    else if ([model isKindOfClass:[AreaModel class]]) {
        AreaModel *mm=model;
        name=mm.area;
        //        URLString=[NSString stringWithFormat:HomeArea_URL,_single.lon,_single.lan,[mm.areaid intValue],goodstab,page];
        
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
        NSLog(@"City Change");
        //        [_ShuJArray removeAllObjects];
        //        [_imageArray removeAllObjects];
        //        [self downloaddata];
        
    }
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    CustomTabBar *tabBar=(CustomTabBar*)self.navigationController.tabBarController;
    tabBar.zqTabBar.hidden=YES;
}


#pragma mark-------------配置导航栏
-(void)deplynavigationController1
{
    self.searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(30,0,220,39)];
    self.searchBar.delegate = self;
    self.navigationItem.titleView=_searchBar;
    
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
    //
    UIBarButtonItem *rightbtn=[[UIBarButtonItem alloc]initWithCustomView:leftView];
    self.navigationItem.rightBarButtonItem = rightbtn;
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0))
    {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                       target:nil action:nil];
        negativeSpacer.width = -10;//这个数值可以根据情况自由变化
        self.navigationItem.rightBarButtonItems = @[negativeSpacer, rightbtn];
    }else
        self.navigationItem.rightBarButtonItem = rightbtn;
    
    NSDictionary *dict=[[NSUserDefaults standardUserDefaults]valueForKey:SelectedCity];
    
    //设置label
    if (dict[@"name"]==nil) {
        NSDictionary *dd=@{@"name":@"北京市"};
        [[NSUserDefaults standardUserDefaults]setValue:dd forKey:SelectedCity];
        _reginLabel.text=dd[@"name"];
        _reginImageView.frame=CGRectMake(_reginLabel.text.length*20, 15, 15, 5);
        
    }
    else
    {
        NSDictionary *d=[[NSUserDefaults standardUserDefaults]valueForKey:SelectedCity];
        NSString *str=d[@"name"];
        if (str.length>4) {
            _reginLabel.text=[str substringToIndex:4];
            _reginImageView.frame=CGRectMake(_reginLabel.text.length*20, 15, 15, 5);
        }
        else{
            _reginLabel.text=dict[@"name"];
            _reginImageView.frame=CGRectMake(_reginLabel.text.length*20, 15, 15, 5);
        }
        
    }
    

    
}

-(void)cityClick
{
    NewCityViewController *vc=[[NewCityViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark------------创建地图和列表按钮
-(void)creatSegmentAndMap
{
    _qieHuanArr=[NSMutableArray array];
    
    self.mainScrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    _mainScrollView.showsHorizontalScrollIndicator=NO;
    _mainScrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_mainScrollView];
    
    //地图按钮
    self.mapButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_mapButton setBackgroundImage:[UIImage imageNamed:@"huoyuandituhuidu.png"] forState:UIControlStateNormal];
    [_mapButton setBackgroundImage:[UIImage imageNamed:@"huoyuanditu2.png"] forState:UIControlStateSelected];
    [_mapButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _mapButton.selected=YES;
    [_qieHuanArr addObject:_mapButton];
    [_mapButton  addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    _mapButton.layer.borderColor=[UIColor blackColor].CGColor;
    _mapButton.layer.shadowColor=[UIColor blackColor].CGColor;
    _mapButton.frame=CGRectMake(0, 85, 160, 30);
    _mapButton.backgroundColor=ZQColor(201, 41, 32);
    [self.mainScrollView  addSubview:_mapButton];
    //列表按钮
    self.listButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_listButton setBackgroundImage:[UIImage imageNamed:@"货源-地图版_06.png"] forState:UIControlStateNormal];
    [_listButton setBackgroundImage:[UIImage imageNamed:@"货源-地图版_03"] forState:UIControlStateSelected];
    [_listButton  addTarget:self action:@selector(listButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _listButton.layer.borderColor=[UIColor blackColor].CGColor;
    _listButton.frame=CGRectMake(160, 85, 160, 30);
    [self.mainScrollView  addSubview:_listButton];
    
    //创建地图
    self.mapUIView=[[UIView alloc]initWithFrame:CGRectMake(5, 120, 310, 465)];
    [self.mainScrollView addSubview:_mapUIView];
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.mapUIView.bounds];
    _mapView.delegate = self;
    _mapView.showsScale=YES;
    _mapView.showsCompass=NO;
    [self.mapUIView addSubview:_mapView];
    _mapView.userTrackingMode=MAUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;    //YES 为打开定位，NO为关闭定位
    [_mapView setRegion:MACoordinateRegionMake(_mapView.userLocation.coordinate, MACoordinateSpanMake(0.01, 0.01)) animated:YES];
    [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES]; //地图跟着位置移动
    
    //返回按钮
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"tcfanhui.png"] forState:UIControlStateNormal];
    btn.frame=CGRectMakeEx(self.mapUIView.frame.size.width-50, self.mapUIView.frame.size.height-40, 35, 35);
    btn.backgroundColor=[UIColor yellowColor];
    [btn addTarget:self action:@selector(backUser) forControlEvents:UIControlEventTouchUpInside];
    [_mapUIView addSubview:btn];
    
    //创建列表
    self.listView=[[UITableView alloc]initWithFrame:CGRectMake(0, 120, 320, 465)];
    _listView.delegate=self;
    _listView.dataSource=self;
    [self.mainScrollView  addSubview:_listView];
    self.listView.hidden=YES;
    [self setExtraCellLineHidden:_listView];
    self.mainScrollView.contentSize=CGSizeMake(0, 540);
}
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
//切换按钮点击
-(void)buttonClick:(UIButton *)button
{
    UIButton *bb=_qieHuanArr[0];
    if (bb!=button) {
        [_qieHuanArr removeAllObjects];
        bb.selected=NO;
        button.selected=YES;
        _mapUIView.hidden=NO;
        _listView.hidden=YES;
        [_qieHuanArr addObject:button];
    }
}

//切换按钮点击
-(void)listButtonClick:(UIButton *)button
{
    UIButton *bb=_qieHuanArr[0];
    if (bb!=button) {
        [_qieHuanArr removeAllObjects];
        bb.selected=NO;
        button.selected=YES;
        _mapUIView.hidden=YES;
        _listView.hidden=NO;
        [_qieHuanArr addObject:button];
    }
}
//回到user位置
-(void)backUser
{
    [_mapView setRegion:MACoordinateRegionMake(_mapView.userLocation.coordinate, MACoordinateSpanMake(0.01, 0.01)) animated:YES];
}
#pragma mark - 大头针显示触发
-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(WoAnnotation *)annotation
{
    //加载第一个大头针时候，反编译获得定位的位置
    if (![annotation isKindOfClass:[WoAnnotation class]]) {
        //地位反编译
        CLGeocoder *reverseCeoCoder=[[CLGeocoder alloc]init];
        [reverseCeoCoder reverseGeocodeLocation:self.mapView.userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
            for (CLPlacemark *placemark in placemarks) {
                //位置转换参数
                NSLog(@"地址反编码 %@ %@ %@",placemark.administrativeArea,placemark.locality,placemark.subLocality);
                [self locationChangeToIdWithProvince:placemark.administrativeArea andCity:placemark.locality andArae:placemark.subLocality] ;
            }
        }];
        return nil;
    }
    
    static NSString *identify=@"mapanno";
    WoAnnotationView *annoView=(WoAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identify];
    if (annoView==nil) {
        annoView=[[WoAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identify];
    }
    annoView.bounds=CGRectMake(0, 0, 44, 44);
    //加载大头针样式
    [annoView.annoImageView setImageWithURL:[NSURL URLWithString:annotation.pointerimg]];
    [annoView.logoImageView setImageWithURL:[NSURL URLWithString:annotation.logo]];
    annoView.canShowCallout=YES;
    annoView.model=annotation.model;
    
    [annoView setMapBlcok:^(ShopModel * mm) {
        HomeShopController *hvc=[[HomeShopController alloc]init];
        hvc.storeId=@"1";
        hvc.meter=mm.meter;
        [self.navigationController pushViewController:hvc animated:YES];

    }];
    
    return annoView;
}


#pragma mark - 获取位置对应的ID 待修改
-(void)locationChangeToIdWithProvince:(NSString *)pro andCity:(NSString *)city andArae:(NSString *)area
{
    if ([pro isEqualToString:@"广东省"])
        self.provinceId=1;
    else
        self.provinceId=0;
    if ([city isEqualToString:@"广州市"])
        self.cityId=1;
    else
        self.cityId=0;
    if ([area isEqualToString:@"天河区"])
        self.areaId=1;
    else
        self.areaId=0;
    [self startDownloadData];

}
#pragma mark - 下载数据
-(void)startDownloadData
{
}

#pragma mark - 懒加载dataArray
-(NSMutableArray *)locationArray
{
    if (_locationArray==nil) {
        _locationArray=[NSMutableArray array];
    }
    return _locationArray;
}

#pragma mark - tableview的数据源方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _locationArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListViewTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:[ListViewTableViewCell myIdentify]];
    if (cell==nil) {
        cell=[[ListViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ListViewTableViewCell myIdentify]];
    }
    ShopModel *mm =self.locationArray[indexPath.row];

    cell.shopModel=mm;
    [cell createUI];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ListViewTableViewCell myHeight];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopModel *mm =self.locationArray[indexPath.row];
    
    HomeShopController *hvc=[[HomeShopController alloc]init];
    hvc.storeId=@"1";
    hvc.meter=mm.meter;
    
    [self.navigationController pushViewController:hvc animated:YES];
    
}
//当用户按下return键或者按回车键，keyboard消失

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSLog(@"当用户按下return键或者按回车键，keyboard消失");
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
