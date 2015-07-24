//
//  WuLiuViewController.m
//  OuLianWang
//
//  Created by hsmj on 15/7/7.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "WuLiuViewController.h"

#define Kuan 20

@interface WuLiuViewController ()

@end

@implementation WuLiuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"物流管理";
    
    [self  creatUI];
    
}


-(void)creatUI
{
    UIImageView  *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0,64, 320, 200)];
    imageview.image=[UIImage imageNamed:@"wuliulunbotu"];
    [self.view addSubview:imageview];
    int y=0;
    int x=0;
    NSArray  *array=@[@"fujindesonghuoyuan",@"wodesonghuoyuan",@"wuliugongju",@"fahuoguanli",@"kuaidichaxun",@"wuliushuju"];
    for (int i=0; i<6; i++)
    {
        if (i%3==0&&i!=0)
        {
            x=0;
            y++;
        }
        UIButton *button=[UIButton  buttonWithType:UIButtonTypeCustom];
        [button  setImage:[UIImage imageNamed:array[i]] forState:UIControlStateNormal];
        button.frame=CGRectMake(Kuan+100*x, 50+150+64+Kuan+100*y, 80, 80);
        
        x++;
        [self.view  addSubview:button];
        
        
    }
    
    

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
