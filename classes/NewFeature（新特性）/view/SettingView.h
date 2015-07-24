//
//  SettingView.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/13.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol settingDelegate<NSObject>
-(void)settingHomeView:(UIImageView *)imgView;
@end
@interface SettingView : UIImageView
@property(weak,nonatomic)id<settingDelegate >delegate;
@end
