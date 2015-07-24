//
//  RootViewController.m
//  UUChatTableView
//
//  Created by shake on 15/1/4.
//  Copyright (c) 2015年 uyiuyao. All rights reserved.
//

#import "RootViewController.h"
#import "UUInputFunctionView.h"
#import "MJRefresh.h"
#import "UUMessageCell.h"
#import "ChatModel.h"
#import "UUMessageFrame.h"
#import "UUMessage.h"
#import "OLWTabBarController.h"
#import "MyImagePickerController.h"
//==
#import "AsyncSocket.h"
#import "AsyncUdpSocket.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>
#import "BackSingle.h"
#import "SBJson.h"
#import <AudioToolbox/AudioToolbox.h>
#import "MyDatabaseQueue.h"
#import "LiaoTianModel.h"
#import <AVFoundation/AVFoundation.h>
#import "OLWNavigationController.h"
#import "SameCityViewController.h"
#import "MJRefreshHeaderView.h"

@interface RootViewController ()<UUInputFunctionViewDelegate,UUMessageCellDelegate,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,AsyncSocketDelegate>


@property (strong, nonatomic) MJRefreshHeaderView *head;
@property (strong, nonatomic) ChatModel *chatModel;

@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
//===
@property (nonatomic,retain) NSString *ipadress;
@property (nonatomic,retain) AsyncSocket * asyncSocket;
@property (nonatomic,retain) NSString *prot;

@property (nonatomic,retain) UITextField *content;
@property (nonatomic,retain) UITextField *chattext;
@property (nonatomic,retain)  UIButton *sure;
@property (strong, nonatomic) NSMutableArray *allNotSmsArray;
@property (nonatomic,strong) AVAudioPlayer *player;

//===
@end

@implementation RootViewController{
    UUInputFunctionView *IFView;
}
-(NSMutableArray *)allNotSmsArray
{
    if (_allNotSmsArray==nil) {
        _allNotSmsArray=[NSMutableArray array];
    }
    return _allNotSmsArray;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ((OLWTabBarController *) self.tabBarController).zqTabBar.hidden = YES;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    ((OLWTabBarController *) self.tabBarController).zqTabBar.hidden = YES;
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    //申请通知
    float sysVersion=[[UIDevice currentDevice]systemVersion].floatValue;
    if (sysVersion>=8.0) {
        UIUserNotificationType type=UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
        UIUserNotificationSettings *setting=[UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication]registerUserNotificationSettings:setting];
    }
    
    [self initBar];
    [self addRefreshViews];
    [self loadBaseViewsAndData];
    [self deplyNavigationController];
    [self tableViewScrollToBottom];

    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"RootViewShow" object:self];
    
    BackSingle *singggg=[BackSingle shareInstance];
    singggg.manySms=0;
    [[NSNotificationCenter defaultCenter]postNotificationName:SMSAlready object:self];
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:singggg.manySms];

    if (singggg.isFirst) {
        IFView.myBlock(@"begin");
        singggg.isFirst=NO;
    }
}

-(void)reloadNewSms
{
    [self loadDatabase];
    [self tableViewScrollToBottom];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //add notification
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tableViewScrollToBottom) name:UIKeyboardDidShowNotification object:nil];
}


- (void)initBar
{
    self.navigationItem.title = @"我连网群聊室";
}

- (void)addRefreshViews
{
    __weak typeof(self) weakSelf = self;
    
    //load more
    int pageNum = 3;
    
    _head = [MJRefreshHeaderView header];
    [self.chatTableView addHeaderWithCallback:^{
        [weakSelf.chatModel addRandomItemsToDataSource:pageNum];
        
        if (weakSelf.chatModel.dataSource.count > pageNum) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:pageNum inSection:0];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.chatTableView reloadData];
                [weakSelf.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            });
        }
        [weakSelf.head endRefreshing];
    }];
//    _head.scrollView = self.chatTableView;
//    _head.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
//        
//        [weakSelf.chatModel addRandomItemsToDataSource:pageNum];
//        
//        if (weakSelf.chatModel.dataSource.count > pageNum) {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:pageNum inSection:0];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [weakSelf.chatTableView reloadData];
//                [weakSelf.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
//            });
//        }
//        [weakSelf.head endRefreshing];
//    };
}

