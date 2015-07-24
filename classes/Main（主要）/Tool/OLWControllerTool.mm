//
//  OLWControllerTool.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/13.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "OLWControllerTool.h"
#import "NewFeatureController.h"
#import "OLWTabBarController.h"
@implementation OLWControllerTool
/**
 *  选择根控制器
 */
+ (void)chooseRootViewController
{
    
    // 如何知道第一次使用这个版本？比较上次的使用情况
    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
    
    // 从沙盒中取出上次存储的软件版本号(取出用户上次的使用记录)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:versionKey];
    
    // 获得当前打开软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    window.rootViewController = [[NewFeatureController alloc] init];
    if ([currentVersion isEqualToString:lastVersion]) {
        // 当前版本号 == 上次使用的版本：显示HMTabBarViewController
        [UIApplication sharedApplication].statusBarHidden = NO;
        OLWTabBarController * olwTabBarController = [[OLWTabBarController alloc]init];
        olwTabBarController.currentSelectedIndex = 2;
        olwTabBarController.selectedViewController = olwTabBarController.viewControllers[2];
       ((UIButton *)olwTabBarController.buttons[olwTabBarController.currentSelectedIndex]).selected = YES;
        window.rootViewController = olwTabBarController;
        
    } else { // 当前版本号 != 上次使用的版本：显示版本新特性
        window.rootViewController = [[NewFeatureController alloc] init];
        
        // 存储这次使用的软件版本
        [defaults setObject:currentVersion forKey:versionKey];
        [defaults synchronize];
    }
    
}
@end
