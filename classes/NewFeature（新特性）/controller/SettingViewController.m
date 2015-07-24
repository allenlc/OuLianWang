//
//  SettingViewController.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/13.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingView.h"
#import "ScanViewController.h"
#import "SaoViewController.h"
#import "ErSaoViewController.h"

@interface SettingViewController ()<AVCaptureMetadataOutputObjectsDelegate,settingDelegate>

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SettingView *settingView = [[SettingView alloc]initWithFrame:self.view.bounds];
    settingView.delegate = self;
    [self.view addSubview:settingView];

}

//settingHomeViewDelegate
-(void)settingHomeView:(UIImageView *)imgView
{
    ErSaoViewController * scanViewController = [ErSaoViewController new];
    [self.view addSubview:scanViewController.view];
    
}


@end
