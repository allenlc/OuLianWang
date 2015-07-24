//
//  ErSaoViewController.m
//  OuLianWang
//
//  Created by allenariel on 15/7/3.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//
#import "ErSaoViewController.h"
#import "OLWTabBarController.h"
#import "ZBarSDK.h"
#import "AFNetworking.h"
#import "CustomTabBar.h"

@interface ErSaoViewController ()<ZBarReaderViewDelegate>
{
    NSString *ErWeiUrl;
    NSString *HaoYouUrl;
    NSString  *strID;
}
@property(nonatomic,strong)ZBarReaderView *readerView;
@property(nonatomic,strong)UIImageView * redLine;

@end

@implementation ErSaoViewController
-(void)viewWillAppear:(BOOL)animated

{
    
    [self  downloaddata];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self  createSao];

    UIImageView *topView=[[UIImageView alloc]initWithFrame:CGRectMakeEx(0, 0, 320, 80)];
    topView.image=[UIImage imageNamed:@"二维码_上部.png"];
    [self.view addSubview:topView];
    //
    float wi= widthEx(200);
    float xxx=(self.view.frame.size.width-wi)/2;
    float yyy=heightEx(35);
    
    UIImageView *titleView=[[UIImageView alloc]initWithFrame:CGRectMake(xxx, yyy, wi, 25)];
    titleView.image=[UIImage imageNamed:@"二维码_文字_欢迎使用 - 我连APP.png"];
    [topView addSubview:titleView];
    //
    //=========
    UIImageView *bottomView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 568-140, self.view.frame.size.width, 140)];
    bottomView.image=[UIImage imageNamed:@"二维码_下部.png"];
    [self.view addSubview:bottomView];
    bottomView.userInteractionEnabled=YES;
    // 设置跳过按钮
    float tgww=widthEx(160);
    float tgxx=(self.view.width-tgww)/2;
    UIButton * skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    skipBtn.frame=CGRectMake(tgxx, 75, tgww, 30);
    [skipBtn setTitle:@"跳过进入主页" forState:UIControlStateNormal];
    skipBtn.titleLabel.font =[UIFont boldSystemFontOfSize:16];
    skipBtn.clipsToBounds=YES;
    skipBtn.titleLabel.textAlignment=NSTextAlignmentCenter;

    [skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [skipBtn addTarget:self action:@selector(skip) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:skipBtn];
    //设置
    float szww=widthEx(130);
    float szhh=heightEx(20);
    float szxx=(self.view.width-szww)/2;
    UIImageView *myView=[[UIImageView alloc]initWithFrame:CGRectMake(szxx, 30, szww, szhh)];
    myView.image=[UIImage imageNamed:@"个性设置-按钮.png"];
    [bottomView addSubview:myView];
    
}



-(void)skip
{
    // 显示主控制器（OLWTabBarController）
//    OLWTabBarController *vc = [[OLWTabBarController alloc] init];
//    // 切换控制器
//    vc.selectedViewController = olwTabBarController.viewControllers[2];

    OLWTabBarController * olwTabBarController = [[OLWTabBarController alloc]init];
    olwTabBarController.selectedViewController = olwTabBarController.viewControllers[0];
    olwTabBarController.currentSelectedIndex=0;
    ((UIButton *)olwTabBarController.buttons[olwTabBarController.currentSelectedIndex]).selected = YES;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = olwTabBarController;
    
}

