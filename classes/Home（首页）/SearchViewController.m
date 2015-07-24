
//
//  SearchViewController.m
//  OuLianWang
//
//  Created by allenariel on 15/6/29.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "SearchViewController.h"
#import "UIView+LCView.h"
#import "MyDatabaseQueue.h"

@interface SearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    BOOL _whichShow;
}
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *HisArray;

@end

@implementation SearchViewController
-(NSMutableArray *)dataArray
{
    if (_dataArray==nil) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray *)HisArray
{
    if (_HisArray==nil) {
        _HisArray=[NSMutableArray array];
        MyDatabaseQueue *que=[MyDatabaseQueue shareInstance];
        NSArray *array=[que getAllDataWithRecordType:RecordTypeHis];
        [_HisArray addObjectsFromArray:array];
    }
    return _HisArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _whichShow=NO;
    [self createBar];
    [self createTableView];
}
-(void)createBar
{
    self.searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    _searchBar.delegate=self;
    _searchBar.placeholder=@"搜索我连店铺/商品";
    self.navigationItem.titleView=self.searchBar;
    
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"搜索" forState:UIControlStateNormal];
    button.frame=CGRectMakeEx(0, 0, 40, 30);
    [button addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *searchBtn=[[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem=searchBtn;
    
    // 调整 leftBarButtonItem 在 iOS7 下面的位置
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0))
    {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                       target:nil action:nil];
        negativeSpacer.width = -15;//这个数值可以根据情况自由变化
        self.navigationItem.rightBarButtonItems = @[negativeSpacer, searchBtn];
    }else
        self.navigationItem.rightBarButtonItem = searchBtn;
}
#pragma mark - 搜索点击
-(void)searchClick
{
    MyDatabaseQueue *queue=[MyDatabaseQueue shareInstance];
    if (!self.searchBar.text.length>0) {
        return;
    }
    
    if([queue isExistsWithHis:self.searchBar.text recordType:RecordTypeHis])
    {
        [queue deleteHis:_searchBar.text recordType:RecordTypeHis];
    }
    [queue addHis:_searchBar.text recordType:RecordTypeHis];
    [self.navigationItem.titleView endEditing:YES];
}

#pragma mark - 创建tableView
-(void)createTableView
{
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
}
#pragma mark - tableview的数据源方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_whichShow) {
        return self.dataArray.count;
    }
    return self.HisArray.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID=@"abc";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.backgroundColor=ZQColor(231, 233, 234);
    if (!_whichShow) {
        cell.textLabel.text=self.HisArray[self.HisArray.count-1-indexPath.row];
    }
    
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_whichShow) {
        return nil;
    }
    else{
        UIView *view=[[UIView alloc]initWithFrame:CGRectMakeEx(0, 0, 320, 170)];
        view.backgroundColor=ZQColor(231, 233, 234);
        NSArray *arr=@[@"手机",@"沙发",@"电脑椅",@"充电宝",@"电风扇",@"转椅"];
        UILabel *la=[view addLabelWithFrame:CGRectMakeEx(10, 5, 100, 30) text:@"热门搜索"];
        la.font=[UIFont boldSystemFontOfSize:15];
        int x=10,y=35;
        for (int i=0; i<6; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            if (i%3==0&&i!=0) {
                y+=40;
                x=10;
            }
            btn.frame=CGRectMakeEx(x, y, 85, 30);
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.backgroundColor=[UIColor whiteColor];
            btn.titleLabel.font=[UIFont systemFontOfSize:14];
            btn.layer.borderWidth=0.1;
            btn.layer.cornerRadius=5;
            [view addSubview:btn];
            x+=105;
        }
        [view addImageViewWithFrame:CGRectMakeEx(10, 120, 300, 2) image:@"line2line2.png"];
        
        UILabel *la2=[view addLabelWithFrame:CGRectMakeEx(10, 125, 100, 30) text:@"搜索历史"];
        la2.font=[UIFont boldSystemFontOfSize:15];
        
        UIButton *clearBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        clearBtn.frame=CGRectMakeEx(210, 130, 100, 35);
        clearBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [clearBtn setTitle:@"清除搜索历史" forState:UIControlStateNormal];
        [clearBtn addTarget:self action:@selector(clearHis) forControlEvents:UIControlEventTouchUpInside];
        clearBtn.backgroundColor=ZQColor(132, 133, 134);
        clearBtn.layer.cornerRadius=8;
        [view addSubview:clearBtn];
        return view;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_whichShow) {
        return 40;
    }
    return 175;
}
#pragma mark - 清除历史搜索记录
-(void)clearHis
{
    MyDatabaseQueue *que=[MyDatabaseQueue shareInstance];
    [que deleteAllHis:RecordTypeHis];
    [self.HisArray removeAllObjects];
    [_tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.navigationController.navigationBar endEditing:YES];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.navigationController.navigationBar endEditing:YES];

}


@end
