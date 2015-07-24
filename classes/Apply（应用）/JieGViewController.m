//
//  JieGViewController.m
//  OuLianWang
//
//  Created by hsmj on 15/7/10.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "JieGViewController.h"
#import "OLWTabBarController.h"
@interface JieGViewController ()<UIWebViewDelegate>

@end

@implementation JieGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeSystem];
    // [button1  setImage:[UIImage  imageNamed:@"搜索.png"] forState:UIControlStateNormal];
    [button1  setTitle:@"菜单" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button1.frame=CGRectMake(0,5,40,23);
    [button1  addTarget:self action:@selector(button1Click1) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right1=[[UIBarButtonItem alloc]initWithCustomView:button1];
    self.navigationItem.rightBarButtonItem=right1;

    [self  ctreatWeb];

    
}

-(void)diquButtonClick
{
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];

}

-(void)button1Click1
{
    
}


#pragma mark=========创建显示网页
-(void)ctreatWeb
{
    UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    webview.delegate=self;
    NSURL *url=[NSURL URLWithString:self.Urlstring];
    [webview loadRequest:[NSURLRequest  requestWithURL:url]];
    [self.view  addSubview:webview];
    

}


#pragma mark========网页加载完成后获取显示网页的标题

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
    self.title=[NSString stringWithFormat:@"%@",[webView stringByEvaluatingJavaScriptFromString:@"document.title"]];//获取当前页面的title
    
   // NSLog(@"=======%@",[webView stringByEvaluatingJavaScriptFromString:@"document.title"]);
   // self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

-(void)viewWillAppear:(BOOL)animated
{
    OLWTabBarController *tabbar=(OLWTabBarController *)self.tabBarController;
    tabbar.zqTabBar.hidden=YES;
    
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
