//
//  LookShopViewController.m
//  OuLianWang
//
//  Created by allenariel on 15/7/7.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "LookShopViewController.h"
#import "LookShopTableViewCell.h"
#import "UIView+LCView.h"
#import "CustomTabBar.h"

@interface LookShopViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    
}
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation LookShopViewController
-(NSMutableArray *)dataArray
{
    if (_dataArray==nil) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"商品被浏览记录";
    [self createTopView];
    [self createTableView];
    [self createBigTwoBtn];
}
-(void)viewWillAppear:(BOOL)animated
{
    CustomTabBar *tabBar=(CustomTabBar*)self.navigationController.tabBarController;
    tabBar.zqTabBar.hidden=YES;
}
-(void)createTopView
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMakeEx(0, 64, 320, 200)];
    [self.view addSubview:view];
    //图片
    [view addImageViewWithFrame:CGRectMakeEx(10, 10, 110, 110) image:@"屏幕快照 2015-07-07 10.42.26"];
    
    UILabel *nn11=[view addLabelWithFrame:CGRectMakeEx(130, 7, 190, 60) text:@"林氏木业布艺沙发可拆洗时尚现代客厅转角布沙发组合家"];
    nn11.numberOfLines=0;
    nn11.font=[UIFont systemFontOfSize:15];
    
    UILabel *pp=[view addLabelWithFrame:CGRectMakeEx(130, 50, 150, 50) text:[NSString stringWithFormat:@"¥ %@",@"3299.00"]];
    pp.textColor=[UIColor redColor];
    pp.font=[UIFont systemFontOfSize:17];
    
    UILabel *latPP=[view addLabelWithFrame:CGRectMakeEx(240, 50, 150, 50) text:[NSString stringWithFormat:@"¥ %@",@"3299.00"]];
    latPP.textColor=[UIColor grayColor];
    latPP.font=[UIFont systemFontOfSize:14];
    
    UILabel *cc=[view addLabelWithFrame:CGRectMakeEx(130, 88, 150, 15) text:[NSString stringWithFormat:@"分类： %@",@"家具"]];
    cc.textColor=[UIColor grayColor];
    cc.font=[UIFont systemFontOfSize:12];
    
    UILabel *save=[view addLabelWithFrame:CGRectMakeEx(130, 105, 150, 15) text:[NSString stringWithFormat:@"库存： %@",@"60"]];
    save.textColor=[UIColor grayColor];
    save.font=[UIFont systemFontOfSize:12];

}
-(void)createBigTwoBtn
{
    NSArray *titleArr=@[@"发送促销信息",@"发送活动信息"];
    NSArray *colorArr=@[ZQColor(79, 132, 17),ZQColor(229, 47, 36)];
    
    for (int i=0; i<2; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(self.view.frame.size.width/2*i, self.view.frame.size.height-50, self.view.frame.size.width/2, 50);
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:colorArr[i]];
        [self.view addSubview:btn];
    }
}

-(void)createTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMakeEx(0, 64+140, 320, 324) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
}
#pragma mark - tableview的数据源方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.dataArray.count;
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    LookShopTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:[LookShopTableViewCell myIdentify]];
    if (cell==nil) {
        cell=[[LookShopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[LookShopTableViewCell myIdentify]];
    }
    cell.iconImageView.image=[UIImage imageNamed:@"屏幕快照 2015-07-07 10.29.30.png"];
    cell.nameLabel.text=@"余小姐";
    cell.timeLabel.text=@"2015-06-31 12:36";
    [cell setChatBlock:^{
        //聊天
    }];
    [cell setCallBlock:^{
        //打电话
    }];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
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
