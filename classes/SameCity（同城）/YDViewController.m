//
//  YDViewController.m
//  OuLianWang
//
//  Created by hsmj on 15/6/29.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "YDViewController.h"
#import "OneTableViewCell.h"
#import "TwoTableViewCell.h"
#import "ThreeTableViewCell.h"
#import "FourTableViewCell.h"
#import "OLWTabBarController.h"
#import "YDModel.h"
#import "LCImageView.h"
#import "UIView+LCView.h"

@interface YDViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *_tableview;
    int h;
    
    NSMutableArray *_mutablearray;
    NSMutableArray *_dataArray;//装载数据
    UILabel *_howManyLabel;//多少件
    UILabel *_howMuchLabel;//商品多少钱
    UILabel *_allMuchLabel;//全部一共多少钱
    UILabel *_vipAllMuchLabel;//VIP全部一共多少钱
    NSString *_YouFei;//邮费
    NSString *_fapiao;//发票
    int _howMany;
    float _howMuch;
}


@property(nonatomic,strong)UIView *sectionView1;
@property(nonatomic,strong)UIView *sectionView4;


@end

@implementation YDViewController
-(UIView *)sectionView1
{
    if (_sectionView1==nil) {
        
        _sectionView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        _sectionView1.backgroundColor=[UIColor whiteColor];
        NSArray *titltarray=@[@"全部",@"删除",@"添加"];
        NSArray *imageArray=@[@"选择",@"删除",@"添加"];
        for(int j=0;j<3;j++)
        {
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=CGRectMake(60*j ,5, 80, 30);
            [button  setTitle:titltarray[j] forState:UIControlStateNormal];
            button.titleLabel.font=[UIFont systemFontOfSize:14];
            [button  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button  setImage:[UIImage imageNamed:imageArray[j]] forState:UIControlStateNormal];
            [button  setImageEdgeInsets:UIEdgeInsetsMake(0,-8, 0, 0)];
            [button  setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
            button.tag=300+j ;
            if (button.tag==300) {
                
                [button  setImage:[UIImage imageNamed:@"ydnoselect"] forState:UIControlStateNormal];
                
                [button  setImage:[UIImage imageNamed:@"ydselect"] forState:UIControlStateSelected];
            }
            [button   addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
            [_sectionView1  addSubview:button];
            
        }
        _howManyLabel=[[UILabel alloc]initWithFrame:CGRectMake(200, 0,120, 30)];
        _howManyLabel.text=[NSString stringWithFormat:@"共 %d 件",_howMany];
        _howManyLabel.textColor=[UIColor  redColor];
        _howManyLabel.font=[UIFont  systemFontOfSize:14];
        [_sectionView1  addSubview:_howManyLabel];
        
        _howMuchLabel=[[UILabel alloc]initWithFrame:CGRectMake(200,20,120, 30)];
        _howMuchLabel.text=[NSString stringWithFormat:@"合计:￥%.2f",_howMuch];
        _howMuchLabel.textColor=[UIColor  redColor];
        _howMuchLabel.font=[UIFont  systemFontOfSize:14];
        [_sectionView1  addSubview:_howMuchLabel];
        
        UIImageView *im1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 50, 320, 5)];
        im1.image=[UIImage imageNamed:@"line2line2"];
        [_sectionView1 addSubview:im1];
        

    }
    return _sectionView1;

}
//-(UIView *)sectionView4
//{
//    if (_sectionView4==nil) {
//        _sectionView4=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
//        _sectionView4.backgroundColor=[UIColor whiteColor];
//        UILabel *ll=[_sectionView4 addLabelWithFrame:CGRectMake(10, 5, 75, 25) text:@"套餐合计："];
//        ll.font=[UIFont systemFontOfSize:15];
//        
//        float money=_howMuch+[_YouFei floatValue]+[_fapiao floatValue];
//        
//        _allMuchLabel=[_sectionView4 addLabelWithFrame:CGRectMake(ll.frame.origin.x+ll.frame.size.width, 5, 80, 25) text:[NSString stringWithFormat:@"¥%.2f",money]];
//        
//        _allMuchLabel.textColor=ZQColor(233, 137, 68);
//        _allMuchLabel.font=[UIFont systemFontOfSize:15];
//        _vipAllMuchLabel=[_sectionView4 addLabelWithFrame:CGRectMake(self.view.width-70, 5, 80, 25) text:@"¥1233.00"];
//        _vipAllMuchLabel.textColor=ZQColor(202, 41, 32);
//        _vipAllMuchLabel.font=[UIFont systemFontOfSize:15];
//        UILabel *ll2=[_sectionView4 addLabelWithFrame:CGRectMake(_vipAllMuchLabel.frame.origin.x-60, 5, 60, 25) text:@"会员价："];
//        ll2.font=[UIFont systemFontOfSize:15];
//        
//
//        
//    }
//    return _sectionView4;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    
    _mutablearray=[[NSMutableArray alloc]init];
    _howMany=0;
    _howMuch=0;
    
    _dataArray=[NSMutableArray array];
    //测试
    for (int i=0; i<4; i++) {
        YDModel *mm=[[YDModel alloc]init];
        mm.price=@"222";
        mm.title=[NSString stringWithFormat:@"床头柜地中海床还还订货会的撒谎的的撒旦噶三大哈市各大打算叫大哥%d",i];
        
        [_dataArray addObject:mm];
    }
    
    
    [self  creattableview];
    
    [self  creatfootView];
    
    [self  deplyNavigationController1];
    
    
}

