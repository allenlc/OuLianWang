//
//  YuLeViewController.m
//  OuLianWang
//
//  Created by hsmj on 15/7/3.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "YuLeViewController.h"

@interface YuLeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    



}
@end

@implementation YuLeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"娱乐游戏";
    
    [self  creatyuleview];
    
}


-(void)creatyuleview
{
    _tableview=[[UITableView alloc]initWithFrame: CGRectMake(0, 0, 320, 568)];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    [self.view addSubview:_tableview];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     static NSString *cellid=@"zhangxucell";
    UITableViewCell *zxcell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (zxcell==nil) {
        
        zxcell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        
    }

    
    return zxcell;


}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}



-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 140;

}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView  *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 140)];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
    imageView.image=[UIImage imageNamed:@"屏幕快照 2015-07-03 下午2.21.48"];
    
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
    [button1  setTitle:@"游戏排行" forState:UIControlStateNormal];
    button1.frame=CGRectMake(0, 100, self.view.bounds.size.width/2, 40);
    [button1  addTarget:self action:@selector(buttonclick:)forControlEvents:UIControlEventTouchUpInside];
    
    button1.tag=400;
    [view  addSubview:button1];

    UIButton *button2=[UIButton buttonWithType:UIButtonTypeCustom];
    [button2  setTitle:@"好友排名" forState:UIControlStateNormal];
    button2.frame=CGRectMake(self.view.bounds.size.width/2, 100, self.view.bounds.size.width/2, 40);
      button1.tag=401;
    [button2  addTarget:self action:@selector(buttonclick:)forControlEvents:UIControlEventTouchUpInside];
    [view  addSubview:button2];

    return view;
    
    
}


-(void)buttonclick:(UIButton *)button
{
    if (button.tag==400)
    {
        UIButton *but=(UIButton *)[self.view  viewWithTag:401];
        but.backgroundColor=[UIColor grayColor];
        
        button.backgroundColor=[UIColor redColor];
        
    }
    
    if (button.tag==401)
    {
        UIButton *but=(UIButton *)[self.view  viewWithTag:400];
        but.backgroundColor=[UIColor grayColor];
        
        button.backgroundColor=[UIColor redColor];
        
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
