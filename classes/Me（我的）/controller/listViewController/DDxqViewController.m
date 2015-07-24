//
//  DDxqViewController.m
//  OuLianWang
//
//  Created by hsmj on 15/7/6.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "DDxqViewController.h"
#import "TwoTableViewCell.h"
#import "OLWTabBarController.h"
#import "onetableviewcell.h"
#import "HYCZViewController.h"


@interface DDxqViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView *_tableview;
    
    int h;
    
    NSMutableArray *_mutablearray;
    


}

@end

@implementation DDxqViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _mutablearray=[[NSMutableArray alloc]init];
    
    [self  creattableview];
    
    [self  creatfootView];
    
    [self  deplyNavigationController1];
    
    
}

#pragma mark-----配置导航栏
-(void)deplyNavigationController1
{
    self.title=@"订单详情";
    
}


#pragma mark-----创建tableview
-(void)creattableview
{
    
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) style:UITableViewStyleGrouped];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    [self.view  addSubview:_tableview];
    
}


-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 4;
        
    }
    else
        return 8;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  第一组的Cell
    if(indexPath.section==0)
    {
        static NSString *onecellid=@"onecellid";
        onetableviewcell *_cell=[tableView dequeueReusableCellWithIdentifier:onecellid];
        if(_cell==nil)
        {
            _cell=[[onetableviewcell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:onecellid];
            
        }
        _cell.imageview.image=[UIImage imageNamed:@"zxzx.png"];
        _cell.titleLabel.text=@"青椒炒肉+番茄炒蛋套餐";
        _cell.changLabel.text=@"地址：天河北，林和西，中信广场";

        _cell.yuanpriceLabel.text=@"价格:￥888元";
        _cell.xianpriceLabel.text=@"￥原价:688元";
        _cell.priceLabel.text=@" ×1 ";
        
        
        [_mutablearray  addObject:_cell];
        
        
//        
//        [_cell  setJiablock:^{
//            
//            NSString *str=_cell.priceLabel.text;
//            int i =[str intValue];
//            i ++;
//            NSString *str1=[NSString stringWithFormat:@"%d",i ];
//            _cell.priceLabel.text=str1;
//            
//        }];
//        
//        [_cell  setJianblock:^{
//            
//            NSString *str=_cell.priceLabel.text;
//            int a=[str intValue];
//            
//            if (a  ==1) {
//                
//            }
//            else
//            {
//                a --;
//                NSString *str=[NSString stringWithFormat:@"%d", a  ];
//                _cell.priceLabel.text=str;
//            }
//            
//        }];
        
        return _cell;
        
        
    }
    //  第二组第一行的Cell
    if(indexPath.section==1&&indexPath.row==0)
    {
        static NSString *fourcellid=@"fourcellid";
        UITableViewCell *fourcell=[tableView dequeueReusableCellWithIdentifier:fourcellid];
        if(fourcell==nil)
        {
            fourcell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:fourcellid];
            
        }
        
        fourcell.textLabel.text=@"收货信息";
        fourcell.textLabel.font=[UIFont systemFontOfSize:15];
        fourcell.textLabel.textColor=[UIColor orangeColor];
        return fourcell;
        
    }
    
    //  第二组第二行的Cell
    if (indexPath.section==1&&indexPath.row==1)
    {
        TwoTableViewCell *cell2=[tableView dequeueReusableCellWithIdentifier:nil];
        if (cell2==nil)
        {
            cell2=[[TwoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        }
        cell2.shouhuoLabel.text=@"收货人： 李聪";
        cell2.lianxiLabel.text=@"联系电话：123456789";
        cell2.dizhiLabel.text=@"收货地址：广东省茂名市毛毛大道321号";
        cell2.youzhenLabel.text=@"邮政编码：123456";
        [cell2.ditubutton setImage:[UIImage  imageNamed:@"zxzx"] forState:UIControlStateNormal];
        return cell2;
        
        
        
    }
    
    //  第二组第三行的Cell
    
    if(indexPath.section==1&&indexPath.row==2)
    {
        UITableViewCell *fifthcell=[tableView dequeueReusableCellWithIdentifier:nil];
        
        if(fifthcell==nil)
        {
            fifthcell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
        }
        
        fifthcell.textLabel.text=@"配送方式";
        fifthcell.textLabel.font=[UIFont systemFontOfSize:15];
        fifthcell.textLabel.textColor=[UIColor orangeColor];
        
        return fifthcell;
        
        
    }
    
    //  第二组第四行的Cell
    if(indexPath.section==1&&indexPath.row==3)
    {
        UITableViewCell *sixcell=[tableView dequeueReusableCellWithIdentifier:nil];
        
        if(sixcell==nil)
        {
            sixcell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
        }
        
        UILabel *twolabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10,100, 30)];
        twolabel.text=@"选择配送方式：";
        twolabel.font=[UIFont systemFontOfSize:13];
        [sixcell  addSubview:twolabel];
        
        
        UILabel *threelabel=[[UILabel alloc]initWithFrame:CGRectMake(210, 10, 100, 30)];
        threelabel.text=@"配送费用 20 元";
        threelabel.font=[UIFont systemFontOfSize:13];
        [sixcell  addSubview:threelabel];
        
        
        UILabel *fourlabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 40, 100, 20)];
        fourlabel.text=@"是否了开发票：";
        fourlabel.font=[UIFont systemFontOfSize:13];
        [sixcell  addSubview:fourlabel];
        
        NSArray *titleARray=@[@"是",@"否"];
        NSArray *imageARray=@[@"",@""];
        
        for(int j=0;j<2;j++)
        {
            UIButton *xuanzebutton=[UIButton buttonWithType:UIButtonTypeCustom];
            xuanzebutton.frame=CGRectMake(100+55*j ,40,50, 20);
            [xuanzebutton  setTitle:titleARray[j] forState:UIControlStateNormal];
            xuanzebutton.titleLabel.font=[UIFont  systemFontOfSize:12];
            [xuanzebutton  setImage:[UIImage imageNamed:imageARray[j]] forState:UIControlStateNormal];
            xuanzebutton.backgroundColor=[UIColor redColor];
            [sixcell  addSubview:xuanzebutton];
        }
        
        
        
        UILabel *fifthlabel=[[UILabel alloc]initWithFrame:CGRectMake(210,40, 100, 30)];
        fifthlabel.text=@"费用2元";
        fifthlabel.font=[UIFont systemFontOfSize:13];
        [sixcell  addSubview:fifthlabel];
        
        return sixcell;
        
    }
    
    //  第二组第五行的Cell
    if(indexPath.section==1&&indexPath.row==4)
    {
        UITableViewCell *seventhcell=[tableView dequeueReusableCellWithIdentifier:nil];
        
        if(seventhcell==nil)
        {
            seventhcell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
        }
        
        seventhcell.textLabel.text=@"订单备注";
        seventhcell.textLabel.font=[UIFont systemFontOfSize:15];
        seventhcell.textLabel.textColor=[UIColor orangeColor];
        return seventhcell;
        
    }
    //  第二组第六行的Cell
    if(indexPath.section==1&&indexPath.row==5)
    {
        UITableViewCell *eightcell=[tableView dequeueReusableCellWithIdentifier:nil];
        
        if(eightcell==nil)
        {
            eightcell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
        }
        
        //        seventhcell.textLabel.text=@"订单备注";
        //        seventhcell.textLabel.font=[UIFont systemFontOfSize:15];
        //        seventhcell.textLabel.textColor=[UIColor orangeColor];
        return eightcell;
        
    }
    
    //  第二组第七行的Cell
    if(indexPath.section==1&&indexPath.row==6)
    {
        UITableViewCell *ninthcell=[tableView dequeueReusableCellWithIdentifier:nil];
        
        if(ninthcell==nil)
        {
            ninthcell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
        }
        UILabel *sixlabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 30)];
        sixlabel.text=@"套餐合计：";
        sixlabel.font=[UIFont systemFontOfSize:13];
        [ninthcell  addSubview:sixlabel];
        
        UILabel *sevenlabel=[[UILabel alloc]initWithFrame:CGRectMake(210, 10, 200, 30)];
        sevenlabel.text=@"会员价：";
        sevenlabel.font=[UIFont systemFontOfSize:13];
        [ninthcell  addSubview:sevenlabel];
        
        return ninthcell;
        
    }
    //  第二组第八行的Cell
    if(indexPath.section==1&&indexPath.row==7)
    {
        UITableViewCell *tenthcell=[tableView dequeueReusableCellWithIdentifier:nil];
        
        if(tenthcell==nil)
        {
            tenthcell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
        }
        UILabel *eightlabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 30)];
        eightlabel.text=@"单号：Eadadhakhdkajsdjad";
        eightlabel.textColor=[UIColor grayColor];
        eightlabel.font=[UIFont systemFontOfSize:13];
        [tenthcell  addSubview:eightlabel];
        
        UILabel *ninlabel=[[UILabel alloc]initWithFrame:CGRectMake(195, 10, 200, 30)];
        ninlabel.text=@"2015-07-1  11:09:12";
        ninlabel.font=[UIFont systemFontOfSize:13];
        ninlabel.textColor=[UIColor grayColor];
        [tenthcell  addSubview:ninlabel];
        
        return tenthcell;
        
        
        
        
    }
    
    
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:nil];
    
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
    }
    
    return cell;
    
}


