//
//  YinXiaoViewController.m
//  OuLianWang
//
//  Created by hsmj on 15/7/7.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "YinXiaoViewController.h"


@interface YinXiaoViewController ()

@end

@implementation YinXiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"营销推广";
    
    [self  creatUI];
    
}

-(void)creatUI
{
    
    NSArray  *array=@[@"yingxiaotuiguang_03",@"yingxiaotuiguang_05",@"yingxiaotuiguang_09",@"yingxiaotuiguang_10",@"yingxiaotuiguang_15",@"yingxiaotuiguang17"];
    int x=0;
    int y=0;
    
    
    for(int i=0;i<6;i++)
    {
        if (i%2==0&&i!=0)
        {
            x=0;
            y++;
            
        }
        
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button  setImage:[UIImage  imageNamed:array[i]] forState:UIControlStateNormal];
        button.frame=CGRectMakeEx(20+150*x, 64+20+150*y, 135, 135);
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