#pragma mark-----配置导航栏
-(void)deplyNavigationController1
{
    self.title=@"预定家具";
    
}


#pragma mark-----创建tableview
-(void)creattableview
{
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 548) style:UITableViewStyleGrouped];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    [self.view  addSubview:_tableview];

}


-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
     return 4;
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return _dataArray.count;
      
    }
    else
        return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  第一组的Cell
    if(indexPath.section==0)
    {
        static NSString *onecellid=@"onecellid";
        OneTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:onecellid];
        cell=[[OneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:onecellid];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        YDModel *model=_dataArray[indexPath.row];
        cell.ydModel=model;
        cell.imageview.image=[UIImage imageNamed:@"zxzx.png"];
        cell.titleLabel.text=model.title;
        cell.changLabel.text=@"长:3 米";
        cell.kuanLabel.text=@"宽:8 米";
        cell.gaoLabel.text=@"高:4 米";
        cell.xinghaoLabel.text=@"型号:欧式EB-12";
        cell.yanseLabel.text=@"颜色:白色";
        cell.yuanpriceLabel.text=@"￥888.00";
        cell.xianpriceLabel.text=[NSString stringWithFormat:@"￥%.2f",[model.price floatValue]];
        cell.priceLabel.text=@" 1 ";
        
        //设置model
        YDModel *mm=_dataArray[indexPath.row];
        cell.ydModel=mm;
        if (mm.selected) {
            cell.xuanzeButton.selected=YES;
        }
        else
            cell.xuanzeButton.selected=NO;
        
        BOOL and =NO;
        for (OneTableViewCell *cc in _mutablearray) {
            if ([cell.titleLabel.text isEqualToString:cc.titleLabel.text]) {
                and=YES;
            }
        }
        if (!and) {
            [_mutablearray  addObject:cell];
        }
        
        
        [cell setPriceblock11:^(YDModel * model) {
            model.selected=YES;
            _howMuch+= ([model.price floatValue]*cell.count);
            
            _howMuchLabel.text=[NSString stringWithFormat:@"合计:￥%.2f",_howMuch];
            
            _howMany+=cell.count;
            _howManyLabel.text=[NSString stringWithFormat:@"共 %d 件",_howMany];
            
            NSIndexSet *set=[[NSIndexSet alloc]initWithIndex:3];
            [tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
        }];
        
        [cell setPriceblock22:^(YDModel * model) {
            model.selected=NO;
            _howMany-=cell.count;
            if (_howMany<0) {
                return ;
            }
            _howManyLabel.text=[NSString stringWithFormat:@"共 %d 件",_howMany];
            
            _howMuch-= ([model.price floatValue]*cell.count);
            _howMuchLabel.text=[NSString stringWithFormat:@"合计:￥%.2f",_howMuch];
        }];
       
        [cell setJiablock:^(YDModel * model) {

            _howMuch+=[model.price floatValue];
            _howMuchLabel.text=[NSString stringWithFormat:@"合计:￥%.2f",_howMuch];
            
            _howMany++;
            _howManyLabel.text=[NSString stringWithFormat:@"共 %d 件",_howMany];
        }];
        
        [cell setJianblock:^(YDModel * model) {
            _howMany--;
            if (_howMuch<=0) {
                return ;
            }
            _howManyLabel.text=[NSString stringWithFormat:@"共 %d 件",_howMany];
            
            _howMuch-=[model.price floatValue];
            _howMuchLabel.text=[NSString stringWithFormat:@"合计:￥%.2f",_howMuch];
            
        }];
        return cell;
    }

    
    //  第二组的Cell
    if (indexPath.section==1)
    {
        TwoTableViewCell *cell2=[tableView dequeueReusableCellWithIdentifier:nil];
        if (cell2==nil) {
            cell2=[[TwoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        }
        cell2.shouhuoLabel.text=@"收货人： 李聪";
        cell2.lianxiLabel.text=@"联系电话：123456789";
        cell2.dizhiLabel.text=@"收货地址：广东省茂名市毛毛大道321号";
        cell2.youzhenLabel.text=@"邮政编码：123456";
        [cell2.ditubutton setImage:[UIImage  imageNamed:@"ydlocation"] forState:UIControlStateNormal];
        return cell2;
        
        
        
    }
    
    //  第三组的Cell
    if(indexPath.section==2)
    {
        ThreeTableViewCell *sixcell=[tableView dequeueReusableCellWithIdentifier:nil];
        
        if(sixcell==nil)
        {
            sixcell=[[ThreeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
        }
        
        _YouFei=sixcell.youLabel.text;
        _fapiao=sixcell.muchLable.text;
        
        return sixcell;
    
    }
    

    //  第二组第六行的Cell
    if(indexPath.section==3)
    {
        FourTableViewCell *eightcell=[tableView dequeueReusableCellWithIdentifier:nil];
        
        if(eightcell==nil)
        {
            eightcell=[[FourTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
        }
        

        return eightcell;
        
    }
    
    //  第二组第七行的Cell
//    if(indexPath.section==1&&indexPath.row==6)
//    {
//        UITableViewCell *ninthcell=[tableView dequeueReusableCellWithIdentifier:nil];
//        
//        if(ninthcell==nil)
//        {
//            ninthcell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//            
//        }
//        UILabel *sixlabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 30)];
//        sixlabel.text=@"套餐合计：";
//        sixlabel.font=[UIFont systemFontOfSize:13];
//        [ninthcell  addSubview:sixlabel];
//        
//        UILabel *sevenlabel=[[UILabel alloc]initWithFrame:CGRectMake(210, 10, 200, 30)];
//        sevenlabel.text=@"会员价：";
//        sevenlabel.font=[UIFont systemFontOfSize:13];
//        [ninthcell  addSubview:sevenlabel];
//
//        return ninthcell;
//        
//    }
//    //  第二组第八行的Cell
//    if(indexPath.section==1&&indexPath.row==7)
//    {
//        UITableViewCell *tenthcell=[tableView dequeueReusableCellWithIdentifier:nil];
//        
//        if(tenthcell==nil)
//        {
//            tenthcell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//            
//        }
//        UILabel *eightlabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 30)];
//        eightlabel.text=@"单号：Eadadhakhdkajsdjad";
//        eightlabel.textColor=[UIColor grayColor];
//        eightlabel.font=[UIFont systemFontOfSize:13];
//        [tenthcell  addSubview:eightlabel];
//        
//        UILabel *ninlabel=[[UILabel alloc]initWithFrame:CGRectMake(195, 10, 200, 30)];
//        ninlabel.text=@"2015-07-1  11:09:12";
//        ninlabel.font=[UIFont systemFontOfSize:13];
//        ninlabel.textColor=[UIColor grayColor];
//        [tenthcell  addSubview:ninlabel];
//    
//        return tenthcell;
//        
//        
//        
//        
//    }
    
    else
        return nil;
    


}


#pragma mark-------返回第一组头部视图
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0)
       return 80;
    else if(section==1||section==2||section==3)
        return 33;
    
    else
        return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section==0) {
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
        view.backgroundColor=[UIColor whiteColor];
        UIImageView *im=[[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 10, 20)];
        im.backgroundColor=ZQColor(232, 77, 37);
        [view addSubview:im];
        UILabel *onelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 150, 30)];
        onelabel.text=@"您选择的商品";
        onelabel.textColor=[UIColor orangeColor];
        onelabel.font=[UIFont systemFontOfSize:16];
        [view  addSubview:onelabel];
        UIImageView *im1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 35, 320, 1)];
        im1.image=[UIImage imageNamed:@"line2line2"];
        [view addSubview:im1];
    
        UIImageView  * oneimage=[[UIImageView alloc]initWithFrame:CGRectMake(10,45, 30, 30)];
        oneimage.image=[UIImage imageNamed:@"zxzx.png"];
        [view  addSubview:oneimage];
        
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(45, 45, 100, 30)];
        label1.text=@"豪瑟家具";
        label1.textColor=[UIColor blackColor];
        label1.font=[UIFont systemFontOfSize:16];
        [view  addSubview:label1];
        
        NSArray *imagearray=@[@"ydmessage",@"ydphoto"];
        //发信息
        LCImageView  * image1=[[LCImageView alloc]init];
        image1.frame=CGRectMake(230,45,30,30);
        image1.image=[UIImage imageNamed:imagearray[0]];
        [image1 setMyBlock:^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms://800888"]];
        }];
        [view  addSubview:image1];
        
        //打电话
        LCImageView  * image2=[[LCImageView alloc]init];
        image2.frame=CGRectMake(230+45,45,30,30);
        image2.image=[UIImage imageNamed:imagearray[1]];
        [image2 setMyBlock:^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://8008808888"]];
        }];
        [view  addSubview:image2];

        return view;
            
    }
    
    else if (section==1){
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
        view.backgroundColor=[UIColor whiteColor];
        UIImageView *im=[[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 10, 20)];
        im.backgroundColor=ZQColor(28, 102, 188);
        [view addSubview:im];
        UILabel *onelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 150, 30)];
        onelabel.text=@"收货人信息";
        onelabel.textColor=ZQColor(28, 102, 188 );
        [view addSubview:onelabel];
        UIView *vv=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-70,0 , 60, 30)];
        UILabel *ll=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        ll.text=@"编辑";
        ll.font=[UIFont systemFontOfSize:12];
        [vv addSubview:ll];
        UIImageView *ii=[[UIImageView alloc]initWithFrame:CGRectMake(40, 5, 16, 16)];
        ii.image=[UIImage imageNamed:@"yddown"];
        [vv addSubview:ii];
        [view addSubview:vv];
        return view;
    }
    
    else if (section==2){
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
        view.backgroundColor=[UIColor whiteColor];
        UIImageView *im=[[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 10, 20)];
        im.backgroundColor=ZQColor(62, 154, 117);
        [view addSubview:im];
        UILabel *onelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 150, 30)];
        onelabel.text=@"配送方式";
        onelabel.textColor=ZQColor(62, 154, 117);
        [view addSubview:onelabel];
        return view;
    }
    else if (section==3){
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
        view.backgroundColor=[UIColor whiteColor];
        UIImageView *im=[[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 10, 20)];
        im.backgroundColor=ZQColor(65, 113, 10);
        [view addSubview:im];
        UILabel *onelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 150, 30)];
        onelabel.text=@"订单备注";
        onelabel.textColor=ZQColor(65, 113, 10);
        [view addSubview:onelabel];
        return view;
    }

    else
        return nil;

}