#pragma mark - 初始化
- (void)loadBaseViewsAndData
{
    self.chatModel = [[ChatModel alloc]init];
    self.chatModel.isGroupChat = NO;
    [self.chatModel populateRandomDataSource];
    //插入数据-------
    MyDatabaseQueue *quee=[MyDatabaseQueue shareInstance];
    NSArray *arr=[quee getAllLiaotian];

    [self.chatModel addItemsFromDatabaseArray:arr];
    [_chatTableView reloadData];
    //====
    IFView = [[UUInputFunctionView alloc]initWithSuperVC:self];
    IFView.delegate = self;
    [self.view addSubview:IFView];
    
#pragma mark -  发送触发block---------------------------
    __weak typeof (self)weakSelf=self;
    [IFView setMyBlock:^(NSString * string) {
        //send数据传输
        //==拼成字符串 userID 暂时为时间串
        NSDate *date=[NSDate date];
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"YY-MM-dd mm:SS"];
        NSString *dateString=[dateFormatter stringFromDate:date];

        BackSingle *single=[BackSingle shareInstance];
        
        NSDictionary *dataDictionary= [NSDictionary dictionaryWithObjectsAndKeys:single.vipName,@"userID",
                                       @"name?",@"userName",
                                       string,@"content",
                                       dateString,@"sendTime",
                                       @"http//???",@"headImg",
                                       @"text",@"msgType",nil];
        
        
        SBJsonWriter *writer = [[SBJsonWriter alloc] init];
        
        NSString *jasonString = [writer stringWithObject:dataDictionary];
        NSLog(@"点击发送：%@",jasonString);
        
        [weakSelf.delegate sendSmsWith:jasonString];
        IFView.TextViewInput.text = @"";


        
    }];
    //--------------------
//    [self.chatTableView reloadData];
//    [self tableViewScrollToBottom];
}
#pragma mark - 加载数据库数据
-(void)loadDatabase
{
    MyDatabaseQueue *quee=[MyDatabaseQueue shareInstance];
    NSArray *arr=[quee getAllLiaotian];
    [self.chatModel.dataSource removeAllObjects];
    [self.chatModel addItemsFromDatabaseArray:arr];
    [_chatTableView reloadData];
}


-(void)keyboardChange:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    //adjust ChatTableView's height
    if (notification.name == UIKeyboardWillShowNotification) {
        self.bottomConstraint.constant = keyboardEndFrame.size.height+40;
    }else{
        self.bottomConstraint.constant = 40;
    }
    
    [self.view layoutIfNeeded];
    
    //adjust UUInputFunctionView's originPoint
    CGRect newFrame = IFView.frame;
    newFrame.origin.y = keyboardEndFrame.origin.y - newFrame.size.height;
    IFView.frame = newFrame;
    
    [UIView commitAnimations];
    
}

//tableView Scroll to bottom
- (void)tableViewScrollToBottom
{
    if (self.chatModel.dataSource.count==0)
        return;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.chatModel.dataSource.count-1 inSection:0];
    [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}


#pragma mark - InputFunctionViewDelegate
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendMessage:(NSString *)message
{
    NSDictionary *dic = @{@"strContent": message,
                          @"type": @(UUMessageTypeText)};
    funcView.TextViewInput.text = @"";
    [funcView changeSendBtnWithPhoto:YES];
    [self dealTheFunctionData:dic];
}

- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendPicture:(UIImage *)image
{
    NSDictionary *dic = @{@"picture": image,
                          @"type": @(UUMessageTypePicture)};
    [self dealTheFunctionData:dic];
}

- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendVoice:(NSData *)voice time:(NSInteger)second
{
    NSDictionary *dic = @{@"voice": voice,
                          @"strVoiceTime": [NSString stringWithFormat:@"%d",(int)second],
                          @"type": @(UUMessageTypeVoice)};
    [self dealTheFunctionData:dic];
}

- (void)dealTheFunctionData:(NSDictionary *)dic
{
    [self.chatModel addSpecifiedItem:dic];
    [self.chatTableView reloadData];
    [self tableViewScrollToBottom];
}

#pragma mark - tableView delegate & datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.chatModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UUMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (cell == nil) {
        cell = [[UUMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
        cell.delegate = self;
    }
    [cell setMessageFrame:self.chatModel.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.chatModel.dataSource[indexPath.row] cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - cellDelegate
- (void)headImageDidClick:(UUMessageCell *)cell userId:(NSString *)userId{
    // headIamgeIcon is clicked
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:cell.messageFrame.message.strName message:@"headImage clicked" delegate:nil cancelButtonTitle:@"sure" otherButtonTitles:nil];
    [alert show];
}


#pragma mark - 配置导航栏
-(void)deplyNavigationController
{
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor=ZQColor(243,0,0);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIButton *diqubutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [diqubutton  setImage:[UIImage imageNamed:@"返回箭头.png"] forState:UIControlStateNormal];
    [diqubutton  addTarget:self action:@selector(diquButtonClick) forControlEvents:UIControlEventTouchUpInside];
    diqubutton.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    diqubutton.frame=CGRectMake(0, 0,20,20);
    UIBarButtonItem *leftbutton=[[UIBarButtonItem alloc]initWithCustomView:diqubutton];
    
    // 调整 leftBarButtonItem 在 iOS7 下面的位置
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0))
        
    {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                       target:nil action:nil];
        negativeSpacer.width = -10;//这个数值可以根据情况自由变化
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftbutton];
    }
    else
        
        self.navigationItem.leftBarButtonItem = leftbutton;
    
    self.tabBarController.tabBar.hidden=YES;
}
-(void)diquButtonClick
{
    [self.navigationController  popViewControllerAnimated:YES];
    
}



@end
