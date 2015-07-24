//
//  ScanIndentNumber.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/6.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "ScanIndentNumber.h"
#import "OLWTabBarController.h"
#import "GUAAlertView.h"
#import "ZBarSDK.h"
@interface ScanIndentNumber ()<ZBarReaderViewDelegate>
@property(nonatomic,strong)ZBarReaderView *readerView;
@property(nonatomic,strong)UIImageView * redLine;
@property (strong, nonatomic)UITextView *scanResult;
@end

@implementation ScanIndentNumber

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZQColor(82, 82, 82);
    self.navigationItem.title = @"扫描订单号";
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"说明" style:UIBarButtonItemStyleDone target:self action:@selector(fabu)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self setScanView];
}
-(void)viewWillDisappear:(BOOL)animated
{
    ((OLWTabBarController *)self.tabBarController).zqTabBar .hidden = YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    ((OLWTabBarController *)self.tabBarController).zqTabBar .hidden = YES;
}
-(void)setScanView
{
    self.readerView=[[ZBarReaderView alloc]init];
    _readerView.trackingColor=[UIColor yellowColor];
    _readerView.readerDelegate=self;
    _readerView.frame=self.view.bounds;
    //屏幕大小
    CGRect rvBounsRect = self.view.bounds;
    //可扫描区域
    CGRect scanCropRect = CGRectMake(80, 64+80, 160, 160);
    _readerView.scanCrop=[self getScanCrop:scanCropRect readerViewBounds:rvBounsRect];
    [self.view addSubview:_readerView];
    _readerView.backgroundColor = ZQColor(82, 82, 82);
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.width/2-10, 50)];
    label.center = CGPointMake(self.view.width/2, 50+64);
    label.text = @"将取景框对准二维码进行扫描";
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.numberOfLines = 0;
    [_readerView addSubview:label];

    
    //滚动红线
    self.redLine=[[UIImageView alloc]initWithFrame:CGRectMake(30, 64+80, 260, 3)];
    self.redLine.image=[UIImage imageNamed:@"smx.png"];
    
    [self.view addSubview:self.redLine];
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(lineAnimation) userInfo:nil repeats:YES];
    [UIView animateWithDuration:2.0 animations:^{
        self.redLine.frame=CGRectMake(30, 64+80+280, 260, 3);
    }];
    //显示内容
    self.scanResult=[[UITextView alloc]initWithFrame:CGRectMake(10, self.view.frame.size.height-50, 300, 50)];
    [self.view addSubview:self.scanResult];
    //布局
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"smk2.png"]];
    imageView.frame=CGRectMake(20, 64+80, 280, 280);
    [self.view addSubview:imageView];
    
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 64, 320, 80)];
    view1.backgroundColor=[UIColor blackColor];
    view1.alpha=0.7;
    [self.view addSubview:view1];
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, 64+80, 20, 280)];
    view2.backgroundColor=[UIColor blackColor];
    view2.alpha=0.7;
    [self.view addSubview:view2];
    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(300, 64+80, 20, 280)];
    view3.backgroundColor=[UIColor blackColor];
    view3.alpha=0.7;
    [self.view addSubview:view3];
    UIView *view4=[[UIView alloc]initWithFrame:CGRectMake(0, 64+80+280, 320, 200)];
    view4.backgroundColor=[UIColor blackColor];
    view4.alpha=0.7;
    [self.view addSubview:view4];

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
-(void)viewDidAppear:(BOOL)animated
{
    [self.readerView start];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [self.readerView stop];
}
#pragma mark 处理扫描结果
- (void) readerView: (ZBarReaderView*) view
     didReadSymbols: (ZBarSymbolSet*) syms
          fromImage: (UIImage*) img
{
    //处理扫描结果
    ZBarSymbol *sym =nil;
    for(sym in syms)
        break;
    //停止扫描
    [self.readerView stop];
    //移除红线
    [self.redLine removeFromSuperview];
    self.scanResult.text = sym.data;
}
#pragma mark -  红线滑动
#pragma mark 初始化扫描界面
-(void)lineAnimation
{
    self.redLine.frame=CGRectMake(30, 64+80, 260, 3);
    [UIView animateWithDuration:2.0 animations:^{
        self.redLine.frame=CGRectMake(30, 64+80+280, 260, 3);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
