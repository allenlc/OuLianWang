//
//  jianKViewController.m
//  OuLianWang
//
//  Created by hsmj on 15/6/26.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "jianKViewController.h"
#import "jiamKTableViewCell.h"


@interface jianKViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    
}

@end

@implementation jianKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self deplyNavigationController1];
    
  
    [self creattableview];
    
    
}
#pragma mark----配置导航栏
-(void)deplyNavigationController1
{
    

    self.navigationItem.title=@"健康知识";
  

}


-(void)listButtonClick
{
    [self.navigationController  popViewControllerAnimated:YES];
    
}



-(void)btnClick:(UIButton *)btn
{
    NSLog(@"点击");
}



#pragma mark------------创建tableview
-(void)creattableview
{
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 600) style:UITableViewStylePlain];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    [self.view  addSubview:_tableview];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        return 1;
    }
    else
    return 30;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        jiamKTableViewCell *jcell=[tableView dequeueReusableCellWithIdentifier:nil];
        if(jcell==nil)
        {
            jcell=[[jiamKTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            jcell.selectionStyle=0;
        }
        return jcell;
    }
    else
    {
    UITableViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:nil];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
    }
        return cell;
    }
    
    return nil;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return 130;
    }
    else
        return 40;

}

#pragma mark---------创建第二组的头视图

//  下面的这两个方法必须一起使用
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return 40;
    }
     return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1)
    {
        
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        NSArray *array=@[@"全部分类",@"等我来答",@"我的任务"];
        for(int i=0;i<3;i++)
        {
                UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
                [button  setTitle:array[i] forState:UIControlStateNormal];
                [button  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button  setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
                button.titleLabel.font=[UIFont  systemFontOfSize:14];
                button.layer.borderWidth=0.5;
                [button  addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                 button.layer.borderColor=ZQColor(220, 220, 220).CGColor;
                button.frame=CGRectMake(320/3*i,0, 320/3, 40);
                button.backgroundColor=[UIColor redColor];
                [view1 addSubview:button];
                button.tag=280+i ;
                button.selected=NO;
            
            if ( button.tag==280) {
                button.selected=YES;
                button.backgroundColor=[UIColor  whiteColor];
            }
        
        }
        
        return view1;
        
    }

    
    else
        return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(indexPath.row==0)
//    {
//        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    
//    }
    
    
}



-(void)buttonClick:(UIButton *)but
{
    for(int i=280;i<283;i++)
    {
        UIButton *bu=(UIButton *)[self.view viewWithTag:i];
        bu.selected=NO;
        bu.backgroundColor=[UIColor redColor];
    }
    but.selected=YES;
    but.backgroundColor=[UIColor whiteColor];

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
