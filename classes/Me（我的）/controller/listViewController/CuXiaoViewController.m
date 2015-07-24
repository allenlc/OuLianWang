//
//  CuXiaoViewController.m
//  OuLianWang
//
//  Created by allenariel on 15/7/6.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "CuXiaoViewController.h"
#import "CustomTabBar.h"
#import "CuXiaoButton.h"
#import "CuXiaoFirstTableViewCell.h"
#import "CuxiaoSecondTableViewCell.h"
#import "CuxiaoThirdTableViewCell.h"
#import "CuxiaoFourTableViewCell.h"
#import "LookShopViewController.h"
#import "NewpromoInfoVC.h"
#import "FastSalesViewController.h"
#import "NewActivityVC.h"

@interface CuXiaoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIButton *_huiYuanBtn;
    UIButton *_shangPinBtn;
    UIButton *_fuWuBtn;
    UIButton *_huoDongBtn;
    
    CuXiaoButton *_woDeButton;
    CuXiaoButton *_tongChengButton;
    CuXiaoButton *_quanGuoButton;
    
    NSMutableArray *_lastBtnArr;
    NSMutableArray *_lastBtnArr1;
    NSMutableArray *_lastBtnArr2;
    BOOL _isGo;
    
    UITableView *_tableView;
    
    UIButton *_mapSelectedButton;
    UIButton *_listSelectdeButton;
    
}
@end

@implementation CuXiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"促销推广";
    // Do any additional setup after loading the view.
    [self createTableView];
    [self createSeg];
    [self createTopBtn];
    [self createBigTwoBtn];
}
-(void)viewWillAppear:(BOOL)animated
{
    CustomTabBar *tabBar=(CustomTabBar*)self.navigationController.tabBarController;
    
    tabBar.zqTabBar.hidden=YES;
}

