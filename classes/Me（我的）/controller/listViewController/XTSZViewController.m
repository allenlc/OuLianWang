//
//  XTSZViewController.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/23.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "XTSZViewController.h"
#import "XiTongTableViewCell.h"
#import "CustomTabBar.h"
#import "GeXinViewController.h"
#import "XiaoXiViewController.h"
#import "UIView+LCView.h"

@interface XTSZViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_nameArray;
    NSArray *_photoArray;
}
@end

@implementation XTSZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"系统设置";

    _nameArray=@[@"个性设置",@"消息提醒",@"聊天设置",@"账号安全",@"意见反馈",@"关于我们",@"检查更新"];
   _photoArray=@[@"gexing.png",@"xiaoxi1.png",@"liaot.png",@"zhangh.png",@"haoy.png",@"yijian.png",@"gengx"];
    [self createTableView];
    
    [self  creatFotview];
    
}
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}


-(void)createTableView
{
    _tableView=[[UITableView alloc]init];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.frame=self.view.bounds;
    [self setExtraCellLineHidden:_tableView];
    [self.view addSubview:_tableView];
    
}
#pragma mark - tableview的数据源方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _nameArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XiTongTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:[XiTongTableViewCell myIdentify]];
    if (cell==nil) {
        cell=[[XiTongTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[XiTongTableViewCell myIdentify]];
    }
    cell.selectionStyle=0;
    cell.namaLabel.text=_nameArray[indexPath.row];
    cell.iconImageView.image=[UIImage imageNamed:_photoArray[indexPath.row]];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        
        GeXinViewController *gexincontroller=[[GeXinViewController alloc]init];
        [self.navigationController  pushViewController:gexincontroller  animated:YES];
        
        
    }
    
    if (indexPath.row==1)
    {
        XiaoXiViewController  *xiaoxicontroller=[[XiaoXiViewController alloc]init];
        [self.navigationController  pushViewController:xiaoxicontroller animated: YES];                
    }
    if (indexPath.row==6) {
        [self startDownloadData];
    }

}
-(void)startDownloadData
{
    NSString *urlString=[NSString stringWithFormat:UPDATA_URL];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        
        //获取版本号
        NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
        
        NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
        NSLog(@"%@",currentVersion);
        if ([currentVersion isEqualToString:dic[@"list"][@"version"]]){
            
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"更新提示" message:@"亲，您的版本已经是最新的啦！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
            return ;
            
        }
        
        NSString *message=[NSString stringWithFormat:@"我连网%@版本",dic[@"list"][@"version"]];
        
        UIView *blackView=[[UIView alloc]initWithFrame:self.view.frame];
        blackView.backgroundColor=[UIColor blackColor];
        blackView.alpha=0.5;
        [self.view.window addSubview:blackView];
        
        float alww=260;
        if (self.view.frame.size.width==375) {
            alww=220;
        }
        float alyy=heightEx(150);
        float alxx=(self.view.frame.size.width-alww)/2;
        UIView *alertView=[[UIAlertView alloc]initWithFrame:CGRectMake(alxx, alyy, alww, 200)];
        alertView.backgroundColor=[UIColor whiteColor];
        alertView.layer.cornerRadius=3;
        alertView.alpha=1;
        [alertView addImageViewWithFrame:CGRectMake(65, 15, 20, 20) image:@"prompt.png"];
        UILabel *ll=[alertView addLabelWithFrame:CGRectMake(10, 10, alertView.frame.size.width-20, 30) text:@"更新提示"];
        ll.textAlignment=NSTextAlignmentCenter;
        ll.textColor=ZQColor(65, 171, 0);
        
        [alertView addImageViewWithFrame:CGRectMake(10, 40, alertView.frame.size.width-20, 3) image:@"line.png"];
        
        UILabel *nameLabel=[alertView addLabelWithFrame:CGRectMake(10, 45, alertView.frame.size.width-20, 30) text:message];
        nameLabel.textAlignment=NSTextAlignmentCenter;
        nameLabel.textColor=ZQColor(65, 171, 0);
        nameLabel.font=[UIFont systemFontOfSize:16];
        UILabel *ggLa=[alertView addLabelWithFrame:CGRectMake(10, 75, 100, 20) text:@"更新内容"];
        ggLa.font=[UIFont systemFontOfSize:15];
        
        
        UIButton *btn1=[alertView addImageButtonWithFrame:CGRectMake(20, alertView.frame.size.height-50, (alertView.frame.size.width-60)/2, 40) title:nil image:@"update.png" action:^(UIButton *button) {
            [alertView removeFromSuperview];
            [blackView removeFromSuperview];
            NSLog(@"%@",dic[@"list"][@"file_path"]);
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:dic[@"list"][@"file_path"]]];
            
            
        }];
        [alertView addImageButtonWithFrame:CGRectMake(40+btn1.frame.size.width, alertView.frame.size.height-50, (alertView.frame.size.width-60)/2, 40)  title:nil image:@"cancel.png" action:^(UIButton *button) {
            [alertView removeFromSuperview];
            [blackView removeFromSuperview];
        }];
        
        
        
        [self.view.window addSubview:alertView];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",[error description]);
    }];
}



#pragma  mark-----创建底部退出按钮
-(void)creatFotview
{
    UIView *View=[[UIView alloc]initWithFrame:CGRectMake(0, 508, 320, 60)];
    [self.view  addSubview:View];
    
    View.backgroundColor=ZQColor(220, 220, 220);
    
    UIButton  *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button  setTitle:@"退出登录" forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont  boldSystemFontOfSize:18];
    button.backgroundColor=[UIColor redColor];
    button.layer.cornerRadius=5;
    [button  addTarget:self action:@selector(buttonclick) forControlEvents:UIControlEventTouchUpInside];
    [View  addSubview:button];
    button.frame=CGRectMake(20, 10, 280, 40);
    

}

-(void)buttonclick
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
