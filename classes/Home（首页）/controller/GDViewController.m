//
//  GDViewController.m
//  OuLianWang
//
//  Created by hsmj on 15/7/2.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "GDViewController.h"

@interface GDViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    NSArray *_twoArray;
    NSArray *_threeArray;
}
@end

@implementation GDViewController

- (void)viewDidLoad {
    
    self.title=@"保利电谷家居";
    
    
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self  creattableview];
    
    _twoArray=@[@"全部",@"家居",@"美食",@"服装",@"全部",@"家居",@"美食",@"服装"];
    _threeArray=@[@"全部",@"家居",@"美食",@"服装",@"全部",@"家居",@"美食",@"服装",@"全部",@"家居",@"美食",@"服装"];
    
}

#pragma mark------创建tanleview
-(void)creattableview
{
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) style:UITableViewStylePlain];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    _tableview.sectionIndexColor = [UIColor  blackColor];
    //_tableview.sectionIndexTrackingBackgroundColor=[UIColor redColor];
    
    [self.view addSubview:_tableview];
    
    
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 24;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  row 小于7设置成高度不一样的系统Cell。。前面六个有些控件后面用不着。没办法通过下面的一些判断条件不加上去 if (indexPath.row%2==0)

    if (indexPath.row<7)
    {
        NSArray *array1=@[@"最近选择",@"",@"热门推荐",@"",@"品牌分类",@"",@"工厂",@"",@"最近选择",@"",@"热门推荐",@"",@"品牌分类",@"",@"工厂",@"",@"最近选择",@"",@"热门推荐",@"",@"品牌分类",@"",@"工厂",@"",@"最近选择",@"",@"热门推荐",@"",@"品牌分类",@"",@"工厂",@""];
        static NSString *cellid=@"Cellid";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid ];
        }
        
        if (indexPath.row%2==0)
        {
            cell.textLabel.text=array1[indexPath.row];
        }
        
        if(indexPath.row==3)
        {
            int x=0;
            int y=0;
            for (int i=0; i<8; i++)
            {
                if(i%4==0&&i!=0)
                {
                    y++;
                    x=0;
                }
                UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
                [button  setTitle:_twoArray[i] forState:UIControlStateNormal];
                [button  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [button  addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
                button.frame=CGRectMake(80*x,30*y,320/4,30);
                [cell  addSubview:button];
                
                x++;
            }
            
        }
        
        if(indexPath.row==5)
        {
            int x=0;
            int y=0;
            for (int i=0; i<12; i++)
            {
                if(i%4==0&&i!=0)
                {
                    y++;
                    x=0;
                }
                UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
                [button  setTitle:_threeArray[i] forState:UIControlStateNormal];
                [button  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(buttonClick2) forControlEvents:UIControlEventTouchUpInside];
                button.frame=CGRectMake(80*x,30*y,320/4,30);
                [cell  addSubview:button];
                
                x++;
            }
        }
        return cell;
    }
    
    //  row 大于7之后全部设置成高度统一的系统Cell
    else
    {
    
        static NSString *cellid=@"Cellid12";
        UITableViewCell *cell12=[tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell12==nil)
        {
            cell12=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid ];
            
        }
        
        return cell12;
    
    }
   
    return nil;
    

}

#pragma mark------返回不同的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row<7)
    {
    
    if (indexPath.row%2==0) {
        
        return  40;
        
    }
    else
        return 100;
    }
    
    else
        
        return 40;
    
}

#pragma mark------工厂索引值


-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    NSArray *indexArray=@[@"工厂",@"A ",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    return  indexArray;

}

-(NSInteger )tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSLog(@"===%@  ===%d",title,index);
    [tableView  scrollToRowAtIndexPath:[NSIndexPath  indexPathForRow:index+6 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return index+6;

}




-(void)buttonClick
{



}

-(void)buttonClick2
{



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
