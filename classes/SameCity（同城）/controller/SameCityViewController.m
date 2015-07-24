//
//  SameCityViewController.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/13.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "SameCityViewController.h"
#import "JiaJuViewController.h"
#import "CheLiveViewController.h"
#import "YuLeViewController.h"

#import "MeiRongViewController.h"
#import "MeiShiViewController.h"
#import "RiChangViewController.h"
#import "XunYouViewController.h"
#import "FangYuanViewController.h"
#import "HuoYuanViewController.h"
#import "YiYuanViewController.h"
#import "ZhaoPinViewController.h"
#import "HuangShiViewController.h"
#import "JuHuaViewController.h"
#import "CZhiViewController.h"
#import "LeiBieViewController.h"
#import "HotSellViewController.h"
#import "ChuXingViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "CityListController.h"
#import "LocationManager.h"
#import "MyButton.h"
#import "SearchViewController.h"
#import "NewCityViewController.h"
#import "OLWTabBarController.h"
#import "UILabel+StringFrame.h"
#import "BackSingle.h"
#import "SingleNearCity.h"
#import "WDXXViewController.h"
#define H 84
#import "ProModel.h"
#import "CityModel.h"
#import "AreaModel.h"

@interface SameCityViewController ()<UIScrollViewDelegate,UISearchBarDelegate,CLLocationManagerDelegate>
{
    UISearchBar *_searchbar;
    UIView *_view;
    UITableView *_tableView;
    UIView *_DiQuview;
    CLLocationManager *_manager;
    UIButton *_diqubutton;

    UIScrollView  *scroller;
    int _hideHeight;//隐藏高度
    
    MyBarButton *_leftButton;
    LocationManager *_mana;
    
    UILabel *_reginLabel;
    UIImageView *_reginImageView;
    
    UILabel *_shumulabel;
    NSString *URLString;
    
}
@property(nonatomic,strong)UIView *searchView;
@end

@implementation SameCityViewController
//搜索栏

- (void)viewDidLoad {
    [super viewDidLoad];
    
    scroller=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, 320,self.view.bounds.size.height)];
    scroller.bounces=NO;
    UIImageView *iamgeview=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, 320, 570)];

    iamgeview.backgroundColor=ZQColor(255, 255, 255);
    [scroller  addSubview:iamgeview];
    
    if (self.view.bounds.size.height==480) {
        scroller.contentSize=CGSizeMake(320, 460);
    }
    if (self.view.bounds.size.height==568) {
        scroller.contentSize=CGSizeMake(320,465);
    }
    if (self.view.bounds.size.height==667) {
        scroller.contentSize=CGSizeMake(320, 480);
    }
    if (self.view.bounds.size.height==736) {
        scroller.contentSize=CGSizeMake(320, 480);
    }
    scroller.showsVerticalScrollIndicator=NO;
    [self.view  addSubview:scroller];
    
    
    [self location];//定位
    
    [self  deplyNavigationController1];
    
    [self  creatTopButton];
    
    [self  creatButton];
    
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSms) name:SMSNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSms) name:SMSAlready object:nil];
}
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

#pragma mark －－－－－配置导航栏

