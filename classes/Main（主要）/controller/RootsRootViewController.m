//
//  RootsRootViewController.m
//  OuLianWang
//
//  Created by allenariel on 15/7/9.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "RootsRootViewController.h"
#import "AsyncSocket.h"
#import "AsyncUdpSocket.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>
#import "BackSingle.h"
#import "SBJson.h"
#import "LiaoTianModel.h"
#import "MyDatabaseQueue.h"
#import "UUInputFunctionView.h"
#import "MJRefresh.h"
#import "UUMessageCell.h"
#import "ChatModel.h"
#import "UUMessageFrame.h"
#import "UUMessage.h"
#import "OLWTabBarController.h"
#import "MyImagePickerController.h"
#import "OLWNavigationController.h"
#import "RootViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "UIView+LCView.h"
#import "MyAlertView.h"
//
@interface RootsRootViewController ()<AsyncSocketDelegate,SendSms>
@property (nonatomic,retain) NSString *ipadress;
@property (nonatomic,retain) AsyncSocket * asyncSocket;
@property (nonatomic,retain) NSString *prot;

@end

@implementation RootsRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self deplyNavigationController];   
    [self createrootsms];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(becomeDelegate:) name:@"RootViewShow" object:nil];
    
    [self checkUpdata];
}
-(void)becomeDelegate:(NSNotification *)notif
{
    RootViewController *rvc=notif.object;
    rvc.delegate=self;
    
}
-(void)deplyNavigationController
{
    self.navigationController.navigationBar.barTintColor=ZQColor(243,0,0);
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
}

-(void)createrootsms
{
    //申请通知
    
    NSDate *date=[NSDate date];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYMMddmmSS"];
    NSString *dateString=[dateFormatter stringFromDate:date];
    
    [[BackSingle shareInstance] setVipName:dateString];
    //聊天室IP地址115.29.39.99
    self.ipadress=@"115.29.39.99";
    self.prot=@"30000";
    self.asyncSocket=[[AsyncSocket alloc]initWithDelegate:self];
    NSError *err = nil;
    BOOL connState=[self.asyncSocket connectToHost:_ipadress onPort:[_prot intValue] error:&err];
    
    if(!connState)
    {
        NSLog(@"Error: %@", err);
    }else{
        NSLog(@"连接成功");
        NSLog(@"连接服务器：%@ 成功",_ipadress);
    }

}

-(void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket
{
    NSLog(@"读取服务器获取的数据");
    self.asyncSocket=newSocket;
}

//已经链接到主机
-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
    NSLog(@"已经链接到：%@",host);
    //    调用读取数据的方法 timeout 超时时间
    [self.asyncSocket readDataWithTimeout:-1 tag:0];
}

//已经读到数据 此方法不会自动调用需要执行一下获取数据的方法才能调用
-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{

    NSString *info1 = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    SBJsonParser *parser=[[SBJsonParser alloc]init];
    NSDictionary *dict=[parser objectWithString:info1];
    if (dict[@"content"]==nil) {
        return;
    }
    BackSingle *single=[BackSingle shareInstance];
    LiaoTianModel *model=[[LiaoTianModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    
    if ([dict[@"userID"] isEqualToString:single.vipName])
        model.from=@"0";//自己呃
    else
        model.from=@"1";//别人
    OLWNavigationController *olNav=self.tabBarController.viewControllers[4];
    
    //------------
    for(id vc in olNav.viewControllers)
    {
        if ([vc isKindOfClass:[RootViewController class]]) {
            model.isRead=@"1";//已经看了
            MyDatabaseQueue *queue=[MyDatabaseQueue shareInstance];
            [queue addLiaotianModel:model];
            [(RootViewController *)vc reloadNewSms];
            if ([model.from isEqualToString:@"1"]) {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                AudioServicesPlaySystemSound(1007);
            }
        }
    }
    
    if (![model.isRead isEqualToString:@"1"]) {
        model.isRead=@"0";//没看
        MyDatabaseQueue *queue=[MyDatabaseQueue shareInstance];
        [queue addLiaotianModel:model];
        BackSingle *singleback=[BackSingle shareInstance];
        singleback.manySms++;
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        AudioServicesPlaySystemSound(1007);
        //发送未接通知
        [[NSNotificationCenter defaultCenter]postNotificationName:SMSNotification object:self];
        //改变桌面的图标
        [[UIApplication sharedApplication]setApplicationIconBadgeNumber:single.manySms];
        if (singleback.isBack) {
            [self addLocalNotificationWithText:dict[@"content"] fromWho:dict[@"userID"]];
            //到时候改为userName
        }
    }
    
    [self.asyncSocket readDataWithTimeout:-1 tag:0];
    
}



-(void)socket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"%@",[NSString stringWithFormat:@"已经连接到:%@",host]);
    [self.asyncSocket readDataWithTimeout:-1 tag:0];
}

- (void)socketDidDisconnect:(AsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"socket did is disconnect:%@",err);
}
-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"数据传输完成！");
}

