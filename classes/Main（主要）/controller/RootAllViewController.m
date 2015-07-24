//
//  RootAllViewController.m
//  OuLianWang
//
//  Created by allenariel on 15/6/27.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "RootAllViewController.h"

@interface RootAllViewController ()

@end

@implementation RootAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self deplyNavigationController];
}
-(void)deplyNavigationController
{
    self.navigationController.navigationBar.barTintColor=ZQColor(243,0,0);

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
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
