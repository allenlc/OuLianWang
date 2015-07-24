//
//  GeXinViewController.m
//  OuLianWang
//
//  Created by hsmj on 15/7/8.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "GeXinViewController.h"
#import "OLWTabBarController.h"
@interface GeXinViewController ()

@end

@implementation GeXinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"个性设置";
    
    [self  creatUI];
}


-(void)creatUI
{
    
    UILabel  *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 64+10, 80, 30)];
    label.text=@"字体大小";
    label.font=[UIFont  systemFontOfSize:16];
    label.textColor=[UIColor blackColor];
    [self.view  addSubview:label];

    
    UIImageView  *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64+20+30, 320, 80)];
    imageview.backgroundColor=ZQColor(247, 247, 247);
    imageview.userInteractionEnabled=YES;
    [self.view  addSubview:imageview];
    
    
    NSArray *array=@[@"大",@"中",@"小"];
    for(int i=0;i<3;i++)
    {
        UIButton  *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.textAlignment=2;
        button.frame=CGRectMake(40+100*i, 20, 60, 40);
        [button  setTitle:array[i] forState:UIControlStateNormal];
        [button  setImage:[UIImage imageNamed:@"no-sel"] forState:UIControlStateNormal];
        [button  setImage:[UIImage imageNamed:@"sel"] forState:UIControlStateSelected];
        [button  setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
        [button  addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=400+i;
        if (button.tag==400)
        {
            button.selected=YES;
        }
        
        [imageview  addSubview:button];
    }
    
    
    
    
    
    
    UILabel  *label1=[[UILabel alloc]initWithFrame:CGRectMake(20,64+30+30+80, 80, 30)];
    label1.text=@"位置共享";
    label1.font=[UIFont  systemFontOfSize:16];
    label1.textColor=[UIColor blackColor];
    [self.view  addSubview:label1];
    
    
    UIImageView  *imageview2=[[UIImageView alloc]initWithFrame:CGRectMake(0,64+30+30+80+30, 320, 80)];
    imageview2.backgroundColor=ZQColor(247, 247, 247);
    imageview2.userInteractionEnabled=YES;
    [self.view  addSubview:imageview2];
    
    
    NSArray *array2=@[@"始终",@"请求时",@"禁用"];
    for(int i=0;i<3;i++)
    {
        UIButton  *button1=[UIButton buttonWithType:UIButtonTypeCustom];
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button1.titleLabel.textAlignment=2;
        button1.frame=CGRectMake(40+100*i, 20, 70, 40);
        [button1  setTitle:array2[i] forState:UIControlStateNormal];
        [button1  setImage:[UIImage imageNamed:@"no-sel"] forState:UIControlStateNormal];
        [button1  setImage:[UIImage imageNamed:@"sel"] forState:UIControlStateSelected];
        [button1  setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
        [button1  setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        [button1  addTarget:self action:@selector(buttonclick1:) forControlEvents:UIControlEventTouchUpInside];
        button1.tag=500+i;
        if (button1.tag==500)
        {
            button1.selected=YES;
        }
        
        [imageview2  addSubview:button1];
    }
    


}


-(void)buttonclick:(UIButton *)but
{
    for(int i=400;i<403;i++)
    {
        UIButton *butt=(UIButton *)[self.view  viewWithTag:i];
        butt.selected=NO;
    }
    but.selected=YES;

}


-(void)buttonclick1:(UIButton *)but
{
    for(int i=500;i<503;i++)
    {
        UIButton *butt=(UIButton *)[self.view  viewWithTag:i];
        butt.selected=NO;
    }
    but.selected=YES;
    
}





-(void)viewWillAppear:(BOOL)animated
{
    OLWTabBarController *tabbarcontroller=(OLWTabBarController *)self.tabBarController;
    tabbarcontroller.zqTabBar.hidden=YES;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    OLWTabBarController *tabbarcontroller=(OLWTabBarController *)self.tabBarController;
    tabbarcontroller.zqTabBar.hidden=YES;
    
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
