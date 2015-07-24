//
//  NewFeatureController.m
//  ZQ微博
//
//  Created by Ibokan on 15/4/15.
//  Copyright (c) 2015年 HZQ. All rights reserved.
//
#define ZQFeatureImgCount 4
#import "NewFeatureController.h"
#import "SettingViewController.h"

@interface NewFeatureController ()<UIScrollViewDelegate>

@end

@implementation NewFeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
//   添加UIScrollView
    [self setUpScroView];
//  添加pageControl
    [self setupPageControl];
}
-(void)setUpScroView
{
    UIScrollView * scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    scrollerView.delegate = self;
    [self.view addSubview:scrollerView];
    scrollerView.contentSize = CGSizeMake(self.view.width*ZQFeatureImgCount, self.view.height);
    scrollerView.pagingEnabled = YES;
    scrollerView.backgroundColor = ZQColor(135, 230, 244);
    
    
    NSLog(@"begin first time");

    //添加图片
    for (int i = 0 ; i<ZQFeatureImgCount; i++) {
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.width*i, 0, self.view.width, self.view.height)];
        NSString * name = [NSString stringWithFormat:@"引导 0%d.png",i+1];
        imgView.image = [UIImage imageNamed:name];
        [scrollerView addSubview:imgView];
        // 给最后一个imageView添加按钮
        if (i == ZQFeatureImgCount - 1) {
            [self setupLastImageView:imgView];
        }
    }
}

-(void)setupLastImageView:(UIImageView *)imgView
{
    imgView.userInteractionEnabled = YES;
    
    //1
//    [self startBtn:imgView];
    //2 添加立即体验按钮
    [self setUpShareButton:imgView];
    
}
/*
立即体验

*/
-(void)setUpShareButton:(UIImageView * )imageView
{
    //添加立即体验按钮
    UIButton * shareBtn = [[UIButton alloc]init];
    [imageView addSubview:shareBtn];
    
//    [shareBtn setTitle:@"立即体验" forState:0];
    [shareBtn setTitleColor:[UIColor blueColor] forState:0];
    [shareBtn setImage:[UIImage imageNamed:@"引导 04-立即体验.png"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    
    //监听点击
    [shareBtn addTarget:self action:@selector(start) forControlEvents:(UIControlEventTouchUpInside)];
    shareBtn.frame = CGRectMake(0, 0, 98, 32);
    shareBtn.center= CGPointMake(self.view.width*0.5, self.view.height*0.93);




    
    
}
-(void)shareToOther:(UIButton *)shareBtn
{
//    NSLog(@"%d",shareBtn.selected);
//    NSLog(@"%d",shareBtn.isSelected);
    shareBtn.selected = !shareBtn.isSelected;
}
/*
立即体验
 
 */

-(void)start
{
    // 显示设置控制器（HMTabBarController）
    SettingViewController *vc = [[SettingViewController alloc] init];
    
    // 切换控制器
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = vc;

}
/**
 *  添加pageControl
 */
- (void)setupPageControl
{
    // 1.添加
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = ZQFeatureImgCount;
    pageControl.center= CGPointMake(160, 500);
    [self.view addSubview:pageControl];
    
    // 2.设置圆点的颜色
    pageControl.currentPageIndicatorTintColor = ZQColor(253, 98, 42); // 当前页的小圆点颜色
    pageControl.pageIndicatorTintColor = ZQColor(189, 189, 189); // 非当前页的小圆点颜色
    self.pageControl = pageControl;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获得页码
    CGFloat doublePage = scrollView.contentOffset.x / scrollView.width;
    int intPage = (int)(doublePage + 0.5);
    
    // 设置页码
    self.pageControl.currentPage = intPage;
}



@end
