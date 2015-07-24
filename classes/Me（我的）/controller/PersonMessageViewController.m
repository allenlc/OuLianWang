//
//  PersonMessageViewController.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/17.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "PersonMessageViewController.h"
#import "SetTDCViewController.h"
#import "CreateCodeViewController.h"
#import "AFNetworking.h"
#import "PersonGroup.h"
#import "PersonItem.h"
#import "PersonViewCell.h"
#import "OLWTabBarController.h"
#import "MJExtension.h"
#import "PersonMessageModel.h"
#import "CorrectViewController.h"

#define margin 30
#define Wode_Data @"Wode_Data"
@interface PersonMessageViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}
/**
 *  用模型来描述每一组的信息和每一行的信息
 */
@property(nonatomic,strong)NSMutableArray * groups;
@property(nonatomic,strong)PersonMessageModel * personMessage;
@end

@implementation PersonMessageViewController
#pragma mark -懒加载
-(NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
        
    }
    return _groups;
}
-(void)setupGroups
{
    [_groups removeAllObjects];
    [self setupGroup0];
    [self setupGroup1];
    
    [self setupGroup2];
    [self setupGroup3];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationTitle];
    [self setupGroups];
    
//    设置tableview的属性
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height+85) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = ZQColor(232, 232, 232);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.sectionFooterHeight=0;
    _tableView.sectionHeaderHeight =5;
   
    [self startDownloadData];
  
}
#pragma mark --------配置导航栏
-(void)setNavigationTitle
{
    self.navigationItem.title = @"个人资料";
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(edit)];
    rightBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)edit
{
    
}
-(void)addFriend
{
    CreateCodeViewController * tdcViewController = [[CreateCodeViewController alloc]init];
    [self.navigationController pushViewController:tdcViewController animated:YES];
}
-(void)modified
{
    
}

-(void)setupGroup0
{
    //1 创建组
    PersonGroup * group = [PersonGroup group];
    //2 设置每组的数据
    group.groupHeader = @"0";
    group.groupHeader= @"0尾部";
    
    PersonItem * icon = [PersonItem itemWithTitle:@"头像" icon:self.personMessage.photo];
    group.items = @[icon];
    [self.groups addObject:group];
    
}

-(void)setupGroup1
{
    //1 创建组
    PersonGroup * group = [PersonGroup group];
    //2 设置每组的数据
    group.groupHeader = @"1";
    group.groupHeader= @"1尾部";
    PersonItem * name = [PersonItem itemWithTitle:@"二维码名片" icon:@"grzl_ewm"];
    group.items = @[name];
    [self.groups addObject:group];
}

-(void)setupGroup2
{
    //1 创建组
    PersonGroup * group = [PersonGroup group];
    
    //2 设置每组的数据
    group.groupHeader = @"1";
    group.groupHeader= @"1尾部";
    PersonItem * name = [PersonItem itemWithTitle:@"昵称" andSubTitle:self.personMessage.username];
    PersonItem * sex = [PersonItem itemWithTitle:@"性别" andSubTitle:self.personMessage.sex];
    PersonItem * phone = [PersonItem itemWithTitle:@"手机" andSubTitle:self.personMessage.telephone];
    PersonItem * adress = [PersonItem itemWithTitle:@"常住地址" andSubTitle:self.personMessage.czAddr];
    PersonItem * adress1 = [PersonItem itemWithTitle:@"家庭地址" andSubTitle:self.personMessage.homeAddr];
    group.items = @[name,sex,phone,adress,adress1];
    [self.groups addObject:group];
}

-(void)setupGroup3
{
    //1 创建组
    PersonGroup * group = [PersonGroup group];
    
    //2 设置每组的数据
    group.groupHeader = @"2";
    group.groupHeader= @"2尾部";
    PersonItem * dateOfBirth = [PersonItem itemWithTitle:@"出生年月" andSubTitle:self.personMessage.birthday];
    PersonItem * mailbox = [PersonItem itemWithTitle:@"邮箱" andSubTitle:self.personMessage.email];
    PersonItem * weixiID = [PersonItem itemWithTitle:@"微信号" andSubTitle:self.personMessage.weixin];
    PersonItem * qqID = [PersonItem itemWithTitle:@"QQ" andSubTitle:self.personMessage.QQ];
    PersonItem * graduateSchool = [PersonItem itemWithTitle:@"毕业学校" andSubTitle:self.personMessage.graduate];
    PersonItem * workUnit = [PersonItem itemWithTitle:@"工作单位" andSubTitle:self.personMessage.workPlace];
    group.items = @[dateOfBirth,mailbox,weixiID,qqID,graduateSchool,workUnit];
    [self.groups addObject:group];
    
}