#pragma mark-------返回第一组头部视图
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        return 80;
    }
    else
        return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section==0) {
        
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMakeEx(0, 0, 320, 80)];
        
        UILabel *onelabel=[[UILabel alloc]initWithFrame:CGRectMakeEx(20, 10, 150, 30)];
        onelabel.text=@"订单商品";
        onelabel.textColor=[UIColor orangeColor];
        onelabel.font=[UIFont systemFontOfSize:18];
        [view  addSubview:onelabel];
        
        
        UIImageView  * oneimage=[[UIImageView alloc]initWithFrame:CGRectMakeEx(20,45, 30, 30)];
        oneimage.image=[UIImage imageNamed:@"zxzx.png"];
        [view  addSubview:oneimage];
        
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMakeEx(60, 45, 100, 30)];
        label1.text=@"豪瑟家具";
        label1.textColor=[UIColor blackColor];
        label1.font=[UIFont systemFontOfSize:18];
        [view  addSubview:label1];
        
        NSArray *imagearray=@[@"dianpuxiangqingxiaoxi",@"dianpuxiangqingdianhua"];
        for(int i=0;i<2;i++)
        {
            
            UIImageView  * image=[[UIImageView alloc]initWithFrame:CGRectMakeEx(230+45*i,45,25,25)];
            image.image=[UIImage imageNamed:imagearray[i]];
            [view  addSubview:image];
            
        }
        
        return view;
        
    }
    else
        return nil;
    
}

