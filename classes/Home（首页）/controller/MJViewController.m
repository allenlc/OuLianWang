//
//  MJViewController.m
//  OuLianWang
//
//  Created by hsmj on 15/6/15.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "MJViewController.h"

@interface MJViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;

}
@end

@implementation MJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self  deplyNavigationController];
    
    [self  creatheaderView];
    
    [self   creattableView];
    //13212606641
    
}

#pragma mark-------配置导航栏

-(void)deplyNavigationController
{
//    self.view.backgroundColor=[UIColor whiteColor];
//    self.navigationController.navigationBar.barTintColor=[UIColor redColor];
//    self.navigationItem.title=@"保定电谷家居广场";
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
//                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIButton *fabubutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [fabubutton  setTitle:@"修改" forState:UIControlStateNormal];
    [fabubutton  setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    fabubutton.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    fabubutton.frame=CGRectMake(0, 0, 50, 50);
    UIBarButtonItem *rightbutton=[[UIBarButtonItem alloc]initWithCustomView:fabubutton];
    
    
    UIButton *diqubutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [diqubutton  setImage:[UIImage imageNamed:@"返回箭头.png"] forState:UIControlStateNormal];
    [diqubutton  addTarget:self action:@selector(diquButtonClick) forControlEvents:UIControlEventTouchUpInside];
    diqubutton.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    diqubutton.frame=CGRectMake(0, 0,20,20);
    UIBarButtonItem *leftbutton=[[UIBarButtonItem alloc]initWithCustomView:diqubutton];
    
    // 调整 leftBarButtonItem 在 iOS7 下面的位置
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0))
        
    {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                       target:nil action:nil];
        negativeSpacer.width = -0;//这个数值可以根据情况自由变化
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftbutton];
    }
    else
        
        self.navigationItem.leftBarButtonItem = leftbutton;
    
    
    // 调整 leftBarButtonItem 在 iOS7 下面的位置
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0))
        
    {
        UIBarButtonItem *ne1gativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                       target:nil action:nil];
        ne1gativeSpacer.width = -10;//这个数值可以根据情况自由变化
        self.navigationItem.rightBarButtonItems = @[ne1gativeSpacer, rightbutton];
    }
    else
        
        self.navigationItem.rightBarButtonItem = rightbutton;
   
}


-(void)diquButtonClick
{
    [self.navigationController  popViewControllerAnimated:YES];

}

#pragma mark------下载数据

-(void)downloaddata
{
   
    
    
    
    
    

}






#pragma mark--------创建顶部视图
-(void)creatheaderView
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 190)];
    view.layer.borderWidth=2;
    view.layer.borderColor=[UIColor blackColor].CGColor;
    [self.view  addSubview:view];
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(15, 90, 70, 70)];
    imageview.image=[UIImage  imageNamed:@"d058ccbf6c81800a25b3d269b03533fa828b4706.jpg"];
    [view  addSubview:imageview];
    
    UILabel *olabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 80, 120, 30)];
    olabel.text=@"保定电谷家居广场";
    olabel.font=[UIFont systemFontOfSize:14];
    [view  addSubview:olabel];
    
    UILabel *tlabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 110, 120, 30)];
    tlabel.text=@"营业执照已认证";
    tlabel.textColor=[UIColor grayColor];
    tlabel.font=[UIFont systemFontOfSize:12];
    [view  addSubview:tlabel];
    
    UILabel *thlabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 140, 120, 30)];
    thlabel.text=@"电话 0201112321";
    thlabel.textColor=[UIColor grayColor];
    thlabel.font=[UIFont systemFontOfSize:12];
    [view  addSubview:thlabel];
    
    UIImageView *dianhuaimageview=[[UIImageView alloc]initWithFrame:CGRectMake(250, 140, 30, 30)];
    dianhuaimageview.image=[UIImage  imageNamed:@"电话.png"];
    [view  addSubview:dianhuaimageview];

    
    UIImageView *xiaoxidianimageview=[[UIImageView alloc]initWithFrame:CGRectMake(250, 85, 30, 30)];
    xiaoxidianimageview.image=[UIImage  imageNamed:@"u=3599856,1803588092&fm=21&gp=0.jpg"];
    [view  addSubview:xiaoxidianimageview];
    
    
}

