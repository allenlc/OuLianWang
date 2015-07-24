//
//  HYWanViewController.m
//  OuLianWang
//
//  Created by hsmj on 15/7/4.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "HYWanViewController.h"

@interface HYWanViewController ()<UITableViewDataSource,UITableViewDelegate>
{
   UIView  *view;
    UITableView *twotableview;
}
@end

@implementation HYWanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self deplynavigationcontroller];
    
    [self  creattopview];
    
    [self  creattableviwe];
}


-(void)deplynavigationcontroller
{

    self.title=@"娱乐游戏";
    
    UIButton *button11=[UIButton buttonWithType:UIButtonTypeCustom];
    [button11  setImage:[UIImage  imageNamed:@"搜索图标.png"] forState:UIControlStateNormal];
    button11.frame=CGRectMake(0,0,20,20);
    UIBarButtonItem *right1=[[UIBarButtonItem alloc]initWithCustomView:button11];
    
    
    UIButton *button22=[UIButton buttonWithType:UIButtonTypeCustom];
    [button22  setImage:[UIImage  imageNamed:@"竖三点(1).png"] forState:UIControlStateNormal];
    button22.frame=CGRectMake(10,0,15, 30);
    UIBarButtonItem *right2=[[UIBarButtonItem alloc]initWithCustomView:button22];
    
    self.navigationItem.rightBarButtonItems=@[right2,right1];
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0))
        
    {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                       target:nil action:nil];
        negativeSpacer.width = -10;//这个数值可以根据情况自由变化
        self.navigationItem.rightBarButtonItems = @[negativeSpacer, right2,right1];
    }
    else
        
        self.navigationItem.rightBarButtonItems=@[right2,right1];
    


}

-(void)creattopview
{
    view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 120)];
    UIImageView  *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 80, 80)];
    imageview.image=[UIImage imageNamed:@"zxzxzxzxzx.png"];
    [view  addSubview:imageview];
    
    UILabel *mingziLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 20, 80, 30)];
    mingziLabel.text=@"张大旭";
    mingziLabel.font=[UIFont boldSystemFontOfSize:16];
    [view  addSubview:mingziLabel];
    
    UILabel * _geshulabel=[[UILabel alloc]initWithFrame:CGRectMake(90,53, 150, 20)];
    _geshulabel.textColor=[UIColor grayColor];
    _geshulabel.textAlignment=NSTextAlignmentLeft;
    _geshulabel.font=[UIFont  systemFontOfSize:13];
    [view addSubview:_geshulabel];

}


-(void)creattableviwe
{

    twotableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    twotableview.dataSource=self;
    twotableview.delegate=self;
    twotableview.tableHeaderView=view;
    [self.view  addSubview:twotableview];
    

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 20;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView  dequeueReusableCellWithIdentifier:nil];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
    }

    if (indexPath.row==0)
    {
        cell.textLabel.text=@"最近在玩的游戏";
        
    }
    else
    {
        UIImageView  *_imageview=[[UIImageView alloc]init];
        _imageview=[[UIImageView alloc]initWithFrame:CGRectMake(20,10,60,60)];
        _imageview.layer.cornerRadius=5;
        _imageview.layer.masksToBounds=YES;
        [cell  addSubview:_imageview];
        
        UILabel *_titltlabel=[[UILabel alloc]initWithFrame:CGRectMake(90,6,150, 30)];
        _titltlabel.font=[UIFont  boldSystemFontOfSize:16];
        _titltlabel.text=@"嗒嗒嗒答";
        [cell  addSubview:_titltlabel];
        
        UILabel * _geshulabel=[[UILabel alloc]initWithFrame:CGRectMake(90,53, 150, 20)];
        _geshulabel.textColor=[UIColor grayColor];
        _geshulabel.textAlignment=NSTextAlignmentLeft;
        _geshulabel.font=[UIFont  systemFontOfSize:13];
        _geshulabel.text=[NSString  stringWithFormat:@"最高分:%@",@"200万"];
        [cell  addSubview:_geshulabel];
        
        UIButton * _xiazaibutton=[UIButton  buttonWithType:UIButtonTypeSystem];
        _xiazaibutton.frame=CGRectMake(230, 30, 60, 30);
        _xiazaibutton.layer.borderWidth=1;
        _xiazaibutton.layer.borderColor=[UIColor grayColor].CGColor;
        _xiazaibutton.layer.cornerRadius=5;
        _xiazaibutton.layer.masksToBounds=YES;
        [_xiazaibutton  setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_xiazaibutton  setTitle:@"下载" forState:UIControlStateNormal];
        _xiazaibutton.titleLabel.font=[UIFont  boldSystemFontOfSize:18];
        [cell  addSubview:_xiazaibutton];
    
    }
    
   
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
    
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
