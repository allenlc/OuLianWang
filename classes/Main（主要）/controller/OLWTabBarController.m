

#import "OLWTabBarController.h"

#import "OLWNavigationController.h"
#import "HomeViewController.h"
#import "MeViewController.h"
#import "HotSellViewController.h"
#import "SameCityViewController.h"
#import "ApplyViewController.h"

@interface OLWTabBarController ()


@end

@implementation OLWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self addchildVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 *添加一个子控制器
 
 */
-(void)addchildVC
{
    HomeViewController * homeVC = [[HomeViewController alloc]init];
    OLWNavigationController *nav1=[[OLWNavigationController alloc]initWithRootViewController:homeVC];
    
    HotSellViewController * hotSellVC = [HotSellViewController new];
    OLWNavigationController *nav2=[[OLWNavigationController alloc]initWithRootViewController:hotSellVC];

    SameCityViewController * sameCityVC = [SameCityViewController new];
    OLWNavigationController *nav3=[[OLWNavigationController alloc]initWithRootViewController:sameCityVC];
    NSLog(@"nav3%@",nav3);
    NSLog(@"sameCityVC%@",sameCityVC);
    
    ApplyViewController * applyVC = [ApplyViewController new];
    OLWNavigationController *nav4=[[OLWNavigationController alloc]initWithRootViewController:applyVC];

    MeViewController * myVC = [MeViewController new];
    OLWNavigationController *nav5=[[OLWNavigationController alloc]initWithRootViewController:myVC];
    
    self.viewControllers=@[nav1,nav2,nav3,nav4,nav5];
}



@end

