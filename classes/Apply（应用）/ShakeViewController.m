//
//  ShakeViewController.m
//  OuLianWang
//
//  Created by allenariel on 15/6/22.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "ShakeViewController.h"
#import "CustomTabBar.h"
@interface ShakeViewController ()

@end

@implementation ShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"摇一摇";
    CustomTabBar *tabBar=(CustomTabBar*)self.navigationController.tabBarController;
    tabBar.zqTabBar.hidden=YES;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, 320, 568)];
    imageView.image=[UIImage imageNamed:@"yaoyiyao.png"];
    [self.view addSubview:imageView];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    CustomTabBar *tabBar=(CustomTabBar*)self.navigationController.tabBarController;
    tabBar.zqTabBar.hidden=NO;
}
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (event.subtype==UIEventSubtypeMotionShake) {
        NSLog(@"摇动开始");
    }
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (event.subtype==UIEventSubtypeMotionShake) {
        NSLog(@"摇动结束");
    }
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