#pragma mark-------返回底部视图
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
   
    if (section==0) {
        return 55;
    }
    else if(section==3)
        return 55;
    else
        return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (section==0) {
        return self.sectionView1;
    }
    else if (section==3){
        for (UIView *vi in _sectionView1.subviews) {
            [vi removeFromSuperview];
        }
        
        _sectionView4=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
        _sectionView4.backgroundColor=[UIColor whiteColor];
        UILabel *ll=[_sectionView4 addLabelWithFrame:CGRectMake(10, 5, 75, 25) text:@"套餐合计："];
        ll.font=[UIFont systemFontOfSize:15];
        float money;
        if (_howMany==0) {
            money=0.0;
        }
        else
            money=_howMuch+[_YouFei floatValue]+[_fapiao floatValue];
        
        _allMuchLabel=[_sectionView4 addLabelWithFrame:CGRectMake(ll.frame.origin.x+ll.frame.size.width, 5, 80, 25) text:[NSString stringWithFormat:@"¥%.2f",money]];
        
        _allMuchLabel.textColor=ZQColor(233, 137, 68);
        _allMuchLabel.font=[UIFont systemFontOfSize:15];
        _vipAllMuchLabel=[_sectionView4 addLabelWithFrame:CGRectMake(self.view.width-70, 5, 80, 25) text:[NSString stringWithFormat:@"¥%.2f",money*0.8]];
        _vipAllMuchLabel.textColor=ZQColor(202, 41, 32);
        _vipAllMuchLabel.font=[UIFont systemFontOfSize:15];
        UILabel *ll2=[_sectionView4 addLabelWithFrame:CGRectMake(_vipAllMuchLabel.frame.origin.x-60, 5, 60, 25) text:@"会员价："];
        ll2.font=[UIFont systemFontOfSize:15];
        
        
        
        UIImageView *im1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 30, 320, 1)];
        im1.image=[UIImage imageNamed:@"line2line2"];
        [_sectionView4 addSubview:im1];
        
        
        UILabel *ll3=[_sectionView4 addLabelWithFrame:CGRectMake(10, 35, 160, 20) text:[NSString stringWithFormat:@"单号：%@",@"E1231214141432"]];
        ll3.textColor=[UIColor grayColor];
        ll3.font=[UIFont systemFontOfSize:12];
        
        UILabel *ll4=[_sectionView4 addLabelWithFrame:CGRectMake(180, 35, 160, 20) text:@"2015-06-17 11:09:14"];
        ll4.textColor=[UIColor grayColor];
        ll4.font=[UIFont systemFontOfSize:12];

        
        return self.sectionView4;
    }
    
    else
        return nil;
}



