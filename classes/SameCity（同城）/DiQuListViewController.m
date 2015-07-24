//
//  DiQuListViewController.m
//  OuLianWang
//
//  Created by hsmj on 15/6/22.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "DiQuListViewController.h"

@interface DiQuListViewController ()<UITableViewDataSource,UITableViewDelegate>
{

    UITableView *_tableView;
    UIView *_DiQuview;

}
@end

@implementation DiQuListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self  deplyNavigationController];
    
    [self  diquButtonClick];
    
}


-(void)deplyNavigationController
{
    
    self.navigationController.navigationBar.barTintColor=[UIColor redColor];
    self.navigationItem.title=@"城市选择列表";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]}];


    UIButton *diqubutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [diqubutton  setImage:[UIImage imageNamed:@"返回箭头.png"] forState:UIControlStateNormal];
    [diqubutton  addTarget:self action:@selector(listButtonClick
                                                 ) forControlEvents:UIControlEventTouchUpInside];
    diqubutton.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    diqubutton.frame=CGRectMake(0, 0,20,20);
    UIBarButtonItem *leftbutton=[[UIBarButtonItem alloc]initWithCustomView:diqubutton];
    
    // 调整 leftBarButtonItem 在 iOS7 下面的位置
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0))
        
    {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                 target:nil action:nil];
        negativeSpacer.width = -0;//这个数值可以根据情况自由变化
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftbutton];
    }
    else
        
        self.navigationItem.leftBarButtonItem = leftbutton;
    
    
//    // 调整 leftBarButtonItem 在 iOS7 下面的位置
//    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0))
//        
//    {
//        UIBarButtonItem *ne1gativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
//                                                                                        target:nil action:nil];
//        ne1gativeSpacer.width = -10;//这个数值可以根据情况自由变化
//        self.navigationItem.rightBarButtonItems = @[ne1gativeSpacer, rightbutton];
//    }
//    else
//        
//        self.navigationItem.rightBarButtonItem = rightbutton;
    
}


-(void)listButtonClick
{
    [self.navigationController  popToRootViewControllerAnimated:YES];
    
}




#pragma mark----------创建城市选择TableView
-(void)diquButtonClick
{
    
        _DiQuview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
        [self.view  addSubview:_DiQuview];
        _DiQuview.backgroundColor=[UIColor  whiteColor];
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,320, 568) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_DiQuview  addSubview:_tableView];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 34;
    //  23个省、4个直辖市、2个特别行政区、5个自治区。
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"dingwei";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        
    }
    
    return cell;
    
}

//设置每一组的头部标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"第%d组",section];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.navigationController  popToRootViewControllerAnimated:YES];
    
}
//设置每一组的尾部标题
//-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
//{
//    return [NSString stringWithFormat:@"第%d组结束",section];
//}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    return 80;
//}



-(void)callModalList
{
    
    NSLog(@"发布");
    
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