-(void)deplyNavigationController1
{
    self.navigationItem.title=@"同城";
    
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


//点击地区按钮
-(void)diquButtonClick:(UIButton *)btn
{
    CityListController *diqulist=[[CityListController alloc]init];
    [self.navigationController  pushViewController:diqulist animated:YES];
}

#pragma mark - 点击搜索按钮
-(void)searchBarClick
{
    SearchViewController *svc=[[SearchViewController alloc]init];
    [self.navigationController pushViewController:svc animated:YES];
}

#pragma mark -------创建顶部四个Button
-(void)creatTopButton
{

    
    NSArray *imageArray=@[@"tongchengmeijia.png",@"tongchenggouwuche.png",@"tongchengchongzhi.png",@"tongchengleibie.png"];
    NSArray *titltArray=@[@"皇室美家",@"巨划算",@"充值",@"分类"];
    for(int i=0;i<4;i++)
    {
        //创建button
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius=27;
        btn.frame=CGRectMake(13+80*i,10,54,54);
        btn.backgroundColor=[UIColor yellowColor];
        [btn setBackgroundImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.tag=250+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [scroller addSubview:btn];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(80*i,64, 80, 20)];
        label.font=[UIFont boldSystemFontOfSize:14];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=ZQColor(97, 100, 108);
        label.text=titltArray[i];
        [scroller addSubview:label];
    }
}

-(void)btnClick:(UIButton *)btn
{
    if(btn.tag==250){
        HuangShiViewController *huangShicontroller=[[HuangShiViewController alloc]init];
        [self.navigationController  pushViewController:huangShicontroller animated:YES];
    }
    else if (btn.tag==251){
        JuHuaViewController *jucontroller=[[JuHuaViewController alloc]init];
        [self.navigationController  pushViewController:jucontroller animated:YES];
    }
    else if (btn.tag==252){
        CZhiViewController *chongzhiController=[[CZhiViewController alloc]init];
        [self.navigationController  pushViewController:chongzhiController animated:YES];
    }
    else if (btn.tag==253){
        LeiBieViewController *leibieController=[[LeiBieViewController alloc]init];
        [self.navigationController  pushViewController:leibieController animated:YES];
    }
    
}


#pragma mark-------创建按钮
-(void)creatButton
{
    UIView *btnView=[[UIView alloc]initWithFrame:CGRectMake(0,85, 320, 420)];
    btnView.alpha=0;

    [scroller addSubview:btnView];
    
    UIButton *jiajubutton=[UIButton buttonWithType:UIButtonTypeCustom];
    jiajubutton.layer.cornerRadius=5;
    jiajubutton.layer.masksToBounds=YES;
    [jiajubutton  setImage:[UIImage imageNamed:@"同城A_03.png"] forState:UIControlStateNormal];
    [jiajubutton  setImage:[UIImage imageNamed:@"同城B_03.png"] forState:UIControlStateSelected];
    jiajubutton.frame=CGRectMake(5,5+H,152,70-3);
    [jiajubutton  addTarget:self action:@selector(buttonClick1:) forControlEvents:UIControlEventTouchUpInside];
    [scroller  addSubview:jiajubutton];
    
    UIButton *huoyuanbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    huoyuanbutton.layer.cornerRadius=5;
    huoyuanbutton.layer.masksToBounds=YES;
    [huoyuanbutton  setImage:[UIImage imageNamed:@"同城A_05.png"] forState:UIControlStateNormal];
    [huoyuanbutton  setImage:[UIImage imageNamed:@"同城B_05.png"] forState:UIControlStateSelected];

    [huoyuanbutton  addTarget:self action:@selector(buttonClick9:) forControlEvents:UIControlEventTouchUpInside];
    huoyuanbutton.frame=CGRectMake(152+5+5,5+H ,152, 70-3);
    [scroller  addSubview:huoyuanbutton];
    
    UIButton *yulebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    yulebutton.layer.cornerRadius=5;
    yulebutton.layer.masksToBounds=YES;
    [yulebutton  setImage:[UIImage imageNamed:@"同城A_09.png"] forState:UIControlStateNormal];
    [yulebutton  setImage:[UIImage imageNamed:@"同城B_09.png"] forState:UIControlStateSelected];

    [yulebutton  addTarget:self action:@selector(buttonClick5:) forControlEvents:UIControlEventTouchUpInside];
    yulebutton.frame=CGRectMake(5, 72+5+H ,100, 70-3);
    [scroller  addSubview:yulebutton];
    
    UIButton *fyuanbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    fyuanbutton.layer.cornerRadius=5;
    fyuanbutton.layer.masksToBounds=YES;
    [fyuanbutton  setImage:[UIImage imageNamed:@"同城A_11.png"] forState:UIControlStateNormal];
    [fyuanbutton  setImage:[UIImage imageNamed:@"同城B_11.png"] forState:UIControlStateSelected];

    [fyuanbutton  addTarget:self action:@selector(buttonClick2:) forControlEvents:UIControlEventTouchUpInside];
    fyuanbutton.frame=CGRectMake(110, 72+5+H , 100, 70-3);
    [scroller  addSubview:fyuanbutton];
    
    UIButton *chebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    chebutton.layer.cornerRadius=5;
    chebutton.layer.masksToBounds=YES;
    [chebutton  setImage:[UIImage imageNamed:@"同城A_13.png"] forState:UIControlStateNormal];
    [chebutton  setImage:[UIImage imageNamed:@"同城B_13.png"] forState:UIControlStateSelected];

    [chebutton  addTarget:self action:@selector(buttonClick10:) forControlEvents:UIControlEventTouchUpInside];
    chebutton.frame=CGRectMake(215, 72+5+H ,100, 70-3);
    [scroller  addSubview:chebutton];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.cornerRadius=5;
    button.layer.masksToBounds=YES;
    [button  setImage:[UIImage imageNamed:@"同城A_17.png"] forState:UIControlStateNormal];
    [button  setImage:[UIImage imageNamed:@"同城B_17.png"] forState:UIControlStateSelected];
    [button  addTarget:self action:@selector(buttonClick3:) forControlEvents:UIControlEventTouchUpInside];
    button.frame=CGRectMake(5,72+5+70+5-3+H ,100,70-3);
    [scroller  addSubview:button];
    
    UIButton *richangbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    richangbutton.layer.cornerRadius=5;
    richangbutton.layer.masksToBounds=YES;
    [richangbutton  setImage:[UIImage imageNamed:@"同城A_18.png"] forState:UIControlStateNormal];
    [richangbutton  setImage:[UIImage imageNamed:@"同城B_18.png"] forState:UIControlStateSelected];

    [richangbutton  addTarget:self action:@selector(buttonClick4:) forControlEvents:UIControlEventTouchUpInside];
    richangbutton.frame=CGRectMake(110, 72+5+70+5-3+H , 100, (70-3)*2+5);
    [scroller  addSubview:richangbutton];
    
    UIButton *xunyoubutton=[UIButton buttonWithType:UIButtonTypeCustom];
    xunyoubutton.layer.cornerRadius=5;
    xunyoubutton.layer.masksToBounds=YES;
    [xunyoubutton  setImage:[UIImage imageNamed:@"同城A_19.png"] forState:UIControlStateNormal];
    [xunyoubutton  setImage:[UIImage imageNamed:@"同城B_19.png"] forState:UIControlStateSelected];

    [xunyoubutton  addTarget:self action:@selector(buttonClick8:) forControlEvents:UIControlEventTouchUpInside];
    xunyoubutton.frame=CGRectMake(215,72+5+70+5-3+H ,100, 70-3);
    [scroller  addSubview:xunyoubutton];
    
    
    UIButton *yuehuibutton=[UIButton buttonWithType:UIButtonTypeCustom];
    yuehuibutton.layer.cornerRadius=5;
    yuehuibutton.layer.masksToBounds=YES;
    [yuehuibutton  setImage:[UIImage imageNamed:@"同城A_22.png"] forState:UIControlStateNormal];
    [yuehuibutton  setImage:[UIImage imageNamed:@"同城B_22.png"] forState:UIControlStateSelected];

    [yuehuibutton  addTarget:self action:@selector(buttonClick7:) forControlEvents:UIControlEventTouchUpInside];
    yuehuibutton.frame=CGRectMake(5,72+5+70+5-3+70-3+5+H ,100,70-3);
    [scroller  addSubview:yuehuibutton];
    
    UIButton *meirongbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    meirongbutton.layer.cornerRadius=5;
    meirongbutton.layer.masksToBounds=YES;
    [meirongbutton  setImage:[UIImage imageNamed:@"同城A_23.png"] forState:UIControlStateNormal];
    [meirongbutton  setImage:[UIImage imageNamed:@"同城B_23.png"] forState:UIControlStateSelected];

    [meirongbutton  addTarget:self action:@selector(buttonClick6:) forControlEvents:UIControlEventTouchUpInside];
    meirongbutton.frame=CGRectMake(215,72+5+70+5-3+70-3+5+H ,100,70-3);
    [scroller  addSubview:meirongbutton];
    
    UIButton *yiyuanbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    yiyuanbutton.layer.cornerRadius=5;
    yiyuanbutton.layer.masksToBounds=YES;
    [yiyuanbutton  setImage:[UIImage imageNamed:@"同城A_27.png"] forState:UIControlStateNormal];
    [yiyuanbutton  setImage:[UIImage imageNamed:@"同城B_27.png"] forState:UIControlStateSelected];

    [yiyuanbutton  addTarget:self action:@selector(buttonClick11:) forControlEvents:UIControlEventTouchUpInside];
    yiyuanbutton.frame=CGRectMake(5, 72+5+70+5-3+70-3+5+70-3+5+H ,152, 70-6);
    [scroller  addSubview:yiyuanbutton];
    
    UIButton *zhaopbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    zhaopbutton.layer.cornerRadius=5;
    zhaopbutton.layer.masksToBounds=YES;
    [zhaopbutton  setImage:[UIImage imageNamed:@"同城A_29.png"] forState:UIControlStateNormal];
    [zhaopbutton  setImage:[UIImage imageNamed:@"同城B_29.png"] forState:UIControlStateSelected];

    [zhaopbutton  addTarget:self action:@selector(buttonClick12:) forControlEvents:UIControlEventTouchUpInside];
    zhaopbutton.frame=CGRectMake(152+5+5,72+5+70+5-3+70-3+5+70-3+5+H ,152, 70-6);
    [scroller  addSubview:zhaopbutton];
    
}


-(void)buttonClick1:(UIButton *)button
{
    button.selected=YES;
    
    JiaJuViewController *jiajuController=[[JiaJuViewController alloc]init];
    [self.navigationController  pushViewController:jiajuController animated:YES];
}

-(void)buttonClick2:(UIButton *)button
{
      button.selected=YES;
    XunYouViewController *xunYouController=[[XunYouViewController alloc]init];
    [self.navigationController pushViewController:xunYouController animated:YES];
}

-(void)buttonClick3:(UIButton *)button
{  button.selected=YES;
    YuLeViewController *yuleController=[[YuLeViewController alloc]init];
    [self.navigationController  pushViewController:yuleController animated:YES];
    
}

-(void)buttonClick4:(UIButton *)button
{  button.selected=YES;
    RiChangViewController *riChangController=[[RiChangViewController alloc]init];
    [self.navigationController  pushViewController:riChangController animated:YES];
    
}
-(void)buttonClick5:(UIButton *)button
{  button.selected=YES;
    MeiShiViewController *meiShiController=[[MeiShiViewController alloc]init];
    [self.navigationController pushViewController:meiShiController animated:YES];
    
}
-(void)buttonClick6:(UIButton *)button
{  button.selected=YES;
    
    YiYuanViewController *yiYuanController=[[YiYuanViewController alloc]init];
    [self.navigationController  pushViewController:yiYuanController  animated:YES];
    
}
-(void)buttonClick7:(UIButton *)button
{  button.selected=YES;
    MeiRongViewController *meiRongController=[[MeiRongViewController alloc]init];
    [self.navigationController  pushViewController:meiRongController animated:YES];
    
    
}
-(void)buttonClick8:(UIButton *)button
{  button.selected=YES;
    FangYuanViewController *fangyuanController=[[FangYuanViewController alloc]init];
    [self.navigationController  pushViewController:fangyuanController animated:YES];
}

-(void)buttonClick9:(UIButton *)button
{  button.selected=YES;
    HuoYuanViewController *huoyuan =[[HuoYuanViewController alloc]init];
    [self.navigationController pushViewController:huoyuan animated:YES];

}

-(void)buttonClick10:(UIButton *)button
{
      button.selected=YES;
    ZhaoPinViewController *zhaoPingController=[[ZhaoPinViewController alloc]init];
    [self.navigationController  pushViewController:zhaoPingController animated:YES];
    
}
-(void)buttonClick11:(UIButton *)button
{  button.selected=YES;
    CheLiveViewController *cheLivecontroller=[[CheLiveViewController alloc]init];
    [self.navigationController  pushViewController:cheLivecontroller animated:YES];
    
    
}
-(void)buttonClick12:(UIButton *)button
{  button.selected=YES;
    ChuXingViewController *chuXingController=[[ChuXingViewController alloc]init];
    [self.navigationController  pushViewController:chuXingController animated:YES];
}


#pragma mark---------搜索开始编辑
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    _view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 600)];
    _view.backgroundColor=[UIColor blackColor];
    _view.alpha=0.4;
    [self.view addSubview:_view];
    _view.hidden=NO;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ViewClick:)];
    [_view  addGestureRecognizer:tap];
    
    
}

