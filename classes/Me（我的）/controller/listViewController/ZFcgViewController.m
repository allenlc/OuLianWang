//
//  ZFcgViewController.m
//  OuLianWang
//
//  Created by hsmj on 15/7/6.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "ZFcgViewController.h"
#import "OLWTabBarController.h"

@interface ZFcgViewController ()
{
    UILabel  *tiaozhuanlabel;
    int i;
    
}
@end

@implementation ZFcgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self  cratUI];
    
    
    
    
}

-(void)cratUI
{
    
    self.title=@"订单状态";
   
    UIImageView  *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(105, 100, 110, 110)];
    imageview.image=[UIImage  imageNamed:@"勾勾"];
    [self.view  addSubview:imageview];
    
    
    UILabel  *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 220,210, 50)];
    titlelabel.textColor=[UIColor  redColor];
    titlelabel.font=[UIFont  systemFontOfSize:20];
    titlelabel.text=@"恭喜您,付款成功!";
    [self.view  addSubview:titlelabel];
    
    UILabel  *sjlabel=[[UILabel alloc]initWithFrame:CGRectMake(120,260,180, 50)];
    sjlabel.textColor=[UIColor  grayColor];
    sjlabel.font=[UIFont  boldSystemFontOfSize:16];
    sjlabel.text=@"等待商家发货";
    [self.view  addSubview:sjlabel];
    
    i=10;
    tiaozhuanlabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 320,180,30)];
    tiaozhuanlabel.textColor=[UIColor  grayColor];
    tiaozhuanlabel.font=[UIFont  boldSystemFontOfSize:15];
    tiaozhuanlabel.text=@"该页面将在10秒后跳转";
    tiaozhuanlabel.layer.borderColor=[UIColor  grayColor].CGColor;
    tiaozhuanlabel.layer.borderWidth=1;
    tiaozhuanlabel.layer.cornerRadius=5;
    tiaozhuanlabel.textAlignment=1;
    [self.view  addSubview:tiaozhuanlabel];
    
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timechange:) userInfo:nil repeats:YES];
    
    

}


-(void)timechange:time
{
    i--;
    tiaozhuanlabel.text=[NSString  stringWithFormat:@"该页面将在%d秒后跳转",i ];
    
    if (i<1)
    {
        [time  invalidate];
        
        OLWTabBarController *tabbarcontroller=(OLWTabBarController *)self.tabBarController;
        tabbarcontroller.zqTabBar.hidden=NO;
        
        [self.navigationController  popToRootViewControllerAnimated:YES];
        
    }

}


-(void)viewWillAppear:(BOOL)animated
{
    OLWTabBarController *tabbarcontroller=(OLWTabBarController *)self.tabBarController;
    tabbarcontroller.zqTabBar.hidden=YES;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    OLWTabBarController *tabbarcontroller=(OLWTabBarController *)self.tabBarController;
    tabbarcontroller.zqTabBar.hidden=NO;
    
}

-(void)diquButtonClick
{
    
    OLWTabBarController *tabbarcontroller=(OLWTabBarController *)self.tabBarController;
    tabbarcontroller.zqTabBar.hidden=NO;
    [self.navigationController  popToRootViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
