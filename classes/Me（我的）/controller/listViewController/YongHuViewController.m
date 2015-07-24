//
//  YongHuViewController.m
//  OuLianWang
//
//  Created by hsmj on 15/7/7.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "YongHuViewController.h"
#import "PinJiaTableViewCell.h"
#import "UILabel+StringFrame.h"

@interface YongHuViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *_tableview;
    int h;
    UIImageView *view;
}
@end

@implementation YongHuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.title=@"用户评价";
    
    [self  creatUI];
    
    [self  creatfootview];
    
    
    
    
}

-(void)creatUI
{
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, -35, 320, 608) style:UITableViewStyleGrouped];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    [self.view  addSubview:_tableview];
    
    

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
       static NSString *onecellid=@"onecellid";
        UITableViewCell *cell=[tableView  dequeueReusableCellWithIdentifier:onecellid];
        if (cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:onecellid];
            
        }
        
        
        NSArray *array=@[@"好评",@"中评",@"差评"];
        view=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        view.image=[UIImage  imageNamed:@"shangpinguanlixbj01"];
        view.userInteractionEnabled=YES;
        [cell  addSubview:view];
        for (int i=0; i <3; i++)
        {
            UIButton   *button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=CGRectMake(320/3*i, 0, 320/3, 40);
            [button  setTitle:array[i] forState:UIControlStateNormal];
            [button  setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [button  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button  addTarget:self action:@selector(buttonclck:) forControlEvents:UIControlEventTouchUpInside];
            button.tag=400+i;
            if (button.tag==400)
            {
                button.selected=YES;
            }
            [view addSubview:button];
            
        }
        
        return cell;
    }
    
    else
        
    {
        static  NSString *twocell=@"twocellid";
        PinJiaTableViewCell *pincell=[tableView  dequeueReusableCellWithIdentifier:twocell];
        if (pincell==nil)
        {
            pincell=[[PinJiaTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:twocell];
            
        }
        
        NSArray  *array=@[@"的骄傲的跌大会阿迪后爱德华到诶回到号机会的冯绍",@"的骄傲的跌大会阿迪后爱德华到诶回到号机会的冯绍峰分数分数分数分数费时费工发沙发发发发发发发而发而发发疯",@"的骄傲的跌大会阿迪后爱德华",@"的骄傲的跌大会阿迪后爱德华到诶回到号机会的冯绍"];
        
        
        pincell.imageview.image=[UIImage  imageNamed:@"reqwre"];
        pincell.mingzilabel.text=@"李聪欧巴";
        pincell.titlelabel.text=array[indexPath.row-1];
        pincell.shijianlabel.text=@"2015-06-12 12:45";
        
        // 根据获取到的字符串以及字体计算label需要的size
        CGSize size = [pincell.titlelabel  boundingRectWithSize:CGSizeMake(220, 0)];
        h=size.height;
        // 设置label的frame
        
        pincell.titlelabel.frame = CGRectMake(80,25, size.width, size.height);
        
        pincell.shijianlabel.frame=CGRectMake(80,size.height+35,150,20);
        
        pincell.Huibutton.frame=CGRectMake(210, size.height+35, 60, 20);
        
        pincell.anniuButton.frame=CGRectMake(285, size.height+30,25,25);
        
        
        return pincell;
    
    }
    
    return nil;
 

}



-(void)buttonclck:(UIButton *)butt
{
    for (int i=400; i<403; i++)
    {
        UIButton *button=(UIButton *)[self.view  viewWithTag:i];
        button.selected=NO;
    }
    butt.selected=YES;
    
    if (butt.tag==400)
    {
        view.image=[UIImage  imageNamed:@"shangpinguanlixbj01"];
        
    }
    if (butt.tag==401)
    {
        view.image=[UIImage  imageNamed:@"shangpinguanlixbj02"];

        
    }
    if (butt.tag==402)
    {
        view.image=[UIImage  imageNamed:@"shangpinguanlixbj03"];

        
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==0)
    {
        return 40;
    }
    else
        
        return h+80;

}

-(void)creatfootview
{
    UIView  *View=[[UIView alloc]initWithFrame:CGRectMake(0, 508, 320, 60)];
    View.backgroundColor=ZQColor(220, 220, 220);
    [self.view  addSubview:View];
    
    UIButton   *button=[UIButton  buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(40, 10, 240, 40);
    button.backgroundColor=[UIColor  redColor];
    [button  setTitle:@"删除所有" forState:UIControlStateNormal];
    [button  setTitleColor:[UIColor   whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont  boldSystemFontOfSize:18];
    button.titleLabel.textAlignment=1;
    [View  addSubview:button];

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