//读取服务器获取的数据
-(void)socket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"读取服务器获取的数据");
    NSString *newMessage = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",[NSString stringWithFormat:@"服务器：%@:%@",sock.connectedHost,newMessage]);
    [self.asyncSocket readDataWithTimeout:-1 tag:0];
    
}
#pragma mark - 发送sms



-(void)sendSmsWith:(NSString *)string
{
    
    //发送
    [self.asyncSocket writeData:[[NSString stringWithFormat:@"%@\r\n",string] dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];

    [self.asyncSocket readDataWithTimeout:-1 tag:0];
    
}

#pragma mark 添加本地通知

-(void)addLocalNotificationWithText:(NSString *)text fromWho:(NSString *)name
{
    //定义本地通知对象
    UILocalNotification *notification=[[UILocalNotification alloc]init];
    //设置调用时间
    notification.fireDate=[NSDate dateWithTimeIntervalSinceNow:3.0];//通知触发的时间，10s以后
    notification.repeatInterval=0;//通知重复次数
    //notification.repeatCalendar=[NSCalendar currentCalendar];//当前日历，使用前最好设置时区等信息以便能够自动同步时间
    
    //设置通知属性
    notification.alertBody=[NSString stringWithFormat:@"%@:%@",name,text]; //通知主体
//    notification.applicationIconBadgeNumber=[[BackSingle shareInstance]manySms];//应用程序图标右上角显示的消息数
    notification.alertAction=@"打开应用"; //待机界面的滑动动作提示
    notification.alertLaunchImage=@"Default";//通过点击通知打开应用时的启动图片,这里使用程序启动图片
    notification.soundName=UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
    
    
    //设置用户信息
    //    notification.userInfo=@{@"id":@1,@"user":@"Kenshin Cui"};//绑定到通知上的其他附加信息
    
    //调用通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
}

#pragma mark 移除本地通知，在不需要此通知时记得移除
-(void)removeNotification{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

#pragma mark - 查看更新版本
-(void)checkUpdata
{
    [self startDownloadData];
}

-(void)startDownloadData
{
    NSString *urlString=[NSString stringWithFormat:UPDATA_URL];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        

        //获取版本号
        NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
        
        NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
        NSLog(@"%@",currentVersion);
        if ([currentVersion isEqualToString:dic[@"list"][@"version"]]){
            return ;
            
        }
        
        NSString *message=[NSString stringWithFormat:@"我连网%@版本",dic[@"list"][@"version"]];

        UIView *blackView=[[UIView alloc]initWithFrame:self.view.frame];
        blackView.backgroundColor=[UIColor blackColor];
        blackView.alpha=0.5;
        [self.view.window addSubview:blackView];
        
        float alww=260;
        if (self.view.frame.size.width==375) {
            alww=220;
        }
        float alyy=heightEx(150);
        float alxx=(self.view.frame.size.width-alww)/2;
        UIView *alertView=[[UIAlertView alloc]initWithFrame:CGRectMake(alxx, alyy, alww, 200)];
        alertView.backgroundColor=[UIColor whiteColor];
        alertView.layer.cornerRadius=3;
        alertView.alpha=1;
        [alertView addImageViewWithFrame:CGRectMake(65, 15, 20, 20) image:@"prompt.png"];
        UILabel *ll=[alertView addLabelWithFrame:CGRectMake(10, 10, alertView.frame.size.width-20, 30) text:@"更新提示"];
        ll.textAlignment=NSTextAlignmentCenter;
        ll.textColor=ZQColor(65, 171, 0);
        
        [alertView addImageViewWithFrame:CGRectMake(10, 40, alertView.frame.size.width-20, 3) image:@"line.png"];
        
        UILabel *nameLabel=[alertView addLabelWithFrame:CGRectMake(10, 45, alertView.frame.size.width-20, 30) text:message];
        nameLabel.textAlignment=NSTextAlignmentCenter;
        nameLabel.textColor=ZQColor(65, 171, 0);
        nameLabel.font=[UIFont systemFontOfSize:16];
        UILabel *ggLa=[alertView addLabelWithFrame:CGRectMake(10, 75, 100, 20) text:@"更新内容"];
        ggLa.font=[UIFont systemFontOfSize:15];


        UIButton *btn1=[alertView addImageButtonWithFrame:CGRectMake(20, alertView.frame.size.height-50, (alertView.frame.size.width-60)/2, 40) title:nil image:@"update.png" action:^(UIButton *button) {
            [alertView removeFromSuperview];
            [blackView removeFromSuperview];
            NSLog(@"%@",dic[@"list"][@"file_path"]);
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:dic[@"list"][@"file_path"]]];

            
        }];
        [alertView addImageButtonWithFrame:CGRectMake(40+btn1.frame.size.width, alertView.frame.size.height-50, (alertView.frame.size.width-60)/2, 40)  title:nil image:@"cancel.png" action:^(UIButton *button) {
            [alertView removeFromSuperview];
            [blackView removeFromSuperview];
        }];

        

        [self.view.window addSubview:alertView];

       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",[error description]);
    }];
}

- (void)didReceiveMemoryWarning {

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