-(void)createSao
{
    self.readerView=[[ZBarReaderView alloc]init];
    _readerView.trackingColor=[UIColor yellowColor];
    _readerView.readerDelegate=self;
    _readerView.frame=self.view.bounds;
    //屏幕大小

    //可扫描区域
    CGRect scanCropRect = CGRectMakeEx(70, 80+80, 180, 180);
    _readerView.scanCrop=[self getScanCrop:scanCropRect readerViewBounds:_readerView.bounds];
    [self.view addSubview:_readerView];
    [_readerView start];
    //滚动红线
    self.redLine=[[UIImageView alloc]initWithFrame:CGRectMake(70, 80+80, 180, 3)];
    self.redLine.image=[UIImage imageNamed:@"smx.png"];
    [self.view addSubview:self.redLine];
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(lineAnimation) userInfo:nil repeats:YES];
    [UIView animateWithDuration:2.0 animations:^{
        self.redLine.frame=CGRectMake(70, 80+80+180, 180, 3);
    }];
    //布局
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"smk2.png"]];
    imageView.frame=CGRectMake(70, 100+60, 180, 180);
    [self.view addSubview:imageView];
    
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 80, 320, 80)];
    view1.backgroundColor=ZQColorRGBA(62, 12, 107, 0.7);
    [self.view addSubview:view1];

    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, 80+80, 70, 180)];
    view2.backgroundColor=ZQColorRGBA(62, 12, 107, 0.7);
    [self.view addSubview:view2];
    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(250, 80+80, 70, 180)];
    view3.backgroundColor=ZQColorRGBA(62, 12, 107, 0.7);
    [self.view addSubview:view3];
    UIView *view4=[[UIView alloc]initWithFrame:CGRectMake(0, 80+80+180, 320, 100)];
    view4.backgroundColor=ZQColorRGBA(62, 12, 107, 0.7);
    [self.view addSubview:view4];
    UILabel *la=[[UILabel alloc]initWithFrame:CGRectMakeEx(25, 30, 270, 30)];
    la.font=[UIFont systemFontOfSize:18];
    la.textColor=[UIColor whiteColor];
    la.text=@"请方框对准IPC的二维码进行扫描";
    [view4 addSubview:la];

}
//设置可扫描区的scanCrop的方法
- (CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)rvBounds
{
    CGFloat x,y,width,height;

    


    x = rect.origin.y / rvBounds.size.height;
    
    y = 1 - (rect.origin.x + rect.size.width) / rvBounds.size.width;
    
    width = (rect.origin.y + rect.size.height) / rvBounds.size.height;
    
    height = 1 - rect.origin.x / rvBounds.size.width;
    
    return CGRectMake(x, y, width, height);
}

#pragma mark - 代理方法

//开始与停止
//-(void)viewDidAppear:(BOOL)animated
//{
//    [self.readerView start];
//}

-(void)viewDidDisappear:(BOOL)animated
{
    [self.readerView stop];
}
-(void)downloaddata
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    [manager GET:@"http://weixin.hsmja.com/wolian/homenav.php?action=app_open_default&openMode=qr_code" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic=responseObject;
        NSDictionary *dictt=dic[@"base_address"];
        
        ErWeiUrl=dictt[@"store_url"];
        HaoYouUrl=dictt[@"addfriend_url"];
        
        NSLog(@"!!!!!!!%@",ErWeiUrl);
        NSLog(@"@@@@@%@",HaoYouUrl);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

#pragma mark 处理扫描结果
- (void) readerView: (ZBarReaderView*) view
     didReadSymbols: (ZBarSymbolSet*) syms
          fromImage: (UIImage*) img
{
    ZBarSymbol *sym =nil;
    for(sym in syms)
        break;
    
    
    NSString *string=sym.data;
    NSRange rang=[string  rangeOfString:ErWeiUrl];
    NSLog(@"-------%d",rang.length);
    
    if (rang.location==NSNotFound)
    {
        UIAlertView *alview=[[UIAlertView alloc]initWithTitle:@"扫描二维码错误" message:@"请重新扫描" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alview  show];
        return;
    }
    strID=[string  substringWithRange:NSMakeRange(rang.length, string.length-ErWeiUrl.length)];
    
    //NSLog(@"333333333%@",strID);
    
    //  归档保存
    [[NSUserDefaults  standardUserDefaults]setObject:strID forKey:UseDipuIDKey];
    
    
    NSString *shengStr=[string  substringWithRange:NSMakeRange(0, ErWeiUrl.length)];
    
    if ([shengStr  isEqualToString:ErWeiUrl])
    {
        
        [self skip];
        
    }
    else
    {
        UIAlertView *alview=[[UIAlertView alloc]initWithTitle:@"扫描二维码错误" message:@"请扫描正确的二维码" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alview  show];
    }
}

#pragma mark -  红线滑动
#pragma mark 初始化扫描界面
-(void)lineAnimation
{
    self.redLine.frame=CGRectMake(70, 80+80, 180, 3);
    [UIView animateWithDuration:2.0 animations:^{
        self.redLine.frame=CGRectMake(70, 80+80+180, 180, 3);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
