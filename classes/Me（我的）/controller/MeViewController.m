//
//  MeViewController.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/13.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "MeViewController.h"
#import "ListBtn.h"
#import "EnrollViewController.h"
#import "LogInViewController.h"
#import "IntegralViewController.h"
#import "BalanceViewController.h"
#import "CollectViewController.h"
#import "FriendViewController.h"
#import "PersonMessageViewController.h"
#import "WDDDViewController.h"
#import "WDDPViewController.h"
#import "GWCViewController.h"
#import "WDXXViewController.h"
#import "GRXCViewController.h"
#import "WDHJViewController.h"
#import "HYCZViewController.h"
#import "XTSZViewController.h"
#import "MyExpressVController.h"

#import "ZJScreenAdaptation.h"


#define margin 27
@interface MeViewController ()

{
    UIScrollView *scroller;

}

@property(nonatomic,strong)NSArray * meArr;


@end

@implementation MeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationItem];
    myBtnArr = [NSMutableArray array];
    [self creatView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    MyAccount *account = [MyAccountTool account];
    if (account) {
        [iconView setImageWithURL:[NSURL URLWithString:account.photo]];
        logInBtn.userInteractionEnabled = NO;
        [logInBtn setTitle:account.name forState:0];
        NSArray *numberArr = @[account.points,account.remain,account.jf,account.collect,account.friends];
        for (int i = 0 ; i< myBtnArr.count; i++) {
            ListBtn * btn = myBtnArr[i];
            btn.numberLabel.text =numberArr[i];
        }
    }
    
}

#pragma mark - 创建视图
-(void)creatView
{
    
    scroller=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320,self.view.bounds.size.height)];
    
    if (self.view.bounds.size.height==480) {
        scroller.contentSize=CGSizeMake(320, 440);
    }
    if (self.view.bounds.size.height==568) {
        scroller.contentSize=CGSizeMake(320,460);
    }
    if (self.view.bounds.size.height==667) {
        scroller.contentSize=CGSizeMake(320, 480);
    }
    if (self.view.bounds.size.height==736) {
        scroller.contentSize=CGSizeMake(320, 480);
    }
    
    
    scroller.showsVerticalScrollIndicator=NO;
    [self.view  addSubview:scroller];
    
    self.view.backgroundColor = ZQColor(211, 212, 214);
    self.navigationItem.title = @"个人中心";
    
    //顶部视图
    UIImageView *  topImg = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, self.view.width, self.view.height*0.2)];
    topImg.image = [UIImage imageNamed:@"头像底图"];
    topImg.userInteractionEnabled = YES;
    [scroller addSubview:topImg];
    
    //头像
    UIImageView * iconBound = [[UIImageView alloc]init];
    iconBound.userInteractionEnabled = YES;
    iconBound.size = CGSizeMake(90, 90);
    iconBound.center = CGPointMake(topImg.width * 0.5, topImg.height * 0.4);
    iconBound.image = [UIImage imageNamed:@"transparent"];
//    iconBound.layer.cornerRadius = iconBound.width/2;

    [topImg addSubview:iconBound];
    
    iconView = [[UIImageView alloc]init];
    iconView.userInteractionEnabled = YES;
    iconView.size =CGSizeMake(65, 65);
    iconView.center = CGPointMake(iconBound.width/2, iconBound.height/2);
    iconView.image=[UIImage imageNamed:@"头像"];
    
    iconView.layer.masksToBounds = YES;
