//
//  ListViewController.m
//  OuLianWang
//
//  Created by allenariel on 15/6/24.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "ListViewController.h"
#import "CustomTabBar.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self hideTabBar];
}
//-(void)viewWillAppear:(BOOL)animated
//{
//    CustomTabBar *tabBar=(CustomTabBar*)self.navigationController.tabBarController;
//    
//    tabBar.zqTabBar.hidden=YES;
//    [self deplyNavigationController];
//    self.view.backgroundColor=ZQColor(232, 232, 232);
//}
-(void)hideTabBar
{
    CustomTabBar *tabBar=(CustomTabBar*)self.navigationController.tabBarController;
    
    tabBar.zqTabBar.hidden=YES;
    [self deplyNavigationController];
    self.view.backgroundColor=ZQColor(232, 232, 232);

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    CustomTabBar *tabBar=(CustomTabBar*)self.navigationController.tabBarController;
    tabBar.zqTabBar.hidden=NO;
}

#pragma mark-------配置导航栏

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
    [MBProgressHUD hideHUD];
    [self.navigationController  popViewControllerAnimated:YES];
    
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
