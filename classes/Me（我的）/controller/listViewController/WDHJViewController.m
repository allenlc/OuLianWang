//
//  WDHJViewController.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/23.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "WDHJViewController.h"
#import "WDHJTableViewCell.h"
#import "UIView+LCView.h"

@interface WDHJViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation WDHJViewController
-(NSMutableArray *)dataArray
{
    if (_dataArray==nil) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"我的皇室";
    [self createTableView];
}

-(void)createTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 588) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;

    [self.view addSubview:_tableView];
    
}
#pragma mark - tableview的数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    
    return 3;//假数据
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    WDHJTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:[WDHJTableViewCell myIdentify]];
    if (cell==nil) {
        cell=[[WDHJTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[WDHJTableViewCell myIdentify]];
    }

    
    cell.iconImageView.image=[UIImage imageNamed:@"toutouxx1.png"];
    [cell.starView setStar:4];
    cell.nameLabel.text=@"小范";
    cell.dateLabel.text=@"2015-06-13";
    cell.shopImageView.image=[UIImage imageNamed:@"img1.png"];
    cell.shopLabel.text=[NSString stringWithFormat:@"店铺: %@",@"保定电谷家具广场"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [WDHJTableViewCell myHeight];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    view1.backgroundColor=[UIColor whiteColor];
    if (section==0) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 120, 30)];
        label.text=@"我的上级代理";
        label.font=[UIFont boldSystemFontOfSize:16];
        [view1 addSubview:label];
    }
    else{
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 120, 30)];
        label.text=@"我的下级代理";
        label.font=[UIFont boldSystemFontOfSize:16];
        [view1 addSubview:label];
        UILabel *lab=[view1 addLabelWithFrame:CGRectMake(250, 5, 60, 20) text:[NSString stringWithFormat:@"%d人",3]];
        lab.font=[UIFont systemFontOfSize:12];
        lab.textAlignment=NSTextAlignmentRight;
        lab.textColor=[UIColor grayColor];
    }
    return view1;
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
