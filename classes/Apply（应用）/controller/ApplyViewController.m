//
//  ApplyViewController.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/13.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "ApplyViewController.h"
#import "ApplyTableViewCell.h"
#import "ApplyModel.h"
#import "DiQuListViewController.h"
#import "ShakeViewController.h"
#import "SaoViewController.h"
#import "WXViewController.h"
#import "MoreViewController.h"
#import "YouXiViewController.h"
#import "jianKViewController.h"
#import "QuestionController.h"
#import "OLWTabBarController.h"


@interface ApplyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation ApplyViewController
-(NSMutableArray *)dataArray
{
    if (_dataArray==nil) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}

-(void)viewWillAppear:(BOOL)animated
{
    OLWTabBarController *tabbar=(OLWTabBarController *)self.tabBarController;
    tabbar.zqTabBar.hidden=NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    self.title=@"应用";
}


-(void)createTableView
{
    
    
    
    int i=0;
    if (self.view.bounds.size.height==480) {
        i=420;
    }
    if (self.view.bounds.size.height==568) {
        i=510;;
    }
    if (self.view.bounds.size.height==667) {
         i=600;
    }
    if (self.view.bounds.size.height==736) {
         i=650;
    }
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, i) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.dataSource=self;
//    _tableView.contentSize=CGSizeMake(320, 450);
    [self.view addSubview:_tableView];
    [self createData];
}

#pragma mark - 获取数据
-(void)createData
{
    
    NSString *str=[[NSBundle mainBundle]pathForResource:@"applyPlist.plist" ofType:nil];
    NSArray *arr=[NSArray arrayWithContentsOfFile:str];
    for (NSDictionary *dict in arr) {
        ApplyModel *model=[[ApplyModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [self.dataArray addObject:model];
    }
    
}
#pragma mark - tableview的数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    return 2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section==0)
    {
        WXViewController *wxcontroller=[[WXViewController alloc]init];
        [self.navigationController  pushViewController:wxcontroller animated:YES];
    }
    
    if (indexPath.section==1&&indexPath.row==0) {
        QuestionController *svc=[[QuestionController alloc]init];
        [self.navigationController pushViewController:svc animated:YES];
    }
    if (indexPath.section==1&&indexPath.row==1) {
        
         jianKViewController*jkvc=[[jianKViewController alloc]init];
        [self.navigationController pushViewController:jkvc animated:YES];
    }
    
    if (indexPath.section==2&&indexPath.row==0) {
        ShakeViewController *svc=[[ShakeViewController alloc]init];
        [self.navigationController pushViewController:svc animated:YES];
    }
    if (indexPath.section==2&&indexPath.row==1) {
        SaoViewController *ssvc=[[SaoViewController alloc]init];
        [self.navigationController pushViewController:ssvc animated:YES];
    }
    if(indexPath.section==3&&indexPath.row==0)
    {
        YouXiViewController *yulecontroller=[[YouXiViewController alloc]init];
        [self.navigationController  pushViewController:yulecontroller animated:YES];
       
    }
    if(indexPath.section==3&&indexPath.row==1)
    {
        MoreViewController *morecontroller=[[MoreViewController alloc]init];
        [self.navigationController pushViewController:morecontroller animated:YES];
        
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ApplyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:[ApplyTableViewCell myIdentify]];
    if (cell==nil) {
        cell=[[ApplyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ApplyTableViewCell myIdentify]];
    }
    int x;
    x=(int)(indexPath.section*2-1+indexPath.row);
    if (x<0) {
        x=0;
    }
    ApplyModel *mm=self.dataArray[x];
    if (indexPath.section==0) {
        cell.lineImageView.frame=CGRectMake(66, 30, 150, 1);
        cell.lookImageView.image=[UIImage imageNamed:@"美女.png"];
    }
    [cell.iconImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",mm.nameLabel]]];
    cell.nameLabel.text=mm.nameLabel;
    cell.moreLabel.text=mm.moreLabel;

    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 59;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 3;
}


@end