-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.groups.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    PersonGroup * group = self.groups[section];
    return group.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonViewCell * cell = [[PersonViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    PersonGroup * goupe = self.groups[indexPath.section];
    PersonItem * item = goupe.items[indexPath.row];
    cell.item = item;
    [cell setindexPath:indexPath rowInSecton:indexPath.section];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 80;
    }
    else if (indexPath.section == 1){
        return 60;
    }
    else{
        return 50;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(void)startDownloadData
{
    //一开始获取缓存
    NSDictionary *dd=[[NSUserDefaults standardUserDefaults]valueForKey:Wode_Data];
    [self.personMessage  setValuesForKeysWithDictionary:dd];
    
    MyAccount *account=[MyAccountTool account];
    NSString * key =[NewMD5 md5:[NSString stringWithFormat:@"%@%@",account.userid,DefaultKey]] ;
    
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 获得参数
    NSDictionary * parames = @{@"action":@"personinfoshow",@"userid":account.userid,@"key":key};
    // 2.发送POST请求
    
    [mgr POST:PERSONCENTER_URL parameters:parames
      success:^(AFHTTPRequestOperation *operation, id responseObj) {

          NSString * code = [responseObj objectForKey:@"code"];
          if ([code isEqualToString:@"0"]) {
              NSDictionary * list = [responseObj objectForKey:@"list"];
              NSLog(@"登陆返回信息：%@",list);
              //缓存起来
//              [[NSUserDefaults standardUserDefaults]setValue:list forKey:Wode_Data];
              
              self.personMessage = [PersonMessageModel objectWithKeyValues:list];
              //初始化模型数据
              [self setupGroups];
              [_tableView reloadData];
          }
          
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"fail");
      }];
}

#pragma mark - 点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%d ---- %d",indexPath.section,indexPath.row);
    
//    if (indexPath.section==0) {
//        //切换头像
//        
//    }
//    else if (indexPath.section==2) {
//        if (indexPath.row==0) {
//            //修改昵称
//            CorrectViewController *vcv=[[CorrectViewController alloc]init];
//            vcv.text=self.personMessage.name;
//            vcv.type=Name;
//            [self.navigationController pushViewController:vcv animated:YES];
//        }
//        else if (indexPath.row==1) {
//            //修改性别
//        }
//        else if (indexPath.row==2) {
//            //修改手机
//            CorrectViewController *vcv1=[[CorrectViewController alloc]init];
//            vcv1.text=self.personMessage.telephone;
//            vcv1.type=PhoneNumber;
//            [self.navigationController pushViewController:vcv1 animated:YES];
//        }
//        else if (indexPath.row==3) {
//            //修改常住地址
//            CorrectViewController *vcv=[[CorrectViewController alloc]init];
//            vcv.text=self.personMessage.ipadress;
//            vcv.type=MyAddress;
//            [self.navigationController pushViewController:vcv animated:YES];
//        }
//        else if (indexPath.row==4) {
//            //修改家庭地址
//            CorrectViewController *vcv=[[CorrectViewController alloc]init];
//            vcv.text=self.personMessage.homeAddr;
//            vcv.type=HomeAddress;
//            [self.navigationController pushViewController:vcv animated:YES];
//        }
//    }
//    else if (indexPath.section==3) {
//        if (indexPath.row==0) {
//            //修改出生年月
//        }
//        else if (indexPath.row==1) {
//            //修改邮箱
//            CorrectViewController *vcv=[[CorrectViewController alloc]init];
//            vcv.text=self.personMessage.email;
//            vcv.type=Email;
//            [self.navigationController pushViewController:vcv animated:YES];
//        }
//        else if (indexPath.row==2) {
//            //修改微信号
//            CorrectViewController *vcv=[[CorrectViewController alloc]init];
//            vcv.text=self.personMessage.weixin;
//            vcv.type=ChatNumber;
//            [self.navigationController pushViewController:vcv animated:YES];
//        }
//        else if (indexPath.row==3) {
//            //修改QQ
//            CorrectViewController *vcv=[[CorrectViewController alloc]init];
//            vcv.text=self.personMessage.QQ;
//            vcv.type=QQ;
//            [self.navigationController pushViewController:vcv animated:YES];
//        }
//        else if (indexPath.row==4) {
//            //修改毕业学校
//            CorrectViewController *vcv=[[CorrectViewController alloc]init];
//            vcv.text=self.personMessage.graduate;
//            vcv.type=School;
//            [self.navigationController pushViewController:vcv animated:YES];
//        }
//        else if (indexPath.row==5) {
//            //修改工作单位
//            CorrectViewController *vcv=[[CorrectViewController alloc]init];
//            vcv.text=self.personMessage.workPlace;
//            vcv.type=Company;
//            [self.navigationController pushViewController:vcv animated:YES];
//        }
//    }

}

@end
