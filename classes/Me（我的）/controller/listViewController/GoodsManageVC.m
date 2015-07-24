//
//  GoodsManageVC.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/6.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "GoodsManageVC.h"
#import "GoodsManagerCell.h"
#import "NewGoodsVC.h"
#import "ServiceTimeCell.h"

@interface GoodsManageVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UIButton * currentBtn;
    UIImageView * topImgView ;
}
@property(nonatomic,strong)UITableView *tableView1;
@property(nonatomic,strong)UITableView * tableView2;
@property(nonatomic,strong)UITableView *tableView3;
@end

@implementation GoodsManageVC
-(void)loadView
{
    [super loadView];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.size = CGSizeMake(30, 40);
    [btn setImage:[UIImage imageNamed:@"ziliaogengguoanniu3-4"] forState:0];
    UIBarButtonItem * rithtBar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rithtBar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品管理";
    [self creatTopBtn];
//    [self createTableView];
    [self createBotView ];
}

-(void)creatTopBtn
{
    
    NSArray * arr = @[@"商品",@"附属商品",@"服务时间"];
    topImgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 69, self.view.width-10, 40)];
    topImgView.layer.cornerRadius = 8;
    topImgView.userInteractionEnabled = YES;
    topImgView.image = [UIImage imageNamed:@"nav01"];
    [self.view addSubview:topImgView];
    for (int i = 0; i<3; i++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame =CGRectMake(topImgView.width/3*i+2, 0, topImgView.width/3-4, 40);
        btn.tag = 100+i;
        [btn setTitle:arr[i] forState:0];
        [btn setTitleColor:ZQColor(250, 49, 15) forState:0];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [topImgView addSubview:btn];
    }
    currentBtn = (UIButton *)[topImgView viewWithTag:100];
    currentBtn.selected = YES;
    [self selectBtn:currentBtn];
}
-(void)selectBtn:(UIButton *)sender
{  topImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"nav0%d",sender.tag-99]];
    currentBtn.selected = NO;
    currentBtn = sender;
    currentBtn.selected = YES;
    switch (sender.tag) {
        case 100://商品
        {
            UIButton * btn = (UIButton *)[self.view viewWithTag:200];
            [btn setTitle:@"发布商品" forState:UIControlStateNormal];

            if (self.tableView1==nil) {
                self.tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topImgView.frame)+5, self.view.width, self.view.height-topImgView.height-110) style:UITableViewStylePlain];
//                self.tableView1.tag = sender.tag;
                self.tableView1.delegate = self;
                self.tableView1.dataSource = self;
                self.tableView1.backgroundColor = ZQColor(239, 239, 239);
            }
             [self.view addSubview:self.tableView1];
            
        }
            break;
        case 101://附属商品
        {
            UIButton * btn = (UIButton *)[self.view viewWithTag:200];
            [btn setTitle:@"发布商品" forState:UIControlStateNormal];

            if (self.tableView2==nil) {
                self.tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topImgView.frame)+5, self.view.width, self.view.height-topImgView.height-110) style:UITableViewStylePlain];
//                self.tableView1.tag = sender.tag;
                self.tableView2.delegate = self;
                self.tableView2.dataSource = self;
                self.tableView2.backgroundColor = ZQColor(239, 239, 239);
            }
            
            [self.view addSubview:self.tableView2];
        }
            break;
        case 102://.服务时间
        {
            UIButton * btn = (UIButton *)[self.view viewWithTag:200];
            [btn setTitle:@"添加时间" forState:UIControlStateNormal];

            if (self.tableView3==nil) {
                self.tableView3 = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topImgView.frame)+5, self.view.width, self.view.height-topImgView.height-110) style:UITableViewStylePlain];
                //                self.tableView1.tag = sender.tag;
                self.tableView3.delegate = self;
                self.tableView3.dataSource = self;
                self.tableView3.backgroundColor = ZQColor(239, 239, 239);
            }
            
            [self.view addSubview:self.tableView3];
        }
            break;
            
        default:
            break;
    }
    
}

-(void)createBotView
{
    NSArray * arr = @[@"发布商品",@"删除所选"];
    NSArray * colorArr = @[ZQColor(82, 136, 17),ZQColor(250, 49, 15)];
    for (int i = 0; i<2; i++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.width/2*i, self.view.height-40, self.view.width/2,40)];
        btn.tag = i+200;
        [btn addTarget:self action:@selector(selectBotBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = colorArr[i];
        [btn setTitleColor:[UIColor whiteColor] forState:0];
        [btn setTitle:arr[i] forState:0];
        [self.view addSubview:btn];
        
    }
}
-(void)selectBotBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 200:
        {
            [self.navigationController pushViewController:[NewGoodsVC new] animated:YES];
        }
            break;
        case 201:
        {
            
        }
            break;
            
        default:
            break;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return 10;//下载数据
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableView1]) {
        GoodsManagerCell * cell = [GoodsManagerCell cellWithTableViewCell:tableView];
        [cell setindexPath:indexPath];
        return cell;
    }
    else if([tableView isEqual:self.tableView2]){
        
        GoodsManagerCell * cell = [GoodsManagerCell cellWithTableViewCell:tableView];
        [cell setindexPath:indexPath];
        return cell;
 
    }
    else{
        
        ServiceTimeCell * cell = [ServiceTimeCell cellWithTableViewCell:tableView];
        return cell;
    }
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        return 110;
    
}
@end
