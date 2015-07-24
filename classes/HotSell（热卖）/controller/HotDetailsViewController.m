//
//  HotDetailsViewController.m
//  OuLianWang
//
//  Created by hsmj on 15/6/22.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "HotDetailsViewController.h"
#import "OLWTabBarController.h"
#import "ProductJianJieCell.h"
#import "ProductXiangCeCell.h"
#import "ProductPingJiaCell.h"
#import "XTUTableViewCell.h"
#import "HZPhotoBrowser.h"
#import "UILabel+StringFrame.h"
#import <MediaPlayer/MediaPlayer.h>
#import "HotDModel.h"
#import "AFNetworking.h"
#import "Interface.h"
#import "GWCViewController.h"
#import "MPMovieViewController.h"

@interface HotDetailsViewController ()<UITableViewDataSource,UITableViewDelegate,HZPhotoBrowserDelegate,UIAlertViewDelegate>
{
    UITableView *_tableview;
    UITableView *_tableXview;
    UITableView *_tablePJview;
    //int i;
    UILabel *shulabel;
    UIView *view;
    UIView *view2;
    UIView *view3;
    UIView *view4;
    UIScrollView * scrollview;
    NSMutableArray * browserImgs;
    NSArray *imgArr ;
    
    //  接口接受数组
    NSMutableArray *_MutableArray;
    
}
@property(nonatomic,strong)NSArray *srcStringArray;
@end

@implementation HotDetailsViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
   // NSLog(@"===============%@",_Gidstring);
    self.view.backgroundColor=[UIColor whiteColor];
    [self  deplyNavigationController1];
    [self  downloaddata];
    
    [self  creatTableView];
    [self  creatfootView];
    
    imgArr = @[@"xiangqingxiangce01",@"xiangqingxiangce02",@"xiangqingxiangce03",@"xiangqingxiangce04",@"cp2"];
    browserImgs = [NSMutableArray array];
    
}
#pragma mark －－－－－配置导航栏

-(void)deplyNavigationController1
{
    
    self.navigationItem.title=@"商品详情";
    UIButton *fabubutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [fabubutton  setImage:[UIImage imageNamed:@"加号.png"] forState:UIControlStateNormal];
    fabubutton.frame=CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *rightbutton=[[UIBarButtonItem alloc]initWithCustomView:fabubutton];
    self.navigationItem.rightBarButtonItem=rightbutton;
    
}


-(void)diquButtonClick:(UIButton *)button
{
    [self.navigationController  popViewControllerAnimated:YES];
}


-(void)downloaddata
{
    _MutableArray=[[NSMutableArray alloc]init];
    
    //   传GID的接口
    NSString *string=@"http://weixin.hsmja.com/wolian/hotsale.php?action=gooddetail&gid=10";
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    // manager.responseSerializer=[AFHTTPResponseSerializer  serializer];
    [manager  GET:string parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dicee=responseObject;
        HotDModel *model=[[HotDModel alloc]initWithDictionary:dicee];
        [_MutableArray addObject:model];
        
        [_tablePJview reloadData];
        [_tableview  reloadData];
        [_tableXview  reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // NSLog(@"%@",error);
        
    }];
    
}


#pragma mark------中间tableVIew

-(void)creatTableView

{
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0,-35,320,568) style:UITableViewStyleGrouped];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    [self.view  addSubview:_tableview];
    
}



-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView==_tableview)
    {
        return 2;
    }
    else
        return 1;
    
}



