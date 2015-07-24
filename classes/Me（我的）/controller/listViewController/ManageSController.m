//
//  ManageSController.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/27.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "ManageSController.h"
#import "StarView.h"
#import "OLWTabBarController.h"
#import "GoodsManageVC.h"
#import "YongHuViewController.h"
#import "WuLiuViewController.h"
#import "ShuJViewController.h"
#import "CreateCodeViewController.h"
#import "YinXiaoViewController.h"
#import "MyDistributorVC.h"

#define margin 10
#define margin1 17
@interface ManageSController ()

@end

@implementation ManageSController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"管理店铺";
    [self setTopView];
    [self setListView];
}
-(void)viewWillAppear:(BOOL)animated
{
    ((OLWTabBarController *)self.tabBarController).zqTabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    ((OLWTabBarController *)self.tabBarController).zqTabBar.hidden = YES;
}
-(void)setTopView
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 64+10, 320, 90)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view  addSubview:view];
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(20, margin, 70, 70)];
    imageview.image=[UIImage  imageNamed:@"dianpuguanlitouxiang"];
    [view  addSubview:imageview];
    
    UILabel *olabel=[[UILabel alloc]initWithFrame:CGRectMake(110, margin, 200, 20)];
    olabel.text=@"小美店长，欢迎回来！";
    olabel.textColor = [UIColor orangeColor];
    olabel.font=[UIFont systemFontOfSize:14];
    [view  addSubview:olabel];
    
    UILabel *tlabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 35, 90, 20)];
    tlabel.text=@"营业执照已认证";
    tlabel.textColor=[UIColor grayColor];
    tlabel.font=[UIFont systemFontOfSize:12];
    [view  addSubview:tlabel];
    
    
    UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(110, 60, 30, 20) ];
    lab2.text = @"好评:";
    lab2.textColor = [UIColor grayColor];
    lab2.font=[UIFont systemFontOfSize:12];
    [view addSubview:lab2];
    
    
    StarView * startView = [[StarView alloc]initWithFrame:CGRectMake(140, 60, 60, 20)];
    [startView setStar:4.5 ];
    [view addSubview:startView ];
    
    UILabel *lab3=[[UILabel alloc]initWithFrame:CGRectMake(200, 60, 30, 20) ];
    lab3.textColor = [UIColor orangeColor];
    lab3.text = @"4.5分";
    lab3.textColor = [UIColor grayColor];
    lab3.font=[UIFont systemFontOfSize:12];
    [view addSubview:lab3];
    
    NSArray * titlearr=@[@"参数配置",@"店铺装修"];
    NSArray * colorArr = @[ZQColor(75, 173, 19),ZQColor(211, 53, 58)];
    for ( int i = 0; i<2; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titlearr[i] forState:0];
        btn .titleLabel.font = [UIFont systemFontOfSize:13];
        btn.backgroundColor = colorArr[i];
        btn .size = CGSizeMake(60, 25);
        btn.x = self.view.width-70;
        btn.y = 15+40*i;
        btn.tag = 600*i;
        [btn addTarget:self action:@selector(topSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 8;
        [view addSubview:btn];
    }
    

}
-(void)topSelectBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 600:
        {
            
        }
            break;
        case 601:
        {
            
        }
            break;
            
        default:
            break;
    }
}
-(void)setListView
{
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 164+10, self.view.width, (self.view.height-174)*0.9)];
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    
   
    
    NSArray * picArr = @[@"order",@"product",@"statistical",@"marketing",@"market",@"distributors",@"evaluation",@"logistics",@"share_friend"];
    int x = 0;
    for (int j = 0; j<3; j++) {
        for (int i = 0; i<3; i++) {
                UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(margin1+((self.view.width-margin1*6)/3+2*margin1)*i, margin1+((view1.height-margin1*6)/3+2*margin1)*j, (self.view.width-margin1*6)/3, (self.view.width-margin1*6)/3+8)];
            btn.size = CGSizeMake( (self.view.width-margin1*6)/3, (self.view.width-margin1*6)/3+8);
            btn.x =margin1+((self.view.width-margin1*6)/3+2*margin1)*i;
            btn.y =10+(btn.height+2*10)*j;
                [view1 addSubview:btn];
//            btn.backgroundColor = ZQRandomColor ;
                btn.tag = x;
                [btn setImage:[UIImage imageNamed:picArr[x]] forState:0];
                [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];

                x++;
        }
    }
    view1.height =((self.view.width-margin1*6)/3+8)*3+10*6;
    for (int i = 0; i<3;i++) {
        UIImageView * imgview= [[UIImageView alloc]initWithFrame:CGRectMake(0, view1.height/3*i, self.view.width, 1)];
        imgview.backgroundColor = ZQColor(232, 232, 232);
        [view1 addSubview:imgview];
    }
    
    for (int i = 0; i<3;i++) {
        UIImageView * imgview= [[UIImageView alloc]initWithFrame:CGRectMake(view1.width/3*i, 0, 1, view1.height)];
        imgview.backgroundColor = ZQColor(232, 232, 232);
        [view1 addSubview:imgview];
    }

    
}

-(void)selectBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
        {
           
        }
            break;
        case 1:
        {
            [self.navigationController pushViewController:[GoodsManageVC new] animated:YES];
                   }
            break;
        case 2:
        {
            ShuJViewController *shujucontroller=[[ShuJViewController alloc]init];
            [self.navigationController  pushViewController:shujucontroller animated:YES];
            
                    }
            break;
        case 3:
        {
            YinXiaoViewController *yinxiaoxontroller=[[YinXiaoViewController alloc]init];
            [self.navigationController  pushViewController:yinxiaoxontroller animated:YES];
            
                    }
            break;
        case 4:
        {
           
        }
            break;
        case 5:
        {
            [self.navigationController pushViewController:[MyDistributorVC new] animated:YES];
        }
            break;
        case 6:
        {
            
            YongHuViewController *yonghucontroler=[[YongHuViewController alloc]init];
            [self.navigationController  pushViewController:yonghucontroler animated:YES];
            
        }
            break;
        case 7:
        {
            WuLiuViewController *wulian=[[WuLiuViewController alloc]init];
            [self.navigationController  pushViewController:wulian animated:YES];
            
        }
            break;
        case 8:
        {
            CreateCodeViewController *controller=[[CreateCodeViewController alloc]init];
            [self.navigationController  pushViewController:controller animated:YES];
            
        }
            break;
            
        default:
            break;
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
