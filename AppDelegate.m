//
//  AppDelegate.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/13.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "AppDelegate.h"
#import "OLWControllerTool.h"
#import "NewFeatureController.h"
#import "SettingViewController.h"
#import <AMapNaviKit/AMapNaviKit.h>
#import "ZBarSDK.h"
#import "BackSingle.h"
#import <AudioToolbox/AudioToolbox.h>
#import "LogInViewController.h"


#import "iflyMSC/IFlySpeechSynthesizer.h"
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"
#import "iflyMSC/IFlySpeechConstant.h"
#import "iflyMSC/IFlySpeechUtility.h"
#import "iflyMSC/IFlySetting.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [NSThread sleepForTimeInterval:2.0]; //延时2秒，以便用户看清楚启动页
    [[UIApplication sharedApplication] setStatusBarHidden:NO]; //启动完成后显示状态栏，该语句应该放在 makeKeyAndVisible 之前
    [self.window makeKeyAndVisible];
    [OLWControllerTool chooseRootViewController];    
    
    //地图
    [MAMapServices sharedServices].apiKey = @"03d06780e3b8aa462757fd1cc6160fde";
    [AMapNaviServices sharedServices].apiKey=@"03d06780e3b8aa462757fd1cc6160fde";
    //讯飞
    [self configIFlySpeech];
    //二维码
    [ZBarReaderView class];

    // 3 .监控网络
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 当网络状态改变了，就会调用
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
            {  NSLog(@"没有网络(断网)");
           
                UIAlertView *view=[[UIAlertView alloc]initWithTitle:@"世界上最遥远的距离就是没有网络" message:@"请检查您的网络设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
                [view  show];
            
            }
                break;

            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
              //  NSLog(@"手机自带网络");
                break;

            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
              //  NSLog(@"WIFI");
                break;
        }
    }];
    // 开始监控
    [mgr startMonitoring];
    //默认数据
    BackSingle *single=[BackSingle shareInstance];
    single.lon=@"113.319478";
    single.lan=@"23.143984";
    single.provId=@"1";
    single.cityId=@"1";
    single.areaId=@"";
    single.selectCity=@"北京市";
    
//    //申请通知
//    float sysVersion=[[UIDevice currentDevice]systemVersion].floatValue;
//    if (sysVersion>=8.0) {
//        UIUserNotificationType type=UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
//        UIUserNotificationSettings *setting=[UIUserNotificationSettings settingsForTypes:type categories:nil];
//        [[UIApplication sharedApplication]registerUserNotificationSettings:setting];
//    }
    
    //推送=------------------------
//    UIRemoteNotificationType types;
//#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//        //可以添加自定义categories
//        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
//                                                       UIUserNotificationTypeSound |
//                                                       UIUserNotificationTypeAlert)
//                                           categories:nil];
//    } else {
//        //categories 必须为nil
//        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                       UIRemoteNotificationTypeSound |
//                                                       UIRemoteNotificationTypeAlert)
//                                           categories:nil];
//    }
//#else
//    //categories 必须为nil
//    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                   UIRemoteNotificationTypeSound |
//                                                   UIRemoteNotificationTypeAlert)
//                                       categories:nil];
//#endif
//    // Required
//    [APService setupWithOption:launchOptions];
//}

//推送-------------------------
//-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//{
//    [APService registerDeviceToken:deviceToken];
//    NSLog(@"%@",deviceToken);
//}
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    
//    // Required
//    [APService handleRemoteNotification:userInfo];
//    NSLog(@"%@",userInfo);
//
//}
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    
//    NSLog(@"%@",userInfo);
//
//    // IOS 7 Support Required
//    [APService handleRemoteNotification:userInfo];
//    completionHandler(UIBackgroundFetchResultNewData);
    
    
    
    return YES;

}
//=====================
#pragma mark - 配置讯飞
- (void)configIFlySpeech
{
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@,timeout=%@",@"53c35b10",@"20000"];
    
    [IFlySpeechUtility createUtility:initString];
    
    [IFlySetting setLogFile:LVL_NONE];
    [IFlySetting showLogcat:NO];
    
    // 设置语音合成的参数
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"50" forKey:[IFlySpeechConstant SPEED]];//合成的语速,取值范围 0~100
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"50" forKey:[IFlySpeechConstant VOLUME]];//合成的音量;取值范围 0~100
    
    // 发音人,默认为”xiaoyan”;可以设置的参数列表可参考个 性化发音人列表;
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"xiaoyan" forKey:[IFlySpeechConstant VOICE_NAME]];
    
    // 音频采样率,目前支持的采样率有 16000 和 8000;
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"8000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
    
    // 当你再不需要保存音频时，请在必要的地方加上这行。
    [[IFlySpeechSynthesizer sharedInstance] setParameter:nil forKey:[IFlySpeechConstant TTS_AUDIO_PATH]];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [[BackSingle shareInstance] setIsBack:YES];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    


    //进入前台激活
    BackSingle *single=[BackSingle shareInstance];
    single.isBack=NO;

    

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