#pragma mark--------创建顶部视图
-(void)creattableView
{
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 190, 320, 500)];
    _scrollView.contentSize=CGSizeMake(320, 1000);
    _scrollView.delegate=self;
    _scrollView.userInteractionEnabled=YES;
    [self.view   addSubview: _scrollView];
    
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    label.text=@"店铺介绍";
    [_scrollView  addSubview:label];
    
    
    UILabel *textlabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 320, 90)];
    textlabel.text=@"       我点产品全部来自正规渠道，以最直接有效的方式送达最终消费者的手里，避免了中间过多的流通环节，并且本店一直是以薄利多销为原则";
    textlabel.numberOfLines=0;
    textlabel.font=[UIFont systemFontOfSize:14];
    textlabel.textColor=[UIColor grayColor];
    [_scrollView  addSubview:textlabel];
    
    UILabel *jielabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 120, 100, 20)];
    jielabel.text=@"店铺相册";
    [_scrollView  addSubview:jielabel];

    UIScrollView * _hengscrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(5, 130, 600, 120)];
    _hengscrollView.contentSize=CGSizeMake(700, 120);
    _hengscrollView.delegate=self;
    [_scrollView  addSubview:_hengscrollView];
    
    NSArray *array=@[@"n_1.jpg",@"n_2.jpg",@"n_3.jpg",@"n_4.jpg"];
    for (int i=0; i<array.count; i++)
    {
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(5+105*i, 20, 95, 95)];
        imageview.image=[UIImage imageNamed:array[i]];
        [_hengscrollView  addSubview:imageview];
        
    }
    
    UILabel *zhizhaolabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 250, 100, 20)];
    zhizhaolabel.text=@"店铺执照";
    [_scrollView  addSubview:zhizhaolabel];
    
    UIImageView *zhizhaoimageview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 275, 120, 100)];
    zhizhaoimageview.image=[UIImage imageNamed:@"u=999540690,1526088099&fm=21&gp=0.jpg"];
    [_scrollView  addSubview:zhizhaoimageview];
//
    
    UILabel *menmianlabel=[[UILabel alloc]initWithFrame:CGRectMake(160, 250, 100, 20)];
    menmianlabel.text=@"店铺门面";
    [_scrollView  addSubview:menmianlabel];
    
    UIImageView *duanpuimageview=[[UIImageView alloc]initWithFrame:CGRectMake(160, 275, 120,90)];
    duanpuimageview.image=[UIImage imageNamed:@"IMG_0363.JPG"];
    [_scrollView  addSubview:duanpuimageview];
    
    UILabel *dizhilabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 235+150, 100, 20)];
    dizhilabel.text=@"详细地址";
    [_scrollView  addSubview:dizhilabel];
    
    UILabel *dianzhanglabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 455, 100, 20)];
    dianzhanglabel.text=@"店长认证";
    [_scrollView  addSubview:dianzhanglabel];
    
    UIImageView *dianzhangimageview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 460, 80, 80)];
    dianzhangimageview.image=[UIImage imageNamed:@"u=4105082266,1250984289&fm=21&gp=0"];
    [_scrollView  addSubview:dianzhangimageview];
    
    UILabel *kefulabel=[[UILabel alloc]initWithFrame:CGRectMake(160, 455, 100, 20)];
    kefulabel.text=@"店铺客服：";
    [_scrollView  addSubview:kefulabel];
    
   
    UIImageView *kefuimageview=[[UIImageView alloc]initWithFrame:CGRectMake(160, 475, 80, 80)];
    kefuimageview.image=[UIImage imageNamed:@"u=2466540986,475595333&fm=21&gp=0.jpg"];
    [_scrollView  addSubview:kefuimageview];
    
    UILabel *kefuminglabel=[[UILabel alloc]initWithFrame:CGRectMake(250, 455, 100, 20)];
    kefuminglabel.text=@"范小姐";
    [_scrollView  addSubview:kefuminglabel];
    
    
    UIImageView *dianhuimageview=[[UIImageView alloc]initWithFrame:CGRectMake(260, 485, 30, 30)];
    dianhuimageview.image=[UIImage  imageNamed:@"电话.png"];
    [_scrollView  addSubview:dianhuimageview];
    
    
    UIImageView *xiaoxidianimageview=[[UIImageView alloc]initWithFrame:CGRectMake(260, 525, 30, 30)];
    xiaoxidianimageview.image=[UIImage  imageNamed:@"u=3599856,1803588092&fm=21&gp=0.jpg"];
    [_scrollView  addSubview:xiaoxidianimageview];

    UILabel *erweimalabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 565, 100, 20)];
    erweimalabel.text=@"店铺二维码";
    [_scrollView  addSubview:erweimalabel];
    

    
    UILabel *pingjialabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 695, 100, 20)];
    pingjialabel.text=@"店铺评价：";
    [_scrollView  addSubview:pingjialabel];
    
    
    
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
