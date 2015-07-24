//
//  SettingView.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/13.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "SettingView.h"
#import "OLWTabBarController.h"
#import <UIKit/UIKit.h>
@implementation SettingView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        //设置背景图片

        self.image = [UIImage imageNamed:@"个性设置.png"];
//        imgView.size =CGSizeMake(self.width * 0.5, self.height * 0.5);
//        imgView.center = CGPointMake(self.width * 0.5, self.height * 0.5);
//        [self addSubview:imgView];
        // 设置我的个性首页
        UIButton * settingBtn = [[UIButton alloc]init];
        settingBtn.layer.cornerRadius = 5;
        settingBtn.titleLabel.font =[UIFont boldSystemFontOfSize:15];
        settingBtn.backgroundColor  = ZQColor(0, 29, 69);
        settingBtn.size =CGSizeMake(self.width * 0.4, 30);
        settingBtn.center = CGPointMake(self.width * 0.5, self.height * 0.85);
        [settingBtn setTitle:@"设置我的个性首页" forState:UIControlStateNormal];
        [settingBtn setTitleColor:ZQColor(0, 79, 178) forState:UIControlStateNormal];
        [settingBtn addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:settingBtn];
        
        // 设置跳过按钮
        UIButton * skipBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        skipBtn.userInteractionEnabled= YES;
        skipBtn.size =CGSizeMake(self.width * 0.33, 20);
        skipBtn.center = CGPointMake(self.width * 0.5, self.height * 0.92);
        settingBtn.titleLabel.font =[UIFont boldSystemFontOfSize:15];
        [skipBtn setTitle:@"跳过进入主页" forState:UIControlStateNormal];
        skipBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [skipBtn addTarget:self action:@selector(skip) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:skipBtn];
        
       

    }
    return self;
}

-(void)skip
{
    // 显示主控制器（OLWTabBarController）
    OLWTabBarController *vc = [[OLWTabBarController alloc] init];
    // 切换控制器
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = vc;
    vc.selectedViewController = vc.viewControllers[2];

}
-(void)setting
{
    [self.delegate settingHomeView:self ];
    
}
@end
