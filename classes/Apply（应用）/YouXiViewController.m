//
//  YouXiViewController.m
//  OuLianWang
//
//  Created by hsmj on 15/7/3.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "YouXiViewController.h"
#import "YouXiTableViewCell.h"
#import "YOUXICell.h"

@interface YouXiViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *onetableview;
    UITableView *twotableview;
    UIView  *view;
    UIButton *button1;
    UIButton *button2;
}
@end

@implementation YouXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    
       [self  creattopview];
    
       [self  creattableviwe];
    
    
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
    if (button1.selected==YES)
    {
        static   NSString *cellidone=@"zhangxuonecell";
        YOUXICell *zxcell1=[tableView  dequeueReusableCellWithIdentifier:cellidone];
        if (zxcell1==nil)
        {
            zxcell1=[[YOUXICell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidone];
        }
        
        zxcell1.imageview.image=[UIImage imageNamed:@"u=2054005613,1190378297&fm=21&gp=0.jpg"];
        zxcell1.typeabel.backgroundColor=ZQColor(43, 222, 154);
        zxcell1.typeabel.text=@"格斗";
        zxcell1.titltlabel.text=@"穿越奥特曼";
        zxcell1.geshulabel.text=[NSString  stringWithFormat:@"有%d个好友在玩",3];
        
        UIButton * _xiazaibutton=[UIButton  buttonWithType:UIButtonTypeSystem];
        _xiazaibutton.frame=CGRectMake(230, 30, 60, 30);
        _xiazaibutton.layer.borderWidth=1;
        _xiazaibutton.layer.borderColor=[UIColor grayColor].CGColor;
        _xiazaibutton.layer.cornerRadius=5;
        _xiazaibutton.layer.masksToBounds=YES;
        [_xiazaibutton  setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_xiazaibutton  setTitle:@"下载" forState:UIControlStateNormal];
        _xiazaibutton.titleLabel.font=[UIFont  boldSystemFontOfSize:18];
        [zxcell1  addSubview:_xiazaibutton];
        return zxcell1;
    }
    if (button2.selected==YES)
    {
    static   NSString *cellid=@"zhangxucell";
    YouXiTableViewCell *zxcell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if ( zxcell==nil)
    {
        zxcell=[[YouXiTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        
    }
    zxcell.mingzilabel.text=@"李聪思密达";
    zxcell.iamgeview.image=[UIImage  imageNamed:@"mao@2x.jpg"];
    zxcell.mingciiamge.image=[UIImage imageNamed:@"mao@2x.jpg"];
    zxcell.fenshulabel.text=@"123,213";
    zxcell.geshulabel.text=@"最近在玩100个游戏";
    return zxcell;
        
    }
    
    return
    
         nil;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;

}

-(void)creattopview
{
    
    view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 140)];
    UIImageView  *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
    imageview.image=[UIImage imageNamed:@"zxzxzxzxzx.png"];
    [view  addSubview:imageview];

     NSArray *titArray=@[@"游戏排行 ",@"好友排行"];
   
        button1=[UIButton buttonWithType:UIButtonTypeCustom];
        [button1 setTitle:titArray[0 ] forState:UIControlStateNormal];
        button1.titleLabel.font=[UIFont  boldSystemFontOfSize:20];
        button1.tag=400+0;
        button1.selected=YES;
        button1.backgroundColor=[UIColor redColor];
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button1  addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
        button1.frame=CGRectMake(self.view.bounds.size.width/2*0, 100, self.view.bounds.size.width/2, 40);
        [view  addSubview:button1];
        
        button2=[UIButton buttonWithType:UIButtonTypeCustom];
        [button2 setTitle:titArray[1 ] forState:UIControlStateNormal];
        button2.titleLabel.font=[UIFont  boldSystemFontOfSize:20];
        button2.tag=400+1;
        button2.backgroundColor=[UIColor grayColor];
        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button2  addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
        button2.frame=CGRectMake(self.view.bounds.size.width/2*1, 100, self.view.bounds.size.width/2, 40);
        [view  addSubview:button2];
    
    
    
}

-(void)buttonclick:(UIButton *)button
{
    
    if (button.tag==400)
    {
        button2.selected=NO;
        button1.selected=YES;
        UIButton *but=(UIButton *)[self.view  viewWithTag:401];
        but.backgroundColor=[UIColor grayColor];
        button.backgroundColor=[UIColor  redColor];
        [twotableview  reloadData];
       
    }
    
    if (button.tag==401)
    {
        UIButton *but=(UIButton *)[self.view  viewWithTag:400];
        but.backgroundColor=[UIColor grayColor];
        button.backgroundColor=[UIColor  redColor];
        button2.selected=YES;
        button1.selected=NO;
        [twotableview  reloadData];
     }
    
 

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
