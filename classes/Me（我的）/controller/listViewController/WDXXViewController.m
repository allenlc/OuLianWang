//
//  WDXXViewController.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/23.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "WDXXViewController.h"
#import "FrienMessageCell.h"
#import "FrendMessageTableView.h"
#import "SystemNotification.h"
#import "IndentNotiTableView.h"
#import "BackSingle.h"
#import "OLWTabBarController.h"
#import "ContactVC.h"
#import "CommunityViewController.h"
@interface WDXXViewController ()
{
    CommunityViewController *communtyViewController;
    ContactVC * contactVC;
    UIButton * currentSelectBtn;
    UIButton * currentBotBtn;
    UIImageView * selectView;
    FrendMessageTableView * friendTableView ;
}
@end

@implementation WDXXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.    
    [self  deplyNavigationController1];
//    [self creatFriendMessageTableView];
    [self  creaSelectview];
    [self createBotView];
    
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSms) name:SMSNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSms) name:SMSAlready object:nil];
    
}
-(void)changeSms
{
    BackSingle *singgg=[BackSingle shareInstance];
    
    friendTableView.shumuSms=singgg.manySms;
    
    [friendTableView reloadData];
}
#pragma mark-------配置导航栏

-(void)deplyNavigationController1
{
    self.navigationItem.title=@"消息中心";
    
}

#pragma -mark 创建好友消息tableView
-(void)creatFriendMessageTableView
{
    if (friendTableView==nil) {
        friendTableView  = [FrendMessageTableView sharedManager];
        friendTableView.frame = CGRectMake(0, 114, self.view.width, self.view.height-114-44);
        friendTableView.backgroundColor = ZQColor(232, 232, 232);
        friendTableView.separatorStyle= 0;
        
    }
    [self.view addSubview:friendTableView];
    
}

#pragma -mark 创建系统通知tableView
-(void)creatdSystemNotiTableView
{
    SystemNotification * tableView;
    if (tableView==nil) {
      tableView  = [SystemNotification sharedManager];
        tableView.frame =CGRectMake(0, 114, self.view.width, self.view.height-114-44) ;
        tableView.separatorStyle= 0;
        tableView.backgroundColor = ZQColor(232, 232, 232);
    }
    
    [self.view addSubview:tableView];
    
}
#pragma -mark 创建订单通知tableView
-(void)creatdindentNotiTableView
{
    IndentNotiTableView * tableView ;
    if (tableView==nil) {
        tableView = [IndentNotiTableView sharedManager];
    tableView.frame =CGRectMake(0,114, self.view.width, self.view.height-114-44) ;
    tableView.separatorStyle= 0;
   
    tableView.backgroundColor = ZQColor(232, 232, 232);
    }
    [self.view addSubview:tableView];
    
}
#pragma mark-------创建界面

-(void)creaSelectview
{
    NSArray * arr = @[@"好友消息",@"系统通知",@"订单通知"];
    selectView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 69, self.view.width-10, 40)];
    selectView.layer.cornerRadius = 8;
//    selectView.image = [UIImage imageNamed:@"nav01"];
    
    selectView.userInteractionEnabled = YES;
    [self.view addSubview:selectView];
    for (int i = 0; i<3; i++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame =CGRectMake(selectView.width/3*i+2, 0, selectView.width/3-4, 40);
        btn.tag = 133+i;
        [btn setTitle:arr[i] forState:0];
        [btn setTitleColor:ZQColor(250, 49, 15) forState:0];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
       
        [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [selectView addSubview:btn];
    }
    currentSelectBtn = (UIButton *)[selectView viewWithTag:133];
    currentSelectBtn.selected = YES;
    [self selectBtn:currentSelectBtn];
    

}

-(void)selectBtn:(UIButton *)btn
{
    currentSelectBtn.selected = NO;
    
    currentSelectBtn = btn;
    currentSelectBtn.selected = YES;
    
    switch (btn.tag) {
        case 133:
        {
            selectView.image = [UIImage imageNamed:@"nav01"];
            [self creatFriendMessageTableView];
        }
            break;
        case 134:
        {
            selectView.image = [UIImage imageNamed:@"nav02"];
            [self creatdSystemNotiTableView];
        
        }
            break;
        case 135:
        {
            selectView.image = [UIImage imageNamed:@"nav03"];
            [self creatdindentNotiTableView];
        }
            break;
            
        default:
            break;
    }
    
}

-(void)createBotView
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.height-44, self.view.width, 45)];
    [self.view addSubview:view];
    
    UIImageView * lineBG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 1)];
    lineBG.backgroundColor = ZQColor(164, 196, 210);
    [view addSubview:lineBG];
    
    NSArray * arr = @[@"消息",@"联系人",@"社区"];
    NSArray * normalBG = @[@"message",@"friends",@"community"];
    NSArray * selectBG = @[@"message01",@"friends01",@"community01"];
    view.backgroundColor = ZQColor(255, 255, 255);
    for (int i = 0; i<3; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.size = CGSizeMake(self.view.width/2, 44);
        btn.center = CGPointMake(self.view.width/6*(i*2+1), 22);
        [btn setTitle:arr[i] forState:0];
        [btn setTitleColor:[UIColor grayColor] forState:0];
        [btn setTitleColor:ZQColor(250, 49, 15) forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:normalBG[i]] forState:0];
        [btn setImage:[UIImage imageNamed:selectBG[i]] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(3, btn.width/2-12, 14, 63)];
         [btn setTitleEdgeInsets:UIEdgeInsetsMake(30,-51, 0, 0)];
//        btn.titleLabel.textAlignment = 1;
        [btn addTarget:self action:@selector(selectBotBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 344+i;
        [view addSubview:btn];
    }
    currentBotBtn = (UIButton *)[view viewWithTag:344];
    currentBotBtn.selected = YES;
//    [self selectBtn:currentBotBtn];
}
-(void)selectBotBtn:(UIButton *)sender
{
    currentBotBtn.selected = NO;
    
    currentBotBtn = sender;
    currentBotBtn.selected = YES;
    switch (sender.tag) {
        case 344:
        {
             self.navigationItem.title = @"消息中心";
            contactVC.view.hidden = YES;
            communtyViewController.view.hidden = YES;
        }
            break;
        case 345:
        {
             self.navigationItem.title = @"联系人";
          contactVC.view.hidden = NO;
            if (contactVC==nil) {
                contactVC= [ContactVC new];
                contactVC.view.frame = CGRectMake(0, 64, self.view.width, self.view.height-64-44);
               
                [self addChildViewController:contactVC];
            }
             [self.view addSubview:contactVC.view];
//            NSLog(@"self.view.subviews.count=%d",self.view.subviews.count);

        }
            break;
        case 346:
        {
            self.navigationItem.title = @"社区";
            communtyViewController.view.hidden = NO;
            if (communtyViewController==nil) {
                communtyViewController= [CommunityViewController new];
                communtyViewController.view.frame = CGRectMake(0, 64, self.view.width, self.view.height-64-44);
                
                [self addChildViewController:communtyViewController];
            }
            [self.view addSubview:communtyViewController.view];
        }
            break;
            
        default:
            break;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    OLWTabBarController * vc =(OLWTabBarController *) self.tabBarController;
    vc.zqTabBar.hidden = YES;
}
@end
