//
//  JianKangController.m
//  OuLianWang
//
//  Created by hsmj on 15/6/25.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "JianKangController.h"

@interface JianKangController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;

}
@end

@implementation JianKangController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self deplyNavigationController];
    
    [self  creatButton];
    
    [self creatSegmentAndMap];
    
    [self creattableview];
}

#pragma mark----配置导航栏
-(void)deplyNavigationController
{
    
    self.navigationController.navigationBar.barTintColor=[UIColor redColor];
    self.navigationItem.title=@"";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]}];
      UIButton *fabubutton=[UIButton buttonWithType:UIButtonTypeCustom];
      [fabubutton  setTitle:@"筛选" forState:UIControlStateNormal];
      [fabubutton  setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
      fabubutton.titleLabel.font=[UIFont boldSystemFontOfSize:18];
      fabubutton.frame=CGRectMake(0, 0, 50, 50);
      UIBarButtonItem *rightbutton=[[UIBarButtonItem alloc]initWithCustomView:fabubutton];
    
    
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
    
    
        // 调整 leftBarButtonItem 在 iOS7 下面的位置
        if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0))
    
        {
            UIBarButtonItem *ne1gativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                            target:nil action:nil];
            ne1gativeSpacer.width = -10;//这个数值可以根据情况自由变化
            self.navigationItem.rightBarButtonItems = @[ne1gativeSpacer, rightbutton];
        }
        else
    
            self.navigationItem.rightBarButtonItem = rightbutton;
    
}


-(void)listButtonClick
{
    [self.navigationController  popToRootViewControllerAnimated:YES];
    
}




#pragma mark －－－－－ 创建顶部两个Button
-(void)creatButton
{
    NSArray *titltArray=@[@"咨询",@"我的"];
    NSArray *colorArray=@[ZQColor(153, 206, 126),ZQColor(80, 203, 175)];
    for(int i=0;i<2;i++)
    {
        //创建button
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius=30;
        btn.frame=CGRectMake(70+120*i,80, 60, 60);
        btn.backgroundColor=colorArray[i];
        [btn setTitle:titltArray[i] forState:UIControlStateNormal];
        btn.tag=250+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
    }
    
}
-(void)btnClick:(UIButton *)btn
{
    NSLog(@"点击");
}



#pragma mark------------创建三个按钮
-(void)creatSegmentAndMap
{
   
    UIButton *_mapButton=[UIButton buttonWithType:UIButtonTypeSystem];
    [_mapButton  setTitle:@"全部分类" forState:UIControlStateNormal];
    [_mapButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _mapButton.layer.shadowOffset=CGSizeMake(3, 5);
    _mapButton.layer.shadowOpacity=1;
    _mapButton.layer.borderWidth=2;
    [_mapButton  addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    _mapButton.layer.borderColor=[UIColor blackColor].CGColor;
    _mapButton.layer.shadowColor=[UIColor blackColor].CGColor;
    _mapButton.frame=CGRectMake(10, 150, 100, 40);
    _mapButton.backgroundColor=ZQColor(55, 186, 206);
    [self.view addSubview:_mapButton];
    
    UIButton *_listButton=[UIButton buttonWithType:UIButtonTypeSystem];
    [_listButton  setTitle:@"等我来答" forState:UIControlStateNormal];
    [_listButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _listButton.layer.borderWidth=2;
    [_listButton  addTarget:self action:@selector(listButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _listButton.layer.borderColor=[UIColor blackColor].CGColor;
    _listButton.frame=CGRectMake(110, 150, 100, 40);
    [self.view  addSubview:_listButton];
    
    UIButton *_rwuButton=[UIButton buttonWithType:UIButtonTypeSystem];
    [_rwuButton  setTitle:@"我的任务" forState:UIControlStateNormal];
    [_rwuButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _rwuButton.layer.borderWidth=2;
    [_rwuButton  addTarget:self action:@selector(listButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _rwuButton.layer.borderColor=[UIColor blackColor].CGColor;
    _rwuButton.frame=CGRectMake(210, 150, 100, 40);
    [self.view  addSubview:_rwuButton];
    
}

//切换按钮点击
-(void)buttonClick:(UIButton *)button
{
    
    
}
//切换按钮点击
-(void)listButtonClick:(UIButton *)button
{
   
}


#pragma mark------------创建tableview
-(void)creattableview
{
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 190, 320, 400) style:UITableViewStylePlain];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    [self.view  addSubview:_tableview];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:nil];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
    }
    return cell;

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
