//
//  HuangShiViewController.m
//  OuLianWang
//
//  Created by hsmj on 15/6/19.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "HuangShiViewController.h"

@interface HuangShiViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
{
    
    UIWebView *_webView;

}
@end

@implementation HuangShiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"皇室美家";
    [self  deplynavigationController];
}

-(void)deplynavigationController
{
    self.view.backgroundColor=[UIColor whiteColor];
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 620)];
    [_webView  loadRequest:[NSURLRequest  requestWithURL:[NSURL URLWithString:@"http://www.hsmja.com/hsmja_mobile/"]]];
    UIPinchGestureRecognizer * swipe=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(swipeMove:)];
    
    [_webView addGestureRecognizer:swipe];
    [self.view  addSubview:_webView];

}

-(void)swipeMove:(UISwipeGestureRecognizer *)swipe
{
    
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
