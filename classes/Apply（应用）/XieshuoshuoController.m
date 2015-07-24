//
//  XieshuoshuoController.m
//  OuLianWang
//
//  Created by hsmj on 15/6/24.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "XieshuoshuoController.h"
#import "OLWTabBarController.h"
#import "WXViewController.h"

@interface XieshuoshuoController ()
{
    UITextView *_textView;

}
@end

@implementation XieshuoshuoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self  creattextView];
    
    [self  deplyNavigationController1];
    
}


#pragma mark-------配置导航栏

-(void)deplyNavigationController1
{

    self.navigationItem.title=@"发表文字";

    UIButton *fabubutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [fabubutton  setTitle:@"发送" forState:UIControlStateNormal];
    fabubutton.frame=CGRectMake(0, 0, 40, 20);
    [fabubutton  addTarget:self action:@selector(fabuclick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightbutton=[[UIBarButtonItem alloc]initWithCustomView:fabubutton];
    self.navigationItem.rightBarButtonItem=rightbutton;

    
    
}

-(void)fabuclick
{
  
    
}


-(void)diquButtonClick
{

    [self.navigationController  popViewControllerAnimated:YES];
    
}


#pragma mark-------创建textView

-(void)creattextView
{
    _textView=[[UITextView alloc]initWithFrame:CGRectMake(0,15,320,180)];
    _textView.font=[UIFont systemFontOfSize:16];
    _textView.layer.borderWidth=1;
    _textView.layer.borderColor=ZQColor(220, 220, 220).CGColor;
    _textView.showsVerticalScrollIndicator=NO;
    _textView.userInteractionEnabled=YES;
    [self.view   addSubview:_textView];

}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textView  resignFirstResponder];

}


#pragma mark------标签栏的隐藏和现实
-(void)viewWillAppear:(BOOL)animated
{
    
    OLWTabBarController * tabBarVC =(OLWTabBarController *) self.tabBarController;
    tabBarVC.zqTabBar.hidden = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    OLWTabBarController * tabBarVC =(OLWTabBarController *) self.tabBarController;
    tabBarVC.zqTabBar.hidden = NO;
    
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
