//
//  IntegralViewController.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/16.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "IntegralViewController.h"
#import "IntegeralTableViewCell.h"
#import "OLWTabBarController.h"
#import "IntegralMainModel.h"
#import "IntegralModel.h"
@interface IntegralViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * integralTableView;
    UIButton * selectBtn;
    UILabel * selectLabel;
    UIView * midView;
    UILabel * dqLabelText;
     UILabel * zsrLabelText;
    UILabel * zzcLabelText;
}
@property(nonatomic,strong)IntegralMainModel * mainModel;
@property(nonatomic,strong)IntegralModel * model;
@property(nonatomic,strong)NSMutableArray * cellModels;
@end

@implementation IntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZQColor(217, 217, 217);
    self.title = @"我的积分";
    [self createMainView];
    [self requestDataWithType:@"0"];
    
}

#pragma mark -懒加载
-(NSMutableArray *)cellModels
{
    if (_cellModels==nil) {
        _cellModels = [NSMutableArray array];
        
    }
    return _cellModels;
}
#pragma mark --创建视图
-(void)createMainView
{
    UIImageView * topImgView = [[UIImageView alloc]init];
    topImgView.image = [UIImage imageNamed:@"bj_jf"];
    topImgView.frame = CGRectMake(0, 64, self.view.width, self.view.height*0.25);
    [self.view addSubview:topImgView];
    topImgView.backgroundColor = [UIColor cyanColor];
    
    dqLabelText =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    dqLabelText.center =CGPointMake(topImgView.width/2, topImgView.height/2-10);
    dqLabelText.textColor = [UIColor redColor];
    dqLabelText.textAlignment = 1;
    [topImgView addSubview:dqLabelText];

    
    UILabel * dqLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    dqLabel.textAlignment = 1;
    dqLabel.center = CGPointMake(topImgView.width/2, topImgView.height/2+15);
    dqLabel.text = @"当前积分";
    dqLabel.font = [UIFont systemFontOfSize:14];
    dqLabel.textColor = [UIColor redColor];
    [topImgView addSubview:dqLabel];
    
    UILabel * zsrLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, topImgView.height-30, 50, 30)];
    zsrLabel.text = @"总收入:";
    zsrLabel.font = [UIFont systemFontOfSize:14];
    zsrLabel.textColor = [UIColor redColor];
    [topImgView addSubview:zsrLabel];
    
    zsrLabelText =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(zsrLabel.frame), zsrLabel.y  , 60, 30)];
    
    zsrLabelText.textColor = [UIColor redColor];
    [topImgView addSubview:zsrLabelText];
    
    UILabel * zzcLabel = [[UILabel alloc]initWithFrame:CGRectMake(topImgView.width/2+40 , topImgView.height-30, 50, 30)];
    zzcLabel.text = @"总支出:";
    zzcLabel.font = [UIFont systemFontOfSize:14];
    zzcLabel.textColor = [UIColor redColor];
    [topImgView addSubview:zzcLabel];
    
    zzcLabelText =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(zzcLabel.frame), zzcLabel.y  , 60, 30)];
    
    zzcLabelText.textColor = [UIColor redColor];
    [topImgView addSubview:zzcLabelText];
    
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topImgView.frame), self.view.width, 30)];
    label.text =@"消费记录";
    label.textAlignment = 1;
    label.backgroundColor = ZQColor(217, 217, 217);
    label.textColor = [UIColor redColor];
    [self.view addSubview:label];
    //
    midView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), self.view.width, 80 )];
    midView.backgroundColor =[UIColor whiteColor];
    
    NSArray * labelArr = @[@"收入",@"全部",@"支出"];
    NSArray * btnArr = @[@"sr",@"quanbu",@"zc"];
    for (int i = 0; i<3; i++) {
        UIButton  * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.size =  CGSizeMake(40, 40);
        btn.tag = 900+i;
        [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        //        btn.backgroundColor = ZQRandomColor;
        btn.center = CGPointMake(self.view.width/4*(i+1),midView.height/2-5);
        [btn setImage:[UIImage imageNamed:btnArr[i]] forState:0];
        [midView addSubview:btn];
        
        UILabel * label = [[UILabel alloc ]init];
        label.size = CGSizeMake(40, 20);
        label.tag = 800+i;
        label.text = labelArr[i];
        label.font = [UIFont systemFontOfSize:11  ];
        label.center = CGPointMake(btn.center.x, btn.center.y+btn.height/2+label.height/2);
        label.textAlignment = 1;
        [midView addSubview:label];
    }
    [self.view addSubview:midView];
    
    selectBtn = (UIButton *)[midView viewWithTag:901];
    selectBtn.selected = YES;
    selectBtn.size = CGSizeMake(55, 55);
    selectBtn.center = CGPointMake(self.view.width/2, midView.height/2-5);
    selectLabel = (UILabel *)[midView viewWithTag:801];
    selectLabel.y = selectLabel.y+5;
    selectLabel.font = [UIFont systemFontOfSize:14];
    
    integralTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(midView.frame)+5, self.view.width, self.view.height-CGRectGetMaxY(midView.frame)-5) style:UITableViewStylePlain];
    integralTableView.delegate = self;
    integralTableView.dataSource = self;
    integralTableView.bounces = NO;
    [self.view addSubview:integralTableView];

}
#pragma -mark 请求网络数据
-(void)requestDataWithType:(NSString *)atype
{
   
   
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //    获得参数
    NSString * getjf  =@"getjf";
    NSString * userid  =[MyAccountTool account].userid;
    NSString * jftype = atype;
    
    NSString * key =[NewMD5 md5:[NSString stringWithFormat:@"%@%@%@",userid,jftype,DefaultKey]] ;
    NSDictionary * parames = @{@"action":getjf,@"userid":userid,@"jftype":jftype,@"key":key};
    // 2.发送POST请求
    [mgr POST:PERSONCENTER_URL parameters:parames
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          NSString * code = [responseObj objectForKey:@"code"];
          NSLog(@"respone = %@",responseObj);
          if ([code isEqualToString:@"0"]) {
              NSDictionary * list = [responseObj objectForKey:@"list"];
              self.mainModel = [IntegralMainModel objectWithKeyValues:list];
              NSArray * rows = [list objectForKey:@"rows"];
               [self.cellModels removeAllObjects];
              for (NSDictionary * dic in rows) {
                  self.model =  [IntegralModel objectWithKeyValues:dic];
                  [self.cellModels addObject:self.model];
              }
//              NSLog(@"------%@",self.cellModels);

              dqLabelText.text = self.mainModel.jf;
              zsrLabelText.text = self.mainModel.sjf;
              zzcLabelText.text = self.mainModel.zjf;
              

              
              //
              [integralTableView reloadData];
          }
          
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"fail");
      }];
    
}



