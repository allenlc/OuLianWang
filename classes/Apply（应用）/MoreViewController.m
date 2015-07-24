//
//  MoreViewController.m
//  OuLianWang
//
//  Created by hsmj on 15/6/25.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "MoreViewController.h"
#import "OLWTabBarController.h"
#import "ErSaoViewController.h"
#import "HomeShopController.h"

@interface MoreViewController ()

{
    int a;

}
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    a=0;
    
    [self  deplyNavigationController1];
    
    [self  creatView];
    
}


#pragma mark-------配置导航栏

-(void)deplyNavigationController1
{

    self.navigationItem.title=@"更多功能";

}


#pragma mark-----创建按钮视图
-(void)creatView
{
    NSArray*titlearray=@[@[@"gengduomonijiaju",@"gengduoxinwenzixun"],@[@"gengduoyulebagua",@"gengduokaixinyike"],@[@"gengduoxinlingjitang",@"gengduojingcaishipin"],@[@"gengduotouzilicai",@"小道频道"]];
    for(int i=0;i<4;i++)
    {
        for(int j=0;j<2;j++)
        {
            a++;
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            [button  setImage:[UIImage imageNamed:[NSString   stringWithFormat:@"%@",titlearray[i][j]]] forState:UIControlStateNormal];
            button.frame=CGRectMake(15+150*j, 80+100*i ,140, 90);
            button.tag=300+a;
            [button  addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view   addSubview:button];
             NSLog(@"%d",button.tag);
        
        }
    }

}

-(void)buttonclick:(UIButton *)button
{
    if (button.tag==301)
    {

        
        HomeShopController *hvc=[[HomeShopController alloc]init];
        hvc.storeId=@"1";
        [self.navigationController pushViewController:hvc animated:YES];
    }
    if (button.tag==302)
    {
        
        
        
    }
    if (button.tag==303)
    {
        
    }
    if (button.tag==304)
    {
        
    }
    if (button.tag==305)
    {
        
    }
    if (button.tag==306)
    {
        
    }
    if (button.tag==307)
    {
        
    }
    if (button.tag==308)
    {
        
    }

}

-(void)viewWillAppear:(BOOL)animated
{
    OLWTabBarController *tabbar=(OLWTabBarController *)self.tabBarController;
    tabbar.zqTabBar.hidden=YES;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    OLWTabBarController *tabbar=(OLWTabBarController *)self.tabBarController;
    tabbar.zqTabBar.hidden=NO;
  

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
