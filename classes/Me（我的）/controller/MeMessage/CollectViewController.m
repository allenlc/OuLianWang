//
//  CollectViewController.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/17.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "CollectViewController.h"
#import "CollectTableViewCell.h"
#import "CollectGoodsTableView.h"
#import "CollectShopTableView.h"
#define margin 20
@interface CollectViewController ()<UISearchBarDelegate,UIScrollViewDelegate>
{
    UIView  * view;
    UILabel * currentLable;
    UIScrollView * myScrollView;
    UIButton * currentSelectBtn;
    UIView * titleView;
}
@property(nonatomic,strong)UISearchBar * searchBar;
@end

@implementation CollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ZQColor(232, 232, 232);
    [self setNavigationTitle];
    [self createSearchBar:@"搜索收藏的宝贝..."];
    [self creatTopView];
    [self creatScrollView];
    [self creatTableView];


    
}
-(void)creatTopView
{
    view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_searchBar.frame), self.view.width, 30)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view ];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.width/2, view.height)];
    label.text = @"商品列表";
    label.textColor = ZQColor(201, 0, 9);
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor redColor];
    [view addSubview:label];
    currentLable = label;
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(view.width-50, 0, 40, 30)];
    [btn setTitle:@"编辑" forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:[UIColor redColor] forState:0 ];
    [view addSubview:btn];

}

#pragma mark --------创建滚动视图
-(void)creatScrollView
{
    myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame)+5, self.view.width, self.view.height-CGRectGetMaxY(view.frame) -5)];
    myScrollView.backgroundColor = ZQRandomColor;
    myScrollView.contentSize = CGSizeMake(myScrollView.width*2, myScrollView.height);
    myScrollView.pagingEnabled = YES;
    myScrollView.bounces = NO;
    myScrollView.delegate = self;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myScrollView];
}
#pragma mark --------创建tableView
-(void)creatTableView
{
    CollectGoodsTableView * collectGoodsTableView = [[CollectGoodsTableView alloc]initWithStyle:UITableViewStylePlain];
    collectGoodsTableView.view.frame = myScrollView.bounds;
    [self addChildViewController:collectGoodsTableView];
    [myScrollView addSubview:collectGoodsTableView.view];
    
    CollectShopTableView * collectShopTableView = [[CollectShopTableView alloc]initWithStyle:UITableViewStylePlain];
    collectShopTableView.view.frame = myScrollView.bounds;
    collectShopTableView.view.x = self.view.width;
    [self addChildViewController:collectShopTableView];
    [myScrollView addSubview:collectShopTableView.view];

    
}
#pragma mark --------创建搜索栏
-(void)createSearchBar: (NSString *)searchTitle
{
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.backgroundColor=ZQColor(232, 232, 232);
    imageView.frame=CGRectMake(0, 64, 30, 40);
    [self.view  addSubview:imageView];
    
    UIImageView *image=[[UIImageView alloc]init];
    image.frame=CGRectMake(10, 10, 20,20);
    image.image=[UIImage imageNamed:@"down.png"];
    [imageView  addSubview:image];
    
    _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(30, 64, 230, 40)];
    _searchBar.placeholder=searchTitle;
    _searchBar.barTintColor =ZQColor(232, 232, 232);
    _searchBar.layer.borderWidth =0.5;
    _searchBar.layer.borderColor =ZQColor(232, 232, 232).CGColor;
    _searchBar.delegate=self;
    _searchBar.searchBarStyle=UISearchBarStyleProminent;
    [self.view  addSubview:_searchBar];
    
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(CGRectGetMaxX(_searchBar.frame)+5, _searchBar.y+7.5, 50, 25);
    [searchBtn setTitle:@"搜索" forState:0];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:16 weight:5];
    searchBtn.backgroundColor = ZQColor(201, 0, 9);
    [searchBtn setTintColor:[UIColor whiteColor]];
    [self.view addSubview: searchBtn];
    
}

#pragma mark --------配置导航栏
-(void)setNavigationTitle
{
   titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width/2+40, 30)];
    titleView.layer.cornerRadius = 2;
    titleView.backgroundColor = [UIColor whiteColor];
    NSArray * arr = @[@"收藏的宝贝",@"收藏的店铺"];
    
    for (int i = 0; i<2; i++) {
        UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.backgroundColor = ZQColor(201, 0, 9);
        btn1.tag = 100+i;
        btn1.titleLabel.font = [UIFont systemFontOfSize:16 ];
        btn1.frame = CGRectMake(2+titleView.width/2*i, 2, titleView.width/2-4, titleView.height-4);
        [btn1 setTitle:arr[i] forState:0];
        [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn1 setTitleColor:ZQColor(201, 0, 9) forState:UIControlStateSelected];
        [btn1 addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:btn1];
    }
    self.navigationItem.titleView = titleView;
    currentSelectBtn = (UIButton *)[titleView viewWithTag:100];
    currentSelectBtn.backgroundColor = [UIColor whiteColor];
    currentSelectBtn.selected = YES;
    self.navigationItem.titleView = titleView;
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.size = CGSizeMake(30, 40);
    [btn setImage:[UIImage imageNamed:@"ziliaogengguoanniu3-4"] forState:0];
    UIBarButtonItem * rithtBar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rithtBar;
}


-(void)selectBtn:(UIButton *)sender
{
    currentSelectBtn.selected = NO;
    currentSelectBtn.backgroundColor = ZQColor(201, 0, 9);
    currentSelectBtn = sender;
    currentSelectBtn.selected = YES;
    currentSelectBtn.backgroundColor = [UIColor whiteColor];
    myScrollView.contentOffset = CGPointMake(self.view.width*(sender.tag-100), 0);
    
    if (sender.tag==100) {
        currentLable.text = @"商品列表";
        _searchBar.placeholder = @"搜索收藏的宝贝...";
        
    }
    else{
        currentLable.text = @"店铺列表";
        _searchBar.placeholder = @"搜索收藏的店铺...";
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x==0) {
        currentLable.text = @"商品列表";
        _searchBar.placeholder = @"搜索收藏的宝贝...";
        
    }
    else{
        currentLable.text = @"店铺列表";
        _searchBar.placeholder = @"搜索收藏的店铺...";
    }
    
    currentSelectBtn.selected = NO;
    currentSelectBtn.backgroundColor = ZQColor(201, 0, 9);
    currentSelectBtn = (UIButton *)[titleView viewWithTag:scrollView.contentOffset.x/self.view.width+100];
    currentSelectBtn.selected = YES;
    currentSelectBtn.backgroundColor = [UIColor whiteColor];
    
    
}

@end