-(void)createSeg
{
    [self.mapButton removeFromSuperview];
    [self.listButton removeFromSuperview];
    [self.listView removeFromSuperview];
    self.mapView.frame=CGRectMake(5, 135, 310, 465);
    self.mainScrollView.contentSize=CGSizeMake(0, 561);
    
    _woDeButton=[[CuXiaoButton alloc]init];
    _woDeButton.frame=CGRectMake(0, 105, self.view.width/3, 30);
    [self.mainScrollView addSubview:_woDeButton];
    _woDeButton.selected=YES;
    _lastBtnArr1=[NSMutableArray array];//保存上一次
    _isGo=NO;
    [_lastBtnArr1 addObject:_woDeButton];
    _woDeButton.tag=360+0;
    [_woDeButton addTarget:self action:@selector(littleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _tongChengButton=[CuXiaoButton buttonWithType:UIButtonTypeCustom];
    _tongChengButton.frame=CGRectMake(self.view.width/3, 105, self.view.width/3, 30);
    [self.mainScrollView addSubview:_tongChengButton];
    _tongChengButton.tag=360+1;
    [_tongChengButton addTarget:self action:@selector(littleBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    
    _quanGuoButton=[CuXiaoButton buttonWithType:UIButtonTypeCustom];
    _quanGuoButton.frame=CGRectMake(self.view.width/3*2, 105, self.view.width/3, 30);
    _quanGuoButton.tag=360+2;
    [self.mainScrollView addSubview:_quanGuoButton];
    [_quanGuoButton addTarget:self action:@selector(littleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_woDeButton setCuXiaoBtnWithTitle:@"我的会员" BackNorImage:@"灰底.png" SelectImage:@"红底.png"];
    [_tongChengButton setCuXiaoBtnWithTitle:@"同城用户" BackNorImage:@"灰底.png" SelectImage:@"红底.png"];
    [_quanGuoButton setCuXiaoBtnWithTitle:@"全国用户" BackNorImage:@"灰底.png" SelectImage:@"红底.png"];

}

-(void)createTopBtn
{
    NSArray *imageArray=@[@"1_03.png",@"1_05.png",@"1_07.png",@"1_09.png"];
    NSArray *titleArray=@[@"会员",@"商品",@"促销",@"活动"];
    
    //创建Btn
    _huiYuanBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _huiYuanBtn.frame=CGRectMake(10+80*0, 13, 60, 60);
    [_huiYuanBtn setImage:[UIImage imageNamed:imageArray[0]] forState:UIControlStateNormal];
    _huiYuanBtn.tag=350+0;
    [_huiYuanBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:_huiYuanBtn];
    _huiYuanBtn.selected=YES;
    _lastBtnArr=[NSMutableArray array];//保存按钮点击
    [_lastBtnArr addObject:_huiYuanBtn];
    
    _shangPinBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _shangPinBtn.frame=CGRectMake(10+80*1, 13, 60, 60);
    [_shangPinBtn setImage:[UIImage imageNamed:imageArray[1]] forState:UIControlStateNormal];
    _shangPinBtn.tag=350+1;
    [_shangPinBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:_shangPinBtn];
    
    _fuWuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _fuWuBtn.frame=CGRectMake(10+80*2, 13, 60, 60);
    [_fuWuBtn setImage:[UIImage imageNamed:imageArray[2]] forState:UIControlStateNormal];
    _fuWuBtn.tag=350+2;
    [_fuWuBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:_fuWuBtn];
    
    _huoDongBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _huoDongBtn.frame=CGRectMake(10+80*3, 13, 60, 60);
    [_huoDongBtn setImage:[UIImage imageNamed:imageArray[3]] forState:UIControlStateNormal];
    _huoDongBtn.tag=350+3;
    [_huoDongBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:_huoDongBtn];
    
    for(int i=0;i<4;i++)
    {
        //创建label
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(80*i ,75, 80, 20)];
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont boldSystemFontOfSize:16];
        label.text=titleArray[i];
        [self.mainScrollView  addSubview:label];
    }
    
    //地图列表切换按钮
    _mapSelectedButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _mapSelectedButton.frame=CGRectMake(275, 150, 30, 30);
    [self.mainScrollView addSubview:_mapSelectedButton];
    [_mapSelectedButton setBackgroundImage:[UIImage imageNamed:@"推广_03.png"] forState:UIControlStateNormal];
    [_mapSelectedButton setBackgroundImage:[UIImage imageNamed:@"推广_05.png"] forState:UIControlStateSelected];
    _mapSelectedButton.selected=YES;
    _lastBtnArr2=[NSMutableArray array];//记录
    [_lastBtnArr2 addObject:_mapSelectedButton];
    _mapSelectedButton.tag=370;
    [_mapSelectedButton addTarget:self action:@selector(qiehuanClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _listSelectdeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _listSelectdeButton.frame=CGRectMake(275, 190, 30, 30);
    [self.mainScrollView addSubview:_listSelectdeButton];
    [_listSelectdeButton setBackgroundImage:[UIImage imageNamed:@"推广_09.png"] forState:UIControlStateNormal];
    [_listSelectdeButton setBackgroundImage:[UIImage imageNamed:@"推广_10.png"] forState:UIControlStateSelected];
    _listSelectdeButton.tag=371;
    [_listSelectdeButton addTarget:self action:@selector(qiehuanClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 大图标点击
-(void)btnClick:(UIButton *)button
{
    UIButton *bb=_lastBtnArr[0];
    if (bb.tag==button.tag) {
        return;
    }
    else
    {
        bb.selected=NO;
        [_lastBtnArr removeObject:bb];
        button.selected=YES;
        [_lastBtnArr addObject:button];
        _isGo=YES;
        [self littleBtnClick:_woDeButton];
    }
    if (button.tag==350) {//会员
        NSLog(@"huiyuan");
        if (_mapSelectedButton.selected) {
            self.mapView.hidden=NO;
            _listSelectdeButton.hidden=NO;
            _mapSelectedButton.hidden=NO;
            _tableView.hidden=YES;

        }
        else{
            _listSelectdeButton.hidden=NO;
            _mapSelectedButton.hidden=NO;
            [_tableView reloadData];
        }
    }
    else if (button.tag==351) {//商品
        NSLog(@"shangpin");
//        if (_tableView.hidden) {
            _tableView.hidden=NO;
            self.mapView.hidden=YES;
            _listSelectdeButton.hidden=YES;
            _mapSelectedButton.hidden=YES;
//        }
        [_tableView reloadData];
    }
    else if (button.tag==352) {//服务
        NSLog(@"fuwu");
//        if (_tableView.hidden) {
            _tableView.hidden=NO;
            self.mapView.hidden=YES;
            _listSelectdeButton.hidden=YES;
            _mapSelectedButton.hidden=YES;
//        }
        [_tableView reloadData];
    }
    else if (button.tag==353) {//活动
        NSLog(@"huodong");
//        if (_tableView.hidden) {
            _tableView.hidden=NO;
            self.mapView.hidden=YES;
            _listSelectdeButton.hidden=YES;
            _mapSelectedButton.hidden=YES;
//        }
        
        [_tableView reloadData];
    }
}
#pragma mark - 小图标点击
//我的
-(void)littleBtnClick:(CuXiaoButton *)btn
{
    if (!_isGo) {
        CuXiaoButton *bb=_lastBtnArr1[0];
        if (bb.tag==btn.tag) {
            return;
        }
        else{
            bb.selected=NO;
            [_lastBtnArr1 removeObject:bb];
            btn.selected=YES;
            [_lastBtnArr1 addObject:btn];
        }

    }
    if (_isGo) {
        CuXiaoButton *bb=_lastBtnArr1[0];
        bb.selected=NO;
        [_lastBtnArr1 removeAllObjects];
        [_lastBtnArr1 addObject:_woDeButton];
        _woDeButton.selected=YES;
        _isGo=NO;
    }
    
    if (btn.tag==360) {//我的
        if (_huiYuanBtn.selected) {
            NSLog(@"我的 会员");
        }
        else if (_shangPinBtn.selected) {
            NSLog(@"我的 商品");
        }
        else if (_fuWuBtn.selected) {
            NSLog(@"我的 服务");
        }
        else if (_huoDongBtn.selected) {
            NSLog(@"我的 活动");
        }
    }
    else if (btn.tag==361) {//同城
        if (_huiYuanBtn.selected) {
            NSLog(@"同城 会员");
        }
        else if (_shangPinBtn.selected) {
            NSLog(@"同城 商品");
        }
        else if (_fuWuBtn.selected) {
            NSLog(@"同城 服务");
        }
        else if (_huoDongBtn.selected) {
            NSLog(@"同城 活动");
        }
    }
    else if (btn.tag==362) {//全国
        if (_huiYuanBtn.selected) {
            NSLog(@"全国 会员");
        }
        else if (_shangPinBtn.selected) {
            NSLog(@"全国 商品");
        }
        else if (_fuWuBtn.selected) {
            NSLog(@"全国 服务");
        }
        else if (_huoDongBtn.selected) {
            NSLog(@"全国 活动");
        }
    }
}

-(void)qiehuanClick:(UIButton *)btn
{
    UIButton *bb=_lastBtnArr2[0];
    if (bb.tag==btn.tag) {
        return;
    }
    bb.selected=NO;
    [_lastBtnArr2 removeAllObjects];
    btn.selected=YES;
    [_lastBtnArr2 addObject:btn];
    if (btn.tag==370) {//地图
        self.mapView.hidden=NO;
        _tableView.hidden=YES;
    }
    else if (btn.tag==371) {//列表
        self.mapView.hidden=YES;
        _tableView.hidden=NO;
        [_tableView reloadData];
    }
}



-(void)createTableView
{
    _tableView=[[UITableView alloc]init];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.frame=CGRectMake(0, 135, 320, 435);
    [self.mainScrollView addSubview:_tableView];
    _tableView.hidden=YES;
    [self setExtraCellLineHidden:_tableView];
}
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
#pragma mark - tableview的数据源方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_shangPinBtn.selected) {
        return 23;
    }
    else if (_fuWuBtn.selected) {
        return 24;
    }
    else if (_huoDongBtn.selected) {
        return 25;
    }
    else if (_huiYuanBtn.selected) {
        return 5;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_shangPinBtn.selected) {
        CuXiaoFirstTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:[CuXiaoFirstTableViewCell myIdentify]];
        if (cell==nil) {
            cell=[[CuXiaoFirstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CuXiaoFirstTableViewCell myIdentify]];
        }
        cell.iconImageView.image=[UIImage imageNamed:@"屏幕快照 2015-07-06 16.16.56.png"];
        cell.nameLabel.text=@"宽松短袖女t恤百搭夏装打底衫韩版条纹大码女装衣服";
        cell.moreLabel.text=[NSString stringWithFormat:@"最近有%@人在浏览",@"35"];
        
        return cell;

    }
    else if (_fuWuBtn.selected) {
        CuxiaoSecondTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:[CuxiaoSecondTableViewCell myIdentify]];
        if (cell==nil) {
            cell=[[CuxiaoSecondTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CuxiaoSecondTableViewCell myIdentify]];
        }
        cell.nameLabel.text=@"家具大甩卖";
        cell.moreLabel.text=@"疯狂减价,全民疯抢";
        return cell;
    }
    else if (_huoDongBtn.selected) {
        CuxiaoFourTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:[CuxiaoFourTableViewCell myIdentify]];
        if (cell==nil) {
            cell=[[CuxiaoFourTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CuxiaoFourTableViewCell myIdentify]];
        }
        cell.nameLabel.text=@"家具特卖活动";
        cell.moreLabel.text=@"疯狂减价，全民疯抢";
        cell.manyPeopleLabel.text=[NSString stringWithFormat:@"%@人已参加",@"28"];
        
        return cell;
    }
    else if (_huiYuanBtn.selected) {
        CuxiaoThirdTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:[CuxiaoThirdTableViewCell myIdentify]];
        if (cell==nil) {
            cell=[[CuxiaoThirdTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CuxiaoThirdTableViewCell myIdentify]];
        }
        cell.iconImageView.image=[UIImage imageNamed:@"屏幕快照 2015-07-06 16.16.56.png"];
        cell.nameLabel.text=@"王小姐";
        cell.moreLabel.text=@"天河区某某网络公司秘书";
        cell.dictanceLabel.text=[NSString stringWithFormat:@"< %@ km",@"12"];
        
        return cell;
    }

    
    return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_huoDongBtn.selected||_fuWuBtn.selected) {
        return 80;
    }
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_shangPinBtn.selected) {//商品
        LookShopViewController *lvc=[[LookShopViewController alloc]init];
        [self.navigationController pushViewController:lvc animated:YES];
    }
    else if (_fuWuBtn.selected) {//促销
        FastSalesViewController *fvc=[[FastSalesViewController alloc]init];
        [self.navigationController pushViewController:fvc animated:YES];
        
    }
    else if (_huoDongBtn.selected) {//活动
        
    }
    else if (_huiYuanBtn.selected) {//会员
        
    }

}

-(void)createBigTwoBtn
{
    NSArray *titleArr=@[@"发送促销信息",@"发送活动信息"];
    NSArray *colorArr=@[ZQColor(79, 132, 17),ZQColor(229, 47, 36)];
    
    for (int i=0; i<2; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(self.view.frame.size.width/2*i, self.view.frame.size.height-50, self.view.frame.size.width/2, 50);
        btn.tag = 300+i;
        [btn addTarget:self action:@selector(selectBotBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:colorArr[i]];
        [self.view addSubview:btn];
    }
}
-(void)selectBotBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 300:
        {
            [self.navigationController pushViewController:[NewpromoInfoVC new] animated:YES];
        }
            break;
        case 301:
        {
            [self.navigationController pushViewController:[NewActivityVC new] animated:YES];
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



@end
