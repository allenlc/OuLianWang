//
//  JuHuaViewController.m
//  OuLianWang
//
//  Created by hsmj on 15/6/19.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "JuHuaViewController.h"
#import "ZQSearchBar.h"
#import "JHSCell.h"
#import "Interface.h"
#import "AFNetworking.h"
#import "JHSModel.h"
#import "WDXXViewController.h"

@interface JuHuaViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UIView * midview ;
    UIView *listView;
    UISearchBar *_searchbar;
    UIView *_view;
    
    //  轮播数组
    NSMutableArray *_dataArray;
    
    //  轮播数组
    NSMutableArray *_FLdataArray;
    
    
    //  轮播数组
    NSMutableArray *_SPdataArray;
    NSMutableArray *_shangpArray;
    
}

@property(nonatomic,strong)UITableView * hotSellTableView;
@property(nonatomic,strong)UIButton * selectBtn;

@end

@implementation JuHuaViewController

- (void)viewDidLoad
{
    
    self.view.backgroundColor=ZQColor(232, 232, 232);
    
    [super viewDidLoad];

    //   配置导航条
    [self  setNavigationController];
    
    //   下载数据
    [self  downloaddata];
    
    //  创建分类按钮
    //[self creatlestbutton];
    
    
    // 创建分类视图
     [self setListView];
    
    //  创建tableview
    // [self creattableview];
    
}


#pragma mark -----配置导航栏

-(void)setNavigationController
{
    //self.navigationItem.title=@"巨划算";
    _searchbar=[[UISearchBar alloc]initWithFrame:CGRectMake(0,0, 260, 40)];
    _searchbar.placeholder=@"搜索巨划算商品...";
    _searchbar.delegate=self;
    _searchbar.searchBarStyle=UISearchBarStyleProminent;
    self.navigationItem.titleView =_searchbar;
    
    
//    UIButton *fabubutton=[UIButton buttonWithType:UIButtonTypeCustom];
//    [fabubutton setImage:[UIImage imageNamed:@"ziliaogengguoanniu3-4"] forState:0];
//    fabubutton.frame=CGRectMake(0, 0, 30, 40);
//    UIBarButtonItem *rightbutton=[[UIBarButtonItem alloc]initWithCustomView:fabubutton];
//    
    UIButton *nearbyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [nearbyBtn  setTitle:@"附近" forState:UIControlStateNormal];
    [nearbyBtn  setImage:[UIImage imageNamed:@"消息图标3.png"] forState:UIControlStateNormal];
//    [nearbyBtn setImageEdgeInsets :UIEdgeInsetsMake(3, 50, 0, 0)];
//    [nearbyBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
//    [nearbyBtn  setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
//    nearbyBtn.titleLabel.font=[UIFont boldSystemFontOfSize:16];
     nearbyBtn.frame=CGRectMake(0, 0,32,27);
    
     [nearbyBtn  addTarget:self action:@selector(buttonclick) forControlEvents:UIControlEventTouchUpInside];
    
     UIBarButtonItem * rightbtn1 = [[UIBarButtonItem alloc]initWithCustomView:nearbyBtn];
     self.navigationItem.rightBarButtonItems =@[rightbtn1];
   
    
}

-(void)buttonclick
{
    WDXXViewController *rvc=[[WDXXViewController alloc]init];
    [self.navigationController pushViewController:rvc animated:YES];}

-(void)diquButtonClick
{
    [self.navigationController  popViewControllerAnimated:YES];
    
}