-(void)selectBtn:(UIButton *)sender
{
    if (selectBtn!=sender) {
        selectBtn.size = CGSizeMake(40, 40);
        selectBtn.center = CGPointMake(self.view.width/4*(selectBtn.tag-900+1),midView.height/2-5);
        selectLabel.font = [UIFont systemFontOfSize:11];
        CGFloat y = selectLabel.y;
        selectLabel.y = y-5;
        selectBtn = sender;
        
        selectLabel = (UILabel *)[midView viewWithTag:sender.tag-100];
        selectLabel.font = [UIFont systemFontOfSize:14];
        
        selectLabel.y = selectLabel.y +5;
        sender.size = CGSizeMake(55, 55);
        
        selectBtn.center = CGPointMake(self.view.width/4*(sender.tag-900+1),midView.height/2-5   );
        
    }
    
    selectLabel = (UILabel *)[midView viewWithTag:sender.tag-100];
    selectLabel.font = [UIFont systemFontOfSize:14];
    
    switch (sender.tag) {
        case 900:
        {
            [self requestDataWithType:@"1"];
        }
            break;
        case 901:
        {
            [self requestDataWithType:@"0"];
        }
            break;
        case 902:
        {
            [self requestDataWithType:@"2"];
        }
            break;
            
        default:
            break;
    }
    
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.cellModels.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IntegeralTableViewCell * cell = [IntegeralTableViewCell cellWithTableViewCell:tableView];
    [cell setindexPath:indexPath];
    cell.model = self.cellModels[indexPath.row ];
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

@end
