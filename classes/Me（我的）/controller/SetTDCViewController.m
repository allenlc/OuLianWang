//
//  SetTDCViewController.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/18.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "SetTDCViewController.h"
#import "ScanViewController.h"
#import "CreateCodeViewController.h"
@interface SetTDCViewController ()

@end

@implementation SetTDCViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    //iOS7,iOS8可用
    UIButton *scanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    scanButton.frame = CGRectMake(0, 0, 200, 30);
    scanButton.center = CGPointMake(size.width / 2 , 100);
    [scanButton setTitle:@"扫描" forState:UIControlStateNormal];
    [scanButton addTarget:self action:@selector(dealScan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanButton];
    scanButton.backgroundColor = [UIColor brownColor];
    
    
    UIButton *createButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    createButton.frame = CGRectMake(0, 0, 200, 30);
    createButton.center = CGPointMake(size.width / 2 , 200);
    [createButton setTitle:@"生成二维码" forState:UIControlStateNormal];
    [createButton addTarget:self action:@selector(dealCreate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createButton];
    createButton.backgroundColor = [UIColor brownColor];
    
    
}
-(void)dealScan
{
    ScanViewController *svc = [[ScanViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
}
-(void)dealCreate
{
    CreateCodeViewController *ccvc = [[CreateCodeViewController alloc] init];
    [self.navigationController pushViewController:ccvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
