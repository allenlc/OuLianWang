//
//  OLWNavigationController.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/13.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "OLWNavigationController.h"

@interface OLWNavigationController ()

@end

@implementation OLWNavigationController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationBar.barTintColor=ZQColor(205, 0, 0);
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
}

/**
 *  当第一次使用这个类的时候调用1次
 */
+ (void)initialize
{
//    [self setupNavigationBarTheme];
//    [self setupNavigationItemTheme];
}
/**
 *  设置UINavigationBarTheme的主题
 */
//+(void)setupNavigationBarTheme
//{
//    UINavigationBar * appearence = [UINavigationBar appearance];
//    
//    //设置导航栏背景//
//    
//    //设置文字属性
//    NSMutableDictionary * textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName]=[UIColor blackColor];
//    textAttrs[NSFontAttributeName]= [UIFont systemFontOfSize:20];
//    textAttrs[NSBaselineOffsetAttributeName] = [NSValue valueWithUIOffset:UIOffsetZero];
//    [appearence setTitleTextAttributes:textAttrs];
//    
//}
/**
 *  设置UIBarButtonItem的主题
 */
//+(void)setupNavigationItemTheme
//{
//    // 通过appearance对象能修改整个项目中所有UIBarButtonItem的样式
//    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
//    
//    //    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor ba], NSForegroundColorAttributeName, nil]];
//    
//    // 设置普通状态的文字属性
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor],NSForegroundColorAttributeName, nil];
//    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
//    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//    
//    // 设置高亮状态的文字属性
//    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil];
//    highTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
//    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
//    
//    // 设置不可用状态(disable)的文字属性
//    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],NSBackgroundColorAttributeName, nil];
//    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
//    [appearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
//}
//能拦截所有push进来的控制器
//-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if (self.viewControllers.count > 0) { // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
//        viewController.hidesBottomBarWhenPushed = YES;
//        
//        // 设置导航栏按钮
//        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back" highImageName:@"navigationbar_back_highlighted" target:self action:@selector(back)];
//        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_more" highImageName:@"navigationbar_more_highlighted" target:self action:@selector(more)];
//    }
//    [super pushViewController:viewController animated:animated];
//    
//}
-(void)back
{
    [self popViewControllerAnimated:YES];
}
-(void)more
{
    [self popToRootViewControllerAnimated:YES];
}

@end