#pragma mark----- 下载数据
-(void)downloaddata
{
    _dataArray=[[NSMutableArray alloc]init];
    _FLdataArray=[[NSMutableArray alloc]init];
    _SPdataArray=[[NSMutableArray alloc]init];
    _shangpArray=[[NSMutableArray alloc]init];
    
    
    AFHTTPRequestOperationManager *maneger=[AFHTTPRequestOperationManager manager];
    maneger.responseSerializer=[AFHTTPResponseSerializer serializer];
    [maneger  GET:JUHuaSUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
       //  分类的数组数据源
       NSDictionary *dic=[NSJSONSerialization  JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
       NSLog(@"+++++++%@",dic);
        NSArray *array=dic[@"category"];
        for (NSDictionary *dict in array)
        {
            [_FLdataArray  addObject:dict[@"keyname"]];
        }
        NSLog(@"=========%@",_FLdataArray);
       
        
        //   数据量有点大，写在下载数据的方法后面往往是这个方法去执行了数据好没下载完成。。
        [self creatlestbutton];
        
        //  轮播图的数据源
        NSArray  *luarray=dic[@"promotion"];
        for (NSDictionary *dictt in luarray)
        {
            [_dataArray  addObject:dictt[@"prom_img"]];
            
        }
        
        NSLog(@"%@",_dataArray);
        [_hotSellTableView reloadData ];
        
//        商品类的数据源
//        NSMutableArray  *SPdic=[[NSMutableArray alloc]init];
        NSArray *Sparray=dic[@"goods"];
   
        for (NSDictionary  *dic in Sparray)
        {
            JHSModel *model=[[JHSModel alloc]init];
            model.goodsname=dic[@"goodsname"];
            model.goods_img=dic[@"goods_img"];
            model.price=dic[@"price"];
            model.gid=dic[@"gid"];
            model.kilometer=dic[@"kilometer"];
            [_shangpArray addObject:model];
        }
        

        [self creattableview];
        [_hotSellTableView reloadData];
 
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}


# pragma mark----- 弹出框隐藏方法
-(void)listView:(UIButton *)sender
{
    
    if (sender.selected == NO)
    {
        listView.hidden = sender.selected;
        sender.selected = YES;
    }
    else
    {
        listView.hidden = sender.selected;
        sender.selected = NO;
    }
    
}
#pragma mark-----创建分下拉按钮

-(void)creatlestbutton
{

    
    midview = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, 30)];
    [self.view addSubview:midview];

    //   创建分类按钮
    //NSArray * classes = @[@"全部",@"家居",@"美食",@"服装",@"箱包",@"首饰",@"运动"];
    //NSLog(@"----%@",_FLdataArray);
    for (int i = 0; i<_FLdataArray.count; i++) {
        UIButton * classBtn = [[UIButton alloc]init];
        classBtn.tag  = i+200;
        classBtn.size = CGSizeMake((self.view.width-30)/_FLdataArray.count, 30);
        classBtn.center = CGPointMake(classBtn.width/2+classBtn.width*i, classBtn.height/2);
        [classBtn setTitle:[NSString stringWithFormat:@"%@",_FLdataArray[i]] forState:0];
        
        [classBtn setBackgroundImage:[UIImage resizedImageWithName:@"blue_rm"] forState:UIControlStateNormal];
        [classBtn setBackgroundImage:[UIImage resizedImageWithName:@"write_classes"] forState:UIControlStateSelected];
        [classBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [classBtn setTitleColor:[UIColor whiteColor] forState:0];
        classBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [classBtn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        [midview addSubview:classBtn];
    }
    self.selectBtn =(UIButton *) [midview viewWithTag:200];
    self.selectBtn.selected = YES;
    self.selectBtn.backgroundColor = [UIColor whiteColor];
    self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    //    创建下拉分类按钮
    UIButton * listBtn = [[UIButton alloc]init];
    listBtn.frame = CGRectMake(self.view.width-30, 0  , 30, 30);
    [listBtn setBackgroundImage:[UIImage resizedImageWithName:@"blue_rm"] forState:UIControlStateNormal];
    [listBtn setImage:[UIImage imageNamed:@"V_下"]  forState:0];
    [listBtn setImage:[UIImage imageNamed:@"V_上"]  forState:UIControlStateSelected];
    [listBtn addTarget:self action:@selector(listView:) forControlEvents:UIControlEventTouchUpInside];
    listBtn.selected = NO;
    [midview addSubview:listBtn];

    listView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, self.view.width, 200)];
    listView.backgroundColor = [UIColor grayColor];
    listView.hidden = YES;
    [midview addSubview:listView];
    
    
    
    

}

