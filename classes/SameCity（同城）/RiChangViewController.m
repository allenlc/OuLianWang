//
//  RiChangViewController.m
//  OuLianWang
//
//  Created by hsmj on 15/6/16.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "RiChangViewController.h"

@interface RiChangViewController ()
{
    NSMutableArray *_selectedArr;
    NSMutableArray *_annoShowArr;
    int _page;
}
@end

@implementation RiChangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.placeholder=@"搜索附近的生活必需品";
    _selectedArr=[NSMutableArray array];

    [self creatButton];
}
#pragma mark －－－－－ 创建顶部四个Button
-(void)creatButton
{
    
    
    NSArray *titleArray=@[@"超市",@"买菜",@"服装",@"鞋包",@"理发",@"五金",@"电器",@"干洗店",@"家政",@"数码",@"母婴",@"土特产"];
    NSArray *photoArray=@[@"tcchaoshi.png",@"tcmaicai.png",@"tcfuzhuang.png",@"tcxiebao.png",@"tclifa",@"tcwujin",@"tcdianqi",@"tcganxidian",@"tcjiazheng",@"tcshuma",@"tcmuyin",@"tctutechan"];
    NSArray *photoArray2=@[@"综合B_23.png",@"综合B_24.png",@"综合B_25.png",@"综合B_26.png",@"综合B_31.png",@"综合B_32.png",@"综合B_33.png",@"综合B_34.png",@"综合B_39.png",@"综合B_40.png",@"综合B_41.png",@"综合B_42.png"];

    int x=15,y=10;
    for(int i=0;i<12;i++)
    {
        //创建button
        if (i==4||i==8) {
            x=15;
            y+=75;
        }
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius=27;
        btn.frame=CGRectMake(x, y, 54, 54);
        
        [btn setBackgroundImage:[UIImage imageNamed:photoArray[i]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:photoArray2[i]] forState:UIControlStateSelected];

        btn.tag=180+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainScrollView addSubview:btn];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(x-12, y+25, 80, 80)];
        label.font=[UIFont boldSystemFontOfSize:14];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=titleArray[i];
        label.tag=195+i;
        [self.mainScrollView addSubview:label];
        x+=80;
        
    }
    //调整切换按钮和地图位置
    self.mapButton.frame=CGRectMake(0, 250, 160, 30);
    self.listButton.frame=CGRectMake(160, 250, 160, 30);
    self.mapUIView.frame=CGRectMake(5, 285, 310, 465);
    self.listView.frame=CGRectMake(0, 285, 320, 465);
    self.mainScrollView.contentSize=CGSizeMake(0, self.view.bounds.size.height+140);
    

}
-(void)btnClick:(UIButton *)btn
{
    UILabel *la=(UILabel *)[self.mainScrollView viewWithTag:btn.tag+15];
    
    if (btn.selected) {
        btn.selected=NO;
        la.textColor=[UIColor blackColor];
        [_selectedArr removeObject:btn];
    }
    else{
        btn.selected=YES;
        la.textColor=[UIColor redColor];
        if (_selectedArr.count>0) {
            UIButton *bb=_selectedArr[0];
            bb.selected=NO;
            [_selectedArr removeObject:bb];
        }
        [_selectedArr addObject:btn];
    }
    NSLog(@"点击");

    if (_selectedArr.count==0) {
        //全部数据
        self.catId=0;
        [self.mapView removeAnnotations:_annoShowArr];
        [_annoShowArr removeAllObjects];
        [self.locationArray removeAllObjects];
        [self startDownloadData];
    }
    else{
        UIButton *btn=_selectedArr[0];
        int a=btn.tag-130;
        if (a==0)
            self.catId=5;
        else if (a==1)
            self.catId=2;
        else if (a==2)
            self.catId=3;
        else if (a==3)
            self.catId=4;
        
        [self.mapView removeAnnotations:_annoShowArr];
        [_annoShowArr removeAllObjects];
        [self.locationArray removeAllObjects];
        [self startDownloadData];
    }
    
}
#pragma mark - 创建大头针
-(void)createAnnotations
{
    if (_annoShowArr==nil) {
        _annoShowArr=[NSMutableArray array];
    }
    
    for (ShopModel *mm in self.locationArray) {
        WoAnnotation *anno=[[WoAnnotation alloc]init];
        CLLocationDegrees latitude = [mm.latitude floatValue];
        CLLocationDegrees longitude = [mm.longitude floatValue];
        anno.coordinate=CLLocationCoordinate2DMake(latitude, longitude);
        anno.title=mm.storename;
        anno.subtitle=mm.information;
        anno.logo=mm.logo;
        anno.pointerimg=mm.pointerimg;
        anno.model=mm;
        [_annoShowArr addObject:anno];
    }
    
    [self.mapView addAnnotations:_annoShowArr];
}


#pragma mark - 下载数据
-(void)startDownloadData
{
    BackSingle *sing=[BackSingle shareInstance];
    NSString * lan=sing.lan;
    NSString * lon=sing.lon;
    NSString * proId=sing.provId;
    NSString * cityId=sing.cityId;
    NSString * areaId=sing.areaId;
    
    NSMutableString *urlString=[NSMutableString stringWithFormat:TC_JiaJu_URL,self.big_catId,self.catId,lon,lan,proId,cityId,areaId,_page];
    
    NSLog(@"同城家具URL:%@",urlString);
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        for (NSDictionary *di in dict[@"store"]) {
            ShopModel *model=[[ShopModel alloc]init];
            [model setValuesForKeysWithDictionary:di];
            [self.locationArray addObject:model];
        }
        [self createAnnotations];
        
        [self.listView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",[error description]);
    }];
    
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
