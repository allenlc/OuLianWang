//
//  UIBarButtonItem+UIBarButtonItem_Extension.h
//  ZQ微博
//
//  Created by Ibokan on 15/4/14.
//  Copyright (c) 2015年 HZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;
@end
