//
//  ShuJViewController.m
//  OuLianWang
//
//  Created by hsmj on 15/7/7.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "ShuJViewController.h"
#import "ShuJuTableViewCell.h"

@interface ShuJViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView  *Bobyimageview;
    UITableView  *_tableview;
}
@end

@implementation ShuJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title=@"数据分析";
    
    [self  cteatUI];
    
    [self creattableview];
}

-(void)cteatUI
{
    
    UIImageView  *Topimageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, 320, 120)];
    Topimageview.image=[UIImage imageNamed:@"title01"];
    [self.view  addSubview:Topimageview];
    
    Bobyimageview=[[UIImageView alloc]initWithFrame:CGRectMake(0,184, 320, 508-184)];
    Bobyimageview.image=[UIImage imageNamed:@"Background"];
    Bobyimageview.userInteractionEnabled=YES;
    [self.view  addSubview:Bobyimageview];
    
    UIImageView  *Footimageview=[[UIImageView alloc]initWithFrame:CGRectMake(0,508, 320,60)];
    Footimageview.image=[UIImage imageNamed:@"bottom"];
    Footimageview.userInteractionEnabled=YES;
    [self.view  addSubview:Footimageview];
    
    
    UIImageView  *Footxioaview=[[UIImageView alloc]initWithFrame:CGRectMake(150,20, 30,30)];
    Footxioaview.image=[UIImage imageNamed:@"Arrow"];
    Footxioaview.userInteractionEnabled=YES;
    [Footimageview addSubview:Footxioaview];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"查看历史记录" forState:UIControlStateNormal];
    button.frame=CGRectMake(190,20,120, 30);
    button.titleLabel.font=[UIFont  boldSystemFontOfSize:17];
    [button  setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button  addTarget:self action:@selector(buttonclick) forControlEvents:UIControlEventTouchUpInside];
    [Footimageview addSubview:button];
}

-(void)buttonclick
{
    NSLog(@"查看历史记录");
}


-(void)creattableview
{
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(10, 10, 300, 506-184)];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    [Bobyimageview  addSubview:_tableview];


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"cellid";
    ShuJuTableViewCell *cell=[tableView  dequeueReusableCellWithIdentifier:cellid];
    if (cell==nil)
    {
        cell=[[ShuJuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        
    }
    cell.imageviwe.image=[UIImage imageNamed:@"zhangxu"];
    cell.titleLabel.text=@"憨豆一韩版2015吓唬做菜吃噶段高速服饰广场负的风格深度覆盖速度发广告";
    cell.chenjLabel.text=@"成交量:200";
    cell.liulLabel.text=@"浏览次数:600";
    cell.fensLabel.text=@"50%";
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;

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