#pragma mark -----创建下拉视图
-(void)setListView
{
    
    listView = [[UIView alloc]initWithFrame:CGRectMake(0, 94, self.view.width, 400)];
    listView.backgroundColor = [UIColor whiteColor];
    listView.alpha = 0.8;
    
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(40, 20, 40, 20 )];
    label1.text = @"行业";
    label1.font = [UIFont systemFontOfSize:15];
    label1.textColor = [UIColor blueColor];
    [listView addSubview:label1];
    
    UIImageView * lineImgView = [[UIImageView alloc]initWithFrame:CGRectMake(40, 40, self.view.width-80, 1)];
    lineImgView.backgroundColor = [UIColor grayColor];
    [listView addSubview:lineImgView];
    int n = 0;
    NSArray * arr1 = @[@"全部",@"家居",@"美食",@"服装",@"鞋包",@"首饰",@"运动",@"健身",@"数码",@"家电",@"办公",@"工艺",@"玩具",@"化妆",@"家纺",@"百货"];
    for (int i = 0; i<4; i++) {
        for (int j = 0; j<4; j++) {
            UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(40+((self.view.width-200)/3+30)*j, 50+25*i, 30, 20)];
            l.text = arr1[n];
            l.font = [UIFont systemFontOfSize:14];
            [listView addSubview:l];
            n++;
        }
 }
    
    
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(40, 20+130, 40, 20 )];
    label2.text = @"品牌";
    label2.font = [UIFont systemFontOfSize:15];
    label2.textColor = [UIColor greenColor];
    [listView addSubview:label2];
    
    UIImageView * lineImgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(40, 150, self.view.width-80, 1)];
    lineImgView2.backgroundColor = [UIColor grayColor];
    [listView addSubview:lineImgView2];
    
    UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(40, 140+120, 40, 20 )];
    label3.text = @"厂商";
    label3.font = [UIFont systemFontOfSize:15];
    label3.textColor = [UIColor redColor];
    [listView addSubview:label3];
    
    UIImageView * lineImgView3 = [[UIImageView alloc]initWithFrame:CGRectMake(40, 240, self.view.width-80, 1)];
    lineImgView3.backgroundColor = [UIColor grayColor];
    [listView addSubview:lineImgView3];
    
    listView.hidden = YES;
    [self.view addSubview:listView];
    
}

//设置导航按钮


//设置搜索框
#pragma mark -----创建搜索栏
-(void)createSearchBar
{
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.backgroundColor=[UIColor colorWithRed:189/255.0 green:189/255.0 blue:195/255.0 alpha:0.8];
    imageView.frame=CGRectMake(0, 64, 30, 40);
    [self.view  addSubview:imageView];
    
    UIImageView *image=[[UIImageView alloc]init];
    image.frame=CGRectMake(10, 10, 20,20);
    image.image=[UIImage imageNamed:@"down.png"];
    [imageView  addSubview:image];
    
    _searchbar=[[UISearchBar alloc]initWithFrame:CGRectMake(30, 64, 290, 40)];
    _searchbar.placeholder=@"搜索商铺,商店...";
    _searchbar.delegate=self;
    _searchbar.searchBarStyle=UISearchBarStyleProminent;
    [self.view  addSubview:_searchbar];
    
}


#pragma mark-----搜索开始编辑
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    _view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 600)];
    _view.backgroundColor=[UIColor blackColor];
    _view.alpha=0.4;
    [self.view addSubview:_view];
    _view.hidden=NO;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ViewClick:)];
    [_view  addGestureRecognizer:tap];
  
}

-(void)ViewClick:(UITapGestureRecognizer *)tap
{
    tap.view.hidden=YES;
    [_searchbar resignFirstResponder];
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    _view.hidden=YES;
    _searchbar.text=@"";
    [_searchbar resignFirstResponder];
    
}

//分类选择按钮方法
-(void)choose:(UIButton *)sender
{
    self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    self.selectBtn.selected = NO;
    sender.selected = YES;
    self.selectBtn = sender;
    self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
}

#pragma mark-----创建显示tableview
-(void)creattableview
{
    //    滚动视图
    _hotSellTableView =[[UITableView alloc]initWithFrame:CGRectMake(0,64+30, self.view.width, self.view.height-94) style:UITableViewStylePlain];
    _hotSellTableView.delegate = self;
    _hotSellTableView.dataSource = self;
    
    _hotSellTableView.separatorStyle=0;
    [self.view addSubview:_hotSellTableView];
    self.hotSellTableView = _hotSellTableView;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section ==0) {
        return 1;
    }
    return _shangpArray.count/2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0)
    {
        JHSCell * cell = [[JHSCell alloc]init];
        
        cell.dataimageArray=_dataArray;
        [cell setindexPath:indexPath];
        
        return cell;
    }
    else
    {
        
        
        JHSCell * cell1 = [JHSCell cellWithTableViewCell:self.hotSellTableView];
        
        if (_shangpArray.count%2==0)
        {
             cell1.model1 = _shangpArray[indexPath.row*2];
             cell1.model2 = _shangpArray[indexPath.row*2+1];
        }
        else
        {
            if (_shangpArray.count==indexPath.row*2+1)
            {
                cell1.model2 = _shangpArray[indexPath.row*2];
            }
            else
            {
                cell1.model1 = _shangpArray[indexPath.row*2];
                cell1.model2 = _shangpArray[indexPath.row*2+1];
            }
            
        }
        
        [cell1 setindexPath:indexPath];

        return cell1;
    
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 160;
    }
    else{
    return 240;
    }
}



- (void)didReceiveMemoryWarning
{
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