-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==_tableview)
    {
        if (section==0)
        {
            return 2;
        }
        if (section==1)
        {
            return 1;
        }
        
        return 0;
        
    }
    
    else
        return 10;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tablePJview)
    {
        static NSString *tablepingjiacellid=@"tablepingjiacellid";
        ProductPingJiaCell  *cellpj=[tableView dequeueReusableCellWithIdentifier:tablepingjiacellid];
        if(cellpj==nil)
        {
            cellpj=[[ProductPingJiaCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tablepingjiacellid];
            
        }
        
        HotDModel *model=_MutableArray.firstObject;
        NSArray *comment=model.comment;
        NSDictionary *dic=comment[0];
        cellpj.mingziLabel.text=dic[@"name"];
        [cellpj.imagedeview  setImageWithURL:[NSURL URLWithString: @"http://weixin.hsmja.com/wolian/images/apple.png"]];
        cellpj.JianJiedeLabel.text=@"我的其实自由，是以为自己真的有方向，摇晃，哪一种选择不是在流浪";
        cellpj.JianJiedeLabel.numberOfLines=0;
        cellpj.JianJiedeLabel.font = [UIFont fontWithName:nil size:12];
        //  根据获取到的字符串以及字体计算label需要的size
        CGSize size = [cellpj.JianJiedeLabel boundingRectWithSize:CGSizeMake(300, 0)];
        //  设置label的frame
        cellpj.JianJiedeLabel.frame = CGRectMake(115,10, size.width-100, size.height+50);
        return cellpj;
        
    }
    
    else if(tableView==_tableXview)
    {
        static NSString *tablejianjiecellid=@"tablejianjiecellx1234cellid";
        UITableViewCell *cellx1234=[tableView dequeueReusableCellWithIdentifier:tablejianjiecellid];
        if(cellx1234==nil)
        {
            cellx1234=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tablejianjiecellid];
            
        }
        HotDModel *model=_MutableArray.firstObject;
        NSDictionary *dic=model.list;
        cellx1234.textLabel.text=dic[@"goods_attr"];
        return cellx1234;
    }
    
    else if(tableView==_tableview)
    {
        
        if( indexPath.section==0&&indexPath.row==0)
        {
            static NSString *jianjiecellid=@"ProductJiancell123JieCellidd";
            ProductJianJieCell *jianjiecell12=[tableView  dequeueReusableCellWithIdentifier:jianjiecellid];
            if(jianjiecell12==nil)
            {
                jianjiecell12=[[ProductJianJieCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:jianjiecellid];
                
            }
            
            HotDModel *model=_MutableArray.firstObject;
            NSDictionary *dic=model.list;
           // NSLog(@"zxzxzx%@",dic);
            
            jianjiecell12.imageview.image=[UIImage imageNamed:@"shafa1"];
            jianjiecell12.JianJieLabel.text=dic[@"goodsname"];
            [jianjiecell12.fenxiaoButton  setImage:[UIImage imageNamed:@"n_5.jpg"] forState:UIControlStateNormal];
            
            return jianjiecell12;
            
        }
        
        if(indexPath.section==0&&indexPath.row==1)
        {
            static NSString *xiangcecellid=@"cell123ProductXiangCeCell";
            ProductXiangCeCell *xiangcecell=[tableView  dequeueReusableCellWithIdentifier:xiangcecellid];
            if(xiangcecell==nil)
            {
                
                xiangcecell=[[ProductXiangCeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:xiangcecellid];
                
            }
            HotDModel *model=_MutableArray.firstObject;
            NSDictionary *list=model.list;
            xiangcecell.JianJieLabel.text=[NSString  stringWithFormat:@"￥%@",list[@"price"]];
            xiangcecell.fenleiLabel.text=[NSString stringWithFormat:@"分类:%@",list[@"g_catgryname"]];
            xiangcecell.yishouLabel.text=[NSString  stringWithFormat:@"已售:%@",list[@"sales"]];
            xiangcecell.huoyuanLabel.text=@"货源：广州";
            // [xiangcecell.button   setTitle:@"我连会员充值5%" forState:UIControlStateNormal];
            // xiangcecell.button.titleLabel.font=[UIFont systemFontOfSize:13];
            // [xiangcecell.button  setTitleColor:[UIColor  whiteColor] forState:UIControlStateNormal];
            
            for(int j=0;j <3;j++)
            {
                UIImageView  *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(10+100*j , 10, 90, 90)];
                imageview.image=[UIImage imageNamed:@"n_4.jpg"];
            }
            return xiangcecell;
        }

        else
        {
            static NSString *tableviewcellid=@"cell123tableviewcellid";
            UITableViewCell *cell123=[tableView dequeueReusableCellWithIdentifier:tableviewcellid];
            if(cell123==nil)
            {
                cell123=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableviewcellid];
                
            }
            cell123.selectionStyle= UITableViewCellSelectionStyleNone;
            view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 300)];
            UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10,20,80, 20)];
            label1.text=@"商品介绍";
            label1.font=[UIFont  boldSystemFontOfSize:17];
            label1.textColor=[UIColor blueColor];
            [view  addSubview:label1];
            
            // 字符串
            NSString *str = @"       我的其实一样自由是以为自己真的有方向哪一种选择不是在流浪不管却不能不管注视的目光抵抗不了欣才是最大的伤还有多少的坚强还有多少的梦想那些值得骄傲的全都一样其实一样自由是以为自己真的有方向哪一种选择不是在流浪不管却不能不管注视的目光抵抗不了欣才是最大的伤还有多的目光抵抗不了欣才是最大的伤还有多少的坚强还有多少的梦想那些值得骄傲的全都一样其实一样自由是以为自己真的有方向哪一种选择不是在流浪不管却不能不管注视的目光抵抗不了欣";
            // 初始化label
            UILabel *label = [[UILabel alloc]init];
            // label获取字符串
            label.text = str;
            // label获取字体
            label.font = [UIFont fontWithName:nil size:12];
            // 根据获取到的字符串以及字体计算label需要的size
            CGSize size = [label boundingRectWithSize:CGSizeMake(300, 0)];
            
            // 设置无限换行
            label.numberOfLines = 0;
            
            // 设置label的frame
            label.frame = CGRectMake(10, 55, size.width, size.height);
            [view  addSubview:label];
            
            
            UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(10,size.height+10+55,80, 20)];
            label3.text=@"商品展示";
            label3.font=[UIFont  boldSystemFontOfSize:17];
            label3.textColor=[UIColor blueColor];
            [view  addSubview:label3];
            
            
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0,size.height+30+55, cell123.width,60)];
            imgView.image = [UIImage imageNamed:@"dianpuxiangqingxiangcelun"];
            imgView.userInteractionEnabled = YES;
            [view  addSubview:imgView];
            
            scrollview  = [[UIScrollView alloc]initWithFrame:imgView.bounds];
            scrollview.showsHorizontalScrollIndicator = NO;
            [imgView addSubview:scrollview];
            scrollview.contentSize = CGSizeMake(cell123.width/4*imgArr.count, 60);
            [imgView addSubview:scrollview];
            for (int i = 0; i<imgArr.count; i++)
            {
                UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20+(cell123.width-20)/4*i , 10, (cell123.width-100)/4, 60)];
                UIImage *img =[UIImage imageNamed:imgArr[i]];
                [browserImgs addObject:img];
                imgView.image = img;
                imgView.tag = i;
                imgView.userInteractionEnabled = YES;
                UITapGestureRecognizer * tapImg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImg:)];
                [imgView addGestureRecognizer:tapImg];
                [scrollview addSubview:imgView];
                
            }
            
            
            [cell123  addSubview:view];
            
            
            view2=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 400)];
            _tableXview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 400) style:UITableViewStylePlain];
            _tableXview.delegate=self;
            _tableXview.dataSource=self;
            _tableXview.scrollEnabled=NO;
            view2.hidden=YES;
            [view2  addSubview:_tableXview];
            [cell123  addSubview:view2];
            
            view3=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 400)];
            
            //视屏播放器
            
            UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
            button.backgroundColor=[UIColor blackColor];
            [button  setTitle:@"播放" forState:UIControlStateNormal];
            button.frame=CGRectMake(100, 100, 100, 50);
            [view3  addSubview:button];
            [button  addTarget:self action:@selector(buttonclickaa) forControlEvents:UIControlEventTouchUpInside];
            
            view3.backgroundColor=[UIColor whiteColor];
            view3.hidden=YES;
            [cell123  addSubview:view3];
            
            view4=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 600)];
            view4.hidden=YES;
            _tablePJview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 600) style:UITableViewStylePlain];
            _tablePJview.delegate=self;
            _tablePJview.dataSource=self;
            //   _tablePJview.scrollEnabled=NO;
            [view4  addSubview:_tablePJview];
            [cell123  addSubview:view4];
            return cell123;
            
        }
        
    }
    
    return nil;
}

