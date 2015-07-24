//
//  XiaoXiViewController.m
//  OuLianWang
//
//  Created by hsmj on 15/7/8.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "XiaoXiViewController.h"
#import "OLWTabBarController.h"

@interface XiaoXiViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableview;
    NSArray *_titleArray;
    UIImageView  *imageview;
    UIImageView  *imageview2;
    
    
}
@end

@implementation XiaoXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"消息提醒";
    
    
    _titleArray=@[@"消息震动",@"声音提醒"];
    
    
    [self  creatUI];
    
    
    
}


-(void)creatUI
{
    
   
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    [self setExtraCellLineHidden:_tableview];
    [self.view  addSubview:_tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
     return   2;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static   NSString *strcell=@"strcell";
    UITableViewCell *cell=[tableView   dequeueReusableCellWithIdentifier:strcell];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
    }
    cell.textLabel.text=_titleArray[indexPath.row];
//
    cell.selectionStyle=0;
    if (indexPath.row==0)
    {
        
        imageview=[[UIImageView alloc]initWithFrame:CGRectMake(230, 10, 80, 24)];
        imageview.image=[UIImage imageNamed:@"open"];
        imageview.userInteractionEnabled=YES;
        [cell  addSubview:imageview];
        
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"开" forState:UIControlStateNormal];
        button.frame=CGRectMake(0, 0, 40, 24);
        button.tag=400;
        [button  addTarget:self action:@selector(buttonclicl:) forControlEvents:UIControlEventTouchUpInside];
        [imageview  addSubview:button];
        
        UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
        [button1 setTitle:@"关" forState:UIControlStateNormal];
        button1.frame=CGRectMake(40, 2,38, 20);
        button1.tag=401;
        [button1  addTarget:self action:@selector(button1clicl:) forControlEvents:UIControlEventTouchUpInside];
        [imageview  addSubview:button1];
        
    }
    
    if (indexPath.row==1)
    {
        
        imageview2=[[UIImageView alloc]initWithFrame:CGRectMake(230, 10, 80, 24)];
        imageview2.image=[UIImage imageNamed:@"open"];
        imageview2.userInteractionEnabled=YES;
        [cell  addSubview:imageview2];
        
        UIButton *button3=[UIButton buttonWithType:UIButtonTypeCustom];
        [button3 setTitle:@"开" forState:UIControlStateNormal];
        button3.frame=CGRectMake(0, 0, 40, 24);
        button3.tag=402;
        [button3  addTarget:self action:@selector(button2clicl:) forControlEvents:UIControlEventTouchUpInside];
        [imageview2  addSubview:button3];
        
        UIButton *button11=[UIButton buttonWithType:UIButtonTypeCustom];
        [button11 setTitle:@"关" forState:UIControlStateNormal];
        button11.frame=CGRectMake(40, 2,38, 20);
        button11.tag=403;
        [button11  addTarget:self action:@selector(button3clicl:) forControlEvents:UIControlEventTouchUpInside];
        [imageview2  addSubview:button11];
        
    }

    
    
    return cell;
}


- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


-(void)buttonclicl:(UIButton *)but
{
    
    imageview.image=[UIImage imageNamed:@"open"];
    

}

-(void)button1clicl:(UIButton *)but
{
    
    imageview.image=[UIImage imageNamed:@"colse"];
    
    
}


-(void)button2clicl:(UIButton *)but
{
    
    imageview2.image=[UIImage imageNamed:@"open"];
    
}

-(void)button3clicl:(UIButton *)but

{
    
    imageview2.image=[UIImage imageNamed:@"colse"];
    
}



-(void)viewWillAppear:(BOOL)animated
{
    OLWTabBarController *tabbarcontroller=(OLWTabBarController *)self.tabBarController;
    tabbarcontroller.zqTabBar.hidden=YES;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    OLWTabBarController *tabbarcontroller=(OLWTabBarController *)self.tabBarController;
    tabbarcontroller.zqTabBar.hidden=YES;
    
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