-(void)ViewClick:(UITapGestureRecognizer *)tap
{
    tap.view.hidden=YES;
    [_searchbar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    _view.hidden=YES;
    _searchbar.text=@"";
    [_searchbar resignFirstResponder];
    
}

#pragma mark - 定位
-(void)location{
    [self layOutUI];
    
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
            //===
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            CityModel *mm=[[CityModel alloc]init];
            [mm setValuesForKeysWithDictionary:dict];
            
            BOOL flag = [NSKeyedArchiver archiveRootObject:mm toFile:SelectCity_Path];
            if(!flag) {
                NSLog(@"归档失败！");
            }
            [[NSUserDefaults standardUserDefaults]setValue:mm.city forKey:LocationCity];
            
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
            single.selectCity=mm.city;
            single.provId=mm.provid;
            single.cityId=mm.cityid;
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        

        
    }];
    self.view.backgroundColor = [UIColor whiteColor];
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
    //
    _leftButton=[[MyBarButton alloc]initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem = _leftButton;
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0))
    {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                       target:nil action:nil];
        negativeSpacer.width = -10;//这个数值可以根据情况自由变化
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, _leftButton];
    }else
        self.navigationItem.leftBarButtonItem = _leftButton;
    
    
 
    id model = [NSKeyedUnarchiver unarchiveObjectWithFile: SelectCity_Path];
    NSString *name;
    if (model==nil) {
        BackSingle *sin=[BackSingle shareInstance];
        CityModel *mo=[[CityModel alloc]init];
        mo.city=sin.selectCity;
        mo.cityid=sin.cityId;
        mo.provid=sin.provId;
        BOOL flag = [NSKeyedArchiver archiveRootObject:mo toFile:SelectCity_Path];
        if(!flag) {
            NSLog(@"归档失败！");
        }
        _reginLabel.text=mo.city;
        _reginImageView.frame=CGRectMake(_reginLabel.text.length*20, 15, 15, 5);
        return;
    }
    
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

-(void)cityClick
{
    NewCityViewController *vc=[[NewCityViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    CustomTabBar *tabBar=(CustomTabBar*)self.navigationController.tabBarController;
    tabBar.zqTabBar.hidden=NO;
 
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

    }

}

#pragma mark - 跳到rootViewC
-(void)toRoot
{
    WDXXViewController *rvc=[[WDXXViewController alloc]init];
    [self.navigationController pushViewController:rvc animated:YES];
}



@end