-(void)buttonclickaa
{
    MPMovieViewController *mv=[[MPMovieViewController alloc]init];
    [self.navigationController pushViewController:mv animated:YES];
   
    
}

#pragma mark-------图文详情界面里面图片点击放大事件
-(void)tapImg:(UITapGestureRecognizer *)tapGestureRecognizer
{
    HZPhotoBrowser * photoBrowser = [[HZPhotoBrowser alloc]init];
    photoBrowser.sourceImagesContainerView =scrollview;
    photoBrowser.imageCount = imgArr.count;
    photoBrowser.currentImageIndex = tapGestureRecognizer.view.tag;
    photoBrowser.delegate = self;
    [self.navigationController pushViewController:photoBrowser animated:NO];
}




-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (tableView==_tableview)
    {
        
        if(section==1)
        {
            return 40;
        }
        return 0;
    }
    else
        return 0;
    
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView==_tableview)
    {
        
        if(section==1)
        {
            UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
            NSArray *array=@[@"图文详情",@"产品属性",@"视屏演示",@"商品评价"];
            for(int i=0;i<4;i++)
            {
                UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
                [button  setTitle:array[i] forState:UIControlStateNormal];
                [button  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button  setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
                button.titleLabel.font=[UIFont  boldSystemFontOfSize:14];
                button.layer.borderWidth=0.5;
                [button  addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                button.layer.borderColor=ZQColor(220, 220, 220).CGColor;
                button.frame=CGRectMake(320/4*i,0, 320/4, 40);
                button.backgroundColor=[UIColor redColor];
                [view1 addSubview:button];
                button.tag=280+i ;
                button.selected=NO;
                
                if ( button.tag==280)
                {
                    button.selected=YES;
                    button.backgroundColor=[UIColor  whiteColor];
                }
                
                [view1 addSubview:button];
                
            }
            
            return view1;
        }
    }
    else
        return nil;
    
    return nil;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tablePJview)
    {
        return 150;
    }
    
    if(tableView==_tableview)
    {
        
        if (indexPath.section==0&&indexPath.row==0)
        {
            
            return 380;
        }
        if (indexPath.section==0&&indexPath.row==1)
        {
            
            return 65;
        }
        if (indexPath.section==1&&indexPath.row==0)
        {
            
            return 300;
        }
        
        return 0;
    }
    else
        return 40;
    
}
#pragma mark-------四个选择按钮的点击事件
-(void)buttonClick:(UIButton *)but
{
    for(int i=280;i<284;i++)
    {
        UIButton *bu=(UIButton *)[self.view viewWithTag:i];
        bu.selected=NO;
        bu.backgroundColor=[UIColor redColor];
    }
    but.selected=YES;
    but.backgroundColor=[UIColor whiteColor];
    
    if(but.tag==280)
    {
        view.hidden=NO;
        view2.hidden=YES;
        view3.hidden=YES;
        view4.hidden=YES;
        // NSLog(@"1");
        
    }
    if(but.tag==281)
    {
        view.hidden=YES;
        view2.hidden=NO;
        view3.hidden=YES;
        view4.hidden=YES;
        //NSLog(@"14");
        [_tableXview reloadData];
    }
    if(but.tag==282)
    {
        view.hidden=YES;
        view2.hidden=YES;
        view3.hidden=NO;
        view4.hidden=YES;
        // NSLog(@"13");
    }
    if(but.tag==283)
    {
        view.hidden=YES;
        view2.hidden=YES;
        view3.hidden=YES;
        view4.hidden=NO;
        // NSLog(@"12");
        [_tablePJview reloadData];
    }
    
    
    
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
    onebutton.frame=CGRectMake(10, 5, 40, 40) ;
    [footview  addSubview:onebutton];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(17,40, 40, 20)];
    label.text=@"客服";
    label.textColor=[UIColor blackColor];
    label.font=[UIFont systemFontOfSize:12];
    [footview  addSubview:label];
    
    UIButton *twobutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [twobutton  setImage:[UIImage imageNamed:@"商品详情_05.png"] forState:UIControlStateNormal];
    twobutton.frame=CGRectMake(70, 5, 40, 40) ;
    [footview  addSubview:twobutton];
    
    UILabel *twolabel=[[UILabel alloc]initWithFrame:CGRectMake(77,40, 40, 20)];
    twolabel.text=@"电话";
    twolabel.textColor=[UIColor blackColor];
    twolabel.font=[UIFont systemFontOfSize:12];
    [footview  addSubview:twolabel];
    
    //  加入购物车按钮
    UIButton *threebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [threebutton  setImage:[UIImage imageNamed:@"商品详情_07.png"] forState:UIControlStateNormal];
    [threebutton  addTarget:self action:@selector(jiabuttonclick) forControlEvents:UIControlEventTouchUpInside];
    threebutton.frame=CGRectMake(127, 5, 40, 40) ;
    [footview  addSubview:threebutton];
    
    UILabel *threelabel=[[UILabel alloc]initWithFrame:CGRectMake(136,40, 40, 20)];
    threelabel.text=@"收藏";
    threelabel.textColor=[UIColor blackColor];
    threelabel.font=[UIFont systemFontOfSize:12];
    [footview  addSubview:threelabel];
    
    UIButton *fourbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [fourbutton  setImage:[UIImage imageNamed:@"商品详情_09.png"] forState:UIControlStateNormal];
    fourbutton.frame=CGRectMake(190,3, 40, 40) ;
    [fourbutton  addTarget:self action:@selector(gouwubutton) forControlEvents:UIControlEventTouchUpInside];
    [footview  addSubview:fourbutton];
    
    UILabel *fourlabel=[[UILabel alloc]initWithFrame:CGRectMake(180,40,100,20)];
    fourlabel.text=@"加入购物车";
    fourlabel.textColor=[UIColor blackColor];
    fourlabel.font=[UIFont systemFontOfSize:12];
    [footview  addSubview:fourlabel];
    
    UIButton *fifvebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    fifvebutton.backgroundColor=[UIColor redColor];
    [fifvebutton  setTitle:@"立即购买" forState:UIControlStateNormal];
    fifvebutton.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    [fifvebutton  setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [fifvebutton addTarget:self action:@selector(lijiGOumaiClick) forControlEvents:UIControlEventTouchUpInside];
    fifvebutton.frame=CGRectMake(245, 0, 90, 60) ;
    [footview  addSubview:fifvebutton];
    
    
}

