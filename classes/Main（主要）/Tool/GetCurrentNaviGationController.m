//
//  GetCurrentNaviGationController.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/6.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "GetCurrentNaviGationController.h"

@implementation GetCurrentNaviGationController
+(UIViewController *)viewController:(UIView *)view{
    /// Finds the view's view controller.
    // Traverse responder chain. Return first found view controller, which will be the view's view controller.
    UIResponder *responder = view;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    // If the view controller isn't found, return nil.
    return nil;
}
@end