-(void)buttonclick:(UIButton *)button
{
   
    if (button.tag==300) {
        if(button.selected==NO){
            for (YDModel *mm in _dataArray) {
                mm.selected=YES;
            }
            NSIndexSet *set =[[NSIndexSet alloc]initWithIndex:0];
            [_tableview reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
            button.selected=YES;
            _howMany=0;
            _howMuch=0.0;
            for (OneTableViewCell *cell in _mutablearray) {
                _howMuch+= ([cell.ydModel.price floatValue]*cell.count);
                _howMany+=cell.count;
            }
            _howMuchLabel.text=[NSString stringWithFormat:@"合计:￥%.2f",_howMuch];
            _howManyLabel.text=[NSString stringWithFormat:@"共 %d 件",_howMany];
        }
        else
        {
            for (YDModel *mm in _dataArray) {
                mm.selected=NO;
            }
            NSIndexSet *set =[[NSIndexSet alloc]initWithIndex:0];
            [_tableview reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
            button.selected=NO;
            _howMuch=0;
            _howMany=0;
            
        _howMuchLabel.text=[NSString stringWithFormat:@"合计:￥%.2f",0.0];
        _howManyLabel.text=[NSString stringWithFormat:@"共 %d 件",0];

        }
    
    }

}


#pragma mark-------返回高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if(indexPath.section==0)
    {
        return 120;
        
    }
    
    if (indexPath.section==1)
    {
        return 120;
    }
    if (indexPath.section==2)
    {
        return 80;
    }
    if (indexPath.section==3)
    {
        return 120;
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
    [onebutton  setImage:[UIImage imageNamed:@"商品详情_03.png"] forState:UIControlStateNormal];
    onebutton.frame=CGRectMake(10, 10, 40, 40) ;
    [onebutton  addTarget:self action:@selector(onebuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [onebutton    setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [footview  addSubview:onebutton];
    
    UILabel *onelabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 10, 70, 40)];
    onelabel.text=@"联系客服";
    onelabel.font=[UIFont systemFontOfSize:14];
    [footview  addSubview:onelabel];
    
    
    UIButton *twobutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [twobutton  setImage:[UIImage imageNamed:@"商品详情_07.png"] forState:UIControlStateNormal];
    twobutton.frame=CGRectMake(320/3+10, 10, 40, 40);
    [twobutton  addTarget:self action:@selector(twobuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [twobutton    setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [footview  addSubview:twobutton];
    
    UILabel *twolabel=[[UILabel alloc]initWithFrame:CGRectMake(320/3+50, 10, 70, 40)];
    twolabel.text=@"加入收藏";
    twolabel.font=[UIFont systemFontOfSize:14];
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
