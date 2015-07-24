//
//  FastSalesViewController.m
//  OuLianWang
//
//  Created by allenariel on 15/7/7.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "FastSalesViewController.h"
#import "UIView+LCView.h"
#import "CustomTabBar.h"
#import "UILabel+StringFrame.h"

@interface FastSalesViewController ()
{
    UIScrollView *_scrollView;
}
@end

@implementation FastSalesViewController
-(void)viewWillAppear:(BOOL)animated
{
    CustomTabBar *tabBar=(CustomTabBar*)self.navigationController.tabBarController;
    tabBar.zqTabBar.hidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"家具大甩卖";
    [self createUI];
}

-(void)createUI
{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMakeEx(0, 0, 320, 568)];
    _scrollView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_scrollView];
    _scrollView.showsVerticalScrollIndicator=NO;
    [_scrollView addImageViewWithFrame:CGRectMakeEx(0, 0, 320, 460) image:@"屏幕快照 2015-07-07 18.00.35.png"];
    
    UILabel *detailLabel=[[UILabel alloc]init];
    detailLabel.text=@"    发展项目是项目的一种特殊类型，是发展机构为了特定的目标，针对特定的区域和目标群体，在规定的执行时间内和经费的框架下，按照特定的实施政策和组织管理形式而进行的一系列发展干预活动。/n发展项目涉及的领域很是广泛，包括：教育、卫生、基础设施建设项目、人力资源发展、产业及行业的促进与发展等等。如：由德国技术合作公司在中国开发的很多技术合作项目。";
    detailLabel.numberOfLines=0;
    detailLabel.font=[UIFont systemFontOfSize:16];
    detailLabel.textColor=ZQColor(254, 90, 1);
    CGSize newSize=[detailLabel boundingRectWithSize:CGSizeMake(300, 0)];
    detailLabel.frame=CGRectMakeEx(10, 480, newSize.width, newSize.height);
    [_scrollView addSubview:detailLabel];
    
    [_scrollView addImageViewWithFrame:CGRectMakeEx(0, detailLabel.frame.origin.y+detailLabel.frame.size.height, 320, 160) image:@"推广产品.jpg"];
    
    _scrollView.contentSize=CGSizeMake(0, 568+newSize.height+160);
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMakeEx(0, detailLabel.frame.origin.y+detailLabel.frame.size.height+160, 320, 350)];
    view.backgroundColor=ZQColor(251, 212, 57);
    [_scrollView addSubview:view];
    
    int height=0;
    int count=6;
    int x=20,y=0;
    for (int i=0; i<count; i++) {
        if (i%2==0&&i!=0) {
            x=20;
            y+=180;
        }
        UIImageView *imageView=[[UIImageView alloc]init];
        imageView.layer.borderWidth=1;
        imageView.layer.borderColor=[[UIColor whiteColor]CGColor];
        imageView.frame=CGRectMakeEx(x, y, 130, 150);
        imageView.image=[UIImage imageNamed:@"img1.png"];
        [view addSubview:imageView];
        x+=155;
        if (i==count-1) {
            height=imageView.frame.origin.y+150;
        }
    }
    view.frame=CGRectMakeEx(0, detailLabel.frame.origin.y+detailLabel.frame.size.height+160, 320, height+10);
    
    UIImageView *ima=[_scrollView addImageViewWithFrame:CGRectMakeEx(0, view.frame.origin.y+view.frame.size.height, 320, 250) image:@"价格+时间.jpg"];
    [ima addLabelWithFrame:CGRectMakeEx(200, 90, 100, 20) text:@"80"];
    UILabel *ll1=[ima addLabelWithFrame:CGRectMakeEx(175, 140, 100, 20) text:@"2015-06-19"];
    ll1.font=[UIFont systemFontOfSize:16];
    UILabel *ll2=[ima addLabelWithFrame:CGRectMakeEx(175, 195, 100, 20) text:@"2015-06-19"];
    ll2.font=[UIFont systemFontOfSize:16];
    
    _scrollView.contentSize=CGSizeMake(0, view.frame.origin.y+view.frame.size.height+250-54);
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