#pragma mark-------返回底部视图
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if (section==0)
    {
        return 20;
    }
    else
        
        return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (section==0)
    {
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMakeEx(0, 0, 320, 40)];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(140,5,60, 30)];
        label.text=@"共 3 件";
        label.font=[UIFont  systemFontOfSize:14];
        [view  addSubview:label];
        
        
        UILabel *hejilabel=[[UILabel alloc]initWithFrame:CGRectMake(200,5,100, 30)];
        hejilabel.text=@"合计:￥3299.00";
        hejilabel.textColor=[UIColor  redColor];
        hejilabel.font=[UIFont  systemFontOfSize:14];
        [view  addSubview:hejilabel];
        

        return view;
        }
  
    else
        return nil;
}


#pragma mark-------返回高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section==0)
    {
        return 120;
        
    }
    
    if (indexPath.section==1&&indexPath.row==1)
    {
        return 120;
    }
    if (indexPath.section==1&&indexPath.row==3)
    {
        return 80;
    }
    if (indexPath.section==1&&indexPath.row==5)
    {
        return 100;
    }
    
    else
        return 40;
    
    
    
    
}



#pragma mark---------底部视图
-(void)creatfootView
{
    UIView *footview=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.height-60, 320, 60)];
    footview.backgroundColor=[UIColor  whiteColor];
    [self.view  addSubview:footview];
    footview.userInteractionEnabled=YES;
    
    UIButton *onebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    onebutton.frame=CGRectMake(10,20, 70, 25) ;
    [onebutton  addTarget:self action:@selector(onebuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [onebutton  setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [onebutton  setTitle:@"取消订单" forState:UIControlStateNormal];
    onebutton.layer.cornerRadius=5;
    onebutton.layer.borderWidth=1;
    onebutton.titleLabel.font=[UIFont systemFontOfSize:14];
    onebutton.layer.borderColor=[UIColor redColor].CGColor;
    [footview   addSubview:onebutton];
    
   
    UILabel *twolabel=[[UILabel alloc]initWithFrame:CGRectMake(320/3, 10,150, 40)];
    twolabel.text=@"合计：￥45.00";
    twolabel.font=[UIFont systemFontOfSize:15];
    twolabel.textColor=[UIColor  redColor];
    [footview  addSubview:twolabel];
    
    UIButton *fifvebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    fifvebutton.backgroundColor=[UIColor redColor];
    [fifvebutton  setTitle:@"立即购买" forState:UIControlStateNormal];
    [fifvebutton  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    fifvebutton.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    [fifvebutton addTarget:self action:@selector(lijiGOumaiClick) forControlEvents:UIControlEventTouchUpInside];
    fifvebutton.frame=CGRectMake(640/3+10, 0, 110, 60) ;
    [footview  addSubview:fifvebutton];
    
    
}

//  最下面三个按钮的点击事件
-(void)onebuttonClick
{
    
    
}

-(void)twobuttonClick
{
    
    
    
}

-(void)lijiGOumaiClick
{
    HYCZViewController *controller=[[HYCZViewController alloc]init];
    [self.navigationController  pushViewController:controller animated:YES];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    OLWTabBarController *tabbarcontroller=(OLWTabBarController *)self.tabBarController;
    tabbarcontroller.zqTabBar.hidden=YES;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    OLWTabBarController *tabbarcontroller=(OLWTabBarController *)self.tabBarController;
    tabbarcontroller.zqTabBar.hidden=NO;
    
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