//    iconView.layer.cornerRadius = iconView.width/2;
    [iconBound addSubview:iconView];
    UIButton *iconBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    iconBtn.frame = iconView.frame;
    [iconBound addSubview:iconBtn];
    [iconBtn addTarget:self action:@selector(personMessage) forControlEvents:UIControlEventTouchUpInside];
    
    
    //    登陆？注册
    logInBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    logInBtn.size =CGSizeMake(self.view.width * 0.25, 30);
    logInBtn.center = CGPointMake(topImg.width * 0.5, topImg.height * 0.88);
    [logInBtn setTitle:@"登陆/注册" forState:0];
    logInBtn.titleLabel.font = [UIFont systemFontOfSize:16 ];
    logInBtn.tintColor = [UIColor whiteColor];
    [logInBtn addTarget:self action:@selector(logIn:) forControlEvents:UIControlEventTouchUpInside];
    [topImg addSubview:logInBtn];
    
    
    UIImageView * bgImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"navbg"]];
    bgImgView.frame = CGRectMake(0, CGRectGetMaxY(topImg.frame), self.view.width, 60);
    [scroller addSubview:bgImgView];
    
    NSArray * titlearr = @[@"代金券",@"余额",@"积分",@"收藏",@"好友"];
    NSArray * arr = @[@"voucher",@"balance",@"integral",@"collection",@"friends"];
    NSArray * numberArr = @[@"0",@"0",@"0",@"0",@"0"];
    for (int i = 0; i<5; i++) {
        ListBtn * listView = [[ListBtn alloc]initWithFrame:CGRectMake(self.view.width/5*i, CGRectGetMaxY(topImg.frame), self.view.width/5-2, 60)];
        listView.numberLabel.text =numberArr[i];
        listView.numberLabel.textAlignment = 1;
        listView.numberLabel.textColor = ZQColor(100, 100, 100);
        listView.numberLabel.font = [UIFont systemFontOfSize:14];
        
        listView.titleLabel.text = titlearr[i];
        
        listView.tag = i+100;
        listView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(meSet:)];
        [listView addGestureRecognizer:tapGestureRecognizer];
        listView.imgView.image = [UIImage imageNamed:arr[i]];
        [myBtnArr addObject:listView];
        [scroller addSubview:listView];
    }
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topImg.frame)+70, self.view.width, self.view.height-CGRectGetMaxY(topImg.frame)-100+44)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [scroller addSubview:bottomView];
    
    
    NSArray *meArr = @[@"我的店铺",@"我的订单",@"购物车",@"我的我信",@"个人相册",@"我的推荐",@"会员充值",@"我的快递",@"系统设置"];
    NSArray * picArr = @[@"我的店铺",@"我的订单",@"购物车",@"我的消息",@"个人相册",@"我的皇家",@"我的会员",@"我的快递",@"系统设置"];
    int x = 0;
    for (int j = 0; j<3; j++) {
        for (int i = 0; i<3; i++) {
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(margin+((self.view.width-margin*6)/3+2*margin)*i, 10+((self.view.width-margin*6)/3+30)*j, (self.view.width-margin*6)/3, (self.view.width-margin*6)/3)];
            [bottomView addSubview:btn];
            btn.tag = x;
            [btn setImage:[UIImage imageNamed:picArr[x]] forState:0];
            [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
            UILabel * l1 = [[UILabel alloc]initWithFrame:CGRectMake(margin+((self.view.width-margin*6)/3+2*margin)*i, 10+(self.view.width-margin*6)/3+((self.view.width-margin*6)/3+30)*j, btn.width, 20)];
            l1.font = [UIFont systemFontOfSize:13];
            l1.text = meArr[x];
            l1.textAlignment = 1;
            [bottomView addSubview:l1];
            
            x++;
            
        }
        
    }

}
-(void)selectBtn:(UIButton *)sender
{
    MyAccount * account = [MyAccountTool account];
    if (!account) {
        [self.navigationController pushViewController:[LogInViewController new] animated:YES];
        return;
    }
    switch (sender.tag) {
        case 0:
        {
            WDDPViewController * VC = [WDDPViewController new];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 1:
        {
            WDDDViewController * VC = [WDDDViewController new];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 2:
        {
            GWCViewController * VC = [GWCViewController new];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 3:
        {
            WDXXViewController * VC = [WDXXViewController new];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 4:
        {
            GRXCViewController * VC = [GRXCViewController new];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 5:
        {
            WDHJViewController * VC = [WDHJViewController new];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 6:
        {
            HYCZViewController * VC = [HYCZViewController new];
            [self.navigationController pushViewController:VC animated:YES];
            
        }
            break;
        case 7:
        {
            MyExpressVController * VC = [MyExpressVController new];
            [self.navigationController pushViewController:VC animated:YES];
//
        }
            break;
        case 8:
        {
            XTSZViewController * VC = [XTSZViewController new];
            [self.navigationController pushViewController:VC animated:YES];
            
        }
            break;
            
        default:
            break;
    }
}
-(void)personMessage
{
    MyAccount * account = [MyAccountTool account];
    if (!account) {
        [self.navigationController pushViewController:[LogInViewController new] animated:YES];
        return;
    }

    PersonMessageViewController * personMessageVC = [PersonMessageViewController new];
    [self.navigationController pushViewController:personMessageVC animated:YES];
}

#pragma mark -懒加载
-(NSArray *)meArr
{
    if (_meArr == nil) {
        _meArr = [NSArray array];
        
    }
    return _meArr;
}

//设置我的信息功能
-(void)meSet:(UITapGestureRecognizer *)tapGrn
{
    // 底下是刪除手势的方法
    switch (tapGrn.view.tag) {
        case 100:
        {
           
            
        }
            break;
        case 101:
        {
            BalanceViewController * VC = [BalanceViewController new];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 102:
        {
            IntegralViewController * VC = [IntegralViewController new];
            self.tabBarController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;

        case 103:
        {
            CollectViewController * VC = [CollectViewController new];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 104:
        {
            FriendViewController * VC = [FriendViewController new];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
            
        default:
            break;
    }
    [self.view removeGestureRecognizer:tapGrn];
}
-(void)logIn:(UIButton *)logBtn
{
    LogInViewController * logInVC = [LogInViewController new];
    [self.navigationController pushViewController:logInVC animated:YES];
    
}


//设置导航按钮
-(void)setNavigationItem
{
    UIButton *fabubutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [fabubutton  setImage:[UIImage imageNamed:@"gerenzhongxinbianji.png"] forState:UIControlStateNormal];
    fabubutton.frame=CGRectMake(0, 0, 20, 25);
    UIBarButtonItem *rightbutton=[[UIBarButtonItem alloc]initWithCustomView:fabubutton];
    self.navigationItem.rightBarButtonItem=rightbutton;
}

-(void)add
{
    
}




@end
