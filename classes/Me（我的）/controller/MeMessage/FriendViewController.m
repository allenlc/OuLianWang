//
//  FriendViewController.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/17.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "FriendViewController.h"
#import "ChineseString.h"
#import "OLWTabBarController.h"
#import "MyFriendModel.h"
@interface FriendViewController ()
@property(nonatomic,retain)NSMutableArray *indexArray;
@property(nonatomic,retain)NSMutableArray *LetterResultArr;
@property(nonatomic,strong)MyFriendModel *myFriendModel;
@property(nonatomic,strong)NSMutableArray *friendModels;
@end

@implementation FriendViewController
@synthesize indexArray;
@synthesize LetterResultArr;
#pragma mark - 懒加载
-(NSMutableArray *)friendModels
{
    if (_friendModels==nil) {
        _friendModels = [NSMutableArray array];
    }
    return _friendModels;
}
-(id)init
{
    if (self = [super init]) {
        self.tableView.sectionIndexTrackingBackgroundColor=[UIColor clearColor];
    }
    return self;
}
-(void)loadView
{
    [super loadView];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
      self.navigationItem. title = @"我的好友";
        self.view.backgroundColor = [UIColor whiteColor];
     [self setNavigationTitle];
    
  
//    NSArray *stringsToSort=[NSArray arrayWithObjects:
//                            @"￥hhh, .$",@" ￥Chin ese ",@"开源中国 ",@"www.oschina.net",
//                            @"开源技术",@"社区",@"开发者",@"传播",
//                            @"2014",@"a1",@"100",@"中国",@"暑假作业",
//                            @"键盘", @"鼠标",@"hello",@"world",@"b1",
//                            nil];
//    
//    self.indexArray = [ChineseString IndexArray:stringsToSort];
//    self.LetterResultArr = [ChineseString LetterSortArray:stringsToSort];
    [self requestData];
    
}

#pragma -mark 请求网络数据
-(void)requestData
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //    获得参数
    NSString * getfriends  =@"getfriends";
    NSString * userid  =[MyAccountTool account].userid;
    
    NSString * key =[NewMD5 md5:[NSString stringWithFormat:@"%@%@",userid,@"esaafafasfafafsaff"]] ;
    NSDictionary * parames = @{@"action":getfriends,@"userid":userid,@"key":key};
    // 2.发送POST请求
    [mgr POST:@"http://www.hsmja.com/wolian/personcenter.php?" parameters:parames
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          NSString * code = [responseObj objectForKey:@"code"];
          NSLog(@"respone = %@",responseObj);
          if ([code isEqualToString:@"0"]) {
              NSArray * list = [responseObj objectForKey:@"list"];
              NSMutableArray * nameArr= [NSMutableArray array];
              for (NSDictionary *dic in list) {
                  self.myFriendModel = [MyFriendModel objectWithKeyValues:dic];
                  [self.friendModels addObject:self.myFriendModel];
                  [nameArr addObject:self.myFriendModel.fname];
              }
              
              self.indexArray = [ChineseString IndexArray:nameArr];
              self.LetterResultArr = [ChineseString LetterSortArray:nameArr];

              NSLog(@"--%@",self.friendModels);
    
              //
                            [self.tableView reloadData];
          }
          
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"fail");
      }];
}
#pragma mark --------配置导航栏
-(void)setNavigationTitle
{
    
    UIButton *fabubutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [fabubutton  setImage:[UIImage imageNamed:@"返回箭头.png"] forState:UIControlStateNormal];
    [fabubutton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    fabubutton.frame=CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *leftBtn=[[UIBarButtonItem alloc]initWithCustomView:fabubutton];
    
    // 调整 leftBarButtonItem 在 iOS7 下面的位置
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0))
        
    {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                       target:nil action:nil];
        negativeSpacer.width = -10;//这个数值可以根据情况自由变化
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftBtn];
    }
    else
    self.navigationItem.leftBarButtonItem=leftBtn;
    
    
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    OLWTabBarController * tabBarVC =(OLWTabBarController *) self.tabBarController;
    tabBarVC.zqTabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    OLWTabBarController * tabBarVC =(OLWTabBarController *) self.tabBarController;
    tabBarVC.zqTabBar.hidden = NO;
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.sectionIndexTrackingBackgroundColor=[UIColor clearColor];
    NSLog(@"color ==%@",self.tableView.sectionIndexTrackingBackgroundColor);
    //设置导航字体颜色、字体、背景色
    for (UIView* subview in [self.tableView subviews])
    {
        if ([subview isKindOfClass:NSClassFromString(@"UITableViewIndex")])
        {
            if([subview respondsToSelector:@selector(setIndexColor:)])
            {
                [subview performSelector:@selector(setIndexColor:) withObject:[UIColor blackColor]];
            }
            if([subview respondsToSelector:@selector(setFont:)])
            {
                [subview performSelector:@selector(setFont:) withObject:[UIFont systemFontOfSize:2]];
            }
            if([subview respondsToSelector:@selector(setBackgroundColor:)])
            {
                [subview performSelector:@selector(setBackgroundColor:) withObject:[UIColor clearColor]];
            }
        }
    }
}
#pragma mark -Section的Header的值
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [indexArray objectAtIndex:section];
    return key;
}
#pragma mark - Section header view
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 15)];
    lab.backgroundColor = ZQColor(232, 232, 232);
    lab.text = [indexArray objectAtIndex:section];
    lab.textColor = [UIColor blackColor];
    return lab;
}
#pragma mark - row height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

#pragma mark -
#pragma mark Table View Data Source Methods
#pragma mark -设置右方表格的索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return indexArray;
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

#pragma mark -允许数据源告知必须加载到Table View中的表的Section数。
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [indexArray count];
}
#pragma mark -设置表格的行数为数组的元素个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.LetterResultArr objectAtIndex:section] count];
}
#pragma mark -每一行的内容为数组相应索引的值
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIImageView * iconImg =[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 50, 50)];
        [cell.contentView addSubview:iconImg];
        iconImg.tag = 200;
        
         UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, cell.width-85, 30)];
        [cell.contentView addSubview:lable];
        lable.tag = 201;

        
    }
    NSLog(@"%@",self.myFriendModel.photo);
    UIImageView * iconImg  =(UIImageView *)[cell.contentView viewWithTag:200];
    [iconImg setImageWithURL:[NSURL URLWithString:self.myFriendModel.photo] placeholderImage:[UIImage imageNamed:@"touxiangtouxiang1.jpg"]];
    UILabel * lable = (UILabel *)[cell.contentView viewWithTag:201];
    lable.text =[[self.LetterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];

    
    return cell;
}
#pragma mark - Select内容为数组相应索引的值
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"---->%@",[[self.LetterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:[[self.LetterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]
                                                   delegate:nil
                                          cancelButtonTitle:@"YES" otherButtonTitles:nil];
    [alert show];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