#pragma mark-----加入购物车POST方法
-(void)gouwubutton
{
    MyAccount * account = [MyAccountTool account];
    if (!account) {
        [self.navigationController pushViewController:[LogInViewController new] animated:YES];
        return;
    }

    NSString *urlString=@"http://weixin.hsmja.com/wolian/personcenter.php?";
    NSString *userid=account.userid;
    NSString *gid=@"1";
    NSString *storeid=@"3";
    NSString *gname=@"小鸡炖蘑菇";
    NSString *goods_attr=@"红色M号";
    NSString *price=@"12.5";
    NSString *number=@"1";
    NSString *action=@"addshopcar";
    //  key===========================
    NSString *key=[NewMD5 md5:[NSString  stringWithFormat:@"%@%@%@%@%@%@%@",userid,gid,storeid,gname,number,price,@"esaafafasfafafsaff"]];
    NSLog(@"----------%@",key);
    
    //  拼接参数========================
    NSDictionary *parames=@{@"action":action,@"userid":userid,@"gid":gid,@"storeid":storeid,@"gname":gname,@"goods_attr":goods_attr,@"price":price,@"number":number,@"key":key};
    
    //  发起请求============================
    AFHTTPRequestOperationManager *mgr1=[AFHTTPRequestOperationManager manager];
    [mgr1  POST:urlString parameters:parames success:^(AFHTTPRequestOperation *operation, id responseObject) {
        UIAlertView *ALview=[[UIAlertView alloc]initWithTitle:@"添加成功" message:nil delegate:self cancelButtonTitle:@" 知道了" otherButtonTitles:@"到购物车查看", nil];
        
        [ALview  show];

        NSLog(@"%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
    }];
    
}


#pragma mark-----购买点击事件

-(void)lijiGOumaiClick
{
    MyAccount * account = [MyAccountTool account];
    if (!account) {
        [self.navigationController pushViewController:[LogInViewController new] animated:YES];
        return;
    }
    
    
    
    
    
}

#pragma mark-----收藏方法

-(void)jiabuttonclick
{
    
    MyAccount * account = [MyAccountTool account];
    if (!account) {
        [self.navigationController pushViewController:[LogInViewController new] animated:YES];
        return;
    }
    
    
    
    
}
#pragma mark - photobrowser代理方法
- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return browserImgs[index];
}

- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = self.srcStringArray[index] ;
    return nil;
}


#pragma mark------标签栏的隐藏和现实
-(void)viewWillAppear:(BOOL)animated
{
    
    OLWTabBarController * tabBarVC =(OLWTabBarController *) self.tabBarController;
    tabBarVC.zqTabBar.hidden = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    OLWTabBarController * tabBarVC =(OLWTabBarController *) self.tabBarController;
    tabBarVC.zqTabBar.hidden =NO;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%d",buttonIndex);
    if (buttonIndex==1) {
        [self.navigationController pushViewController:[GWCViewController new] animated:YES  ];
    }
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
