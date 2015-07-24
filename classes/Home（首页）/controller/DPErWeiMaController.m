//
//  DPErWeiMaController.m
//  OuLianWang
//
//  Created by hsmj on 15/7/21.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "DPErWeiMaController.h"
#import "OLWTabBarController.h"
#import "QRCodeGenerator.h"

@interface DPErWeiMaController ()
{
    UIImageView *_showCodeImageView;
}
@end

@implementation DPErWeiMaController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"二维码";
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    //输入字符串
    //    userID = @"13726292624";
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    titleLabel.text =@"扫扫更精彩";
    titleLabel.textColor = [UIColor redColor];
    titleLabel.textAlignment = 1;
    titleLabel .center = CGPointMake(self.view.width/2, self.view.height*0.2);
    [self.view addSubview:titleLabel];
    [self createBotBtn];
    
    
    //显示
    _showCodeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _showCodeImageView.center = CGPointMake(size.width / 2 , self.view.height*0.5);
    [self.view addSubview:_showCodeImageView];
    
    
    NSString * userID =@"http://www.hsmja.com/hsmja_mobile/wolian.html?s_userid=%@";
    NSString *ID=[[NSUserDefaults standardUserDefaults]valueForKey:UseDipuIDKey];
    NSLog(@"%@",ID);
    UIImage * image = [QRCodeGenerator qrImageForString:[NSString  stringWithFormat:userID,ID] imageSize:_showCodeImageView.bounds.size.width];
    _showCodeImageView.image = image;
    
}

-(void)createBotBtn
{
    NSArray * arr = @[@"保存到手机",@"分享给好友",@"分享到朋友圈"];
    NSArray * arr1 = @[@"baocunzhishouji",@"fenxianggeipengyou",@"fenxiangpengyouquan"];
    for (int i = 0; i<3; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.size = CGSizeMake(60, 60);
        //        btn.backgroundColor = ZQRandomColor;
        btn.center = CGPointMake(self.view.width/6*(2*i+1), self.view.height-100);
        [self.view addSubview:btn];
        [btn setImage:[UIImage imageNamed:arr1[i]] forState:0 ];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.width/3*i, CGRectGetMaxY(btn.frame)+10, self.view.width/3, 20)];
        label.text =arr[i];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = 1;
        [self.view addSubview:label];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    ((OLWTabBarController *)self.tabBarController).zqTabBar.hidden = YES;
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
