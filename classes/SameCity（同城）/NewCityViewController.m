//
//  NewCityViewController.m
//  OuLianWang
//
//  Created by allenariel on 15/7/2.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "NewCityViewController.h"
#import "ProModel.h"
#import "CityModel.h"
#import "AreaModel.h"
#import "CLTreeViewNode.h"
#import "CityOneTableViewCell.h"
#import "CityTwoTableViewCell.h"
#import "CityThreeTableViewCell.h"
#import "UIView+LCView.h"
#import "SBJson.h"
#import "JuHeCityModel.h"

#define M_PI        3.14159265358979323846264338327950288   /* pi             */
#define M_PI_2      1.57079632679489661923132169163975144   /* pi/2           */
#define NearSelectCity @"NearSelectCity"

@interface NewCityViewController ()
{
    UIButton *_locationBtn;
}
@property(strong,nonatomic) NSMutableArray* dataArray; //保存全部数据的数组
@property(strong,nonatomic) NSMutableArray* newdataArray; //保存全部数据的数组
@property(strong,nonatomic) NSArray *displayArray;   //保存要显示在界面上的数
@property(nonatomic,strong)JuHeCityModel *currentCityModel;
@end

@implementation NewCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"城市选择";
    //创建tableView
    _myTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    _myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _myTableView.frame = self.view.bounds;
    _myTableView.backgroundColor=ZQColor(231, 233, 234);
//    _myTableView.userInteractionEnabled=NO;
    [self.view addSubview:_myTableView];
    
    //从本地获取数据
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dataPath=[NSHomeDirectory() stringByAppendingString:@"/Documents/newcity.txt"];
    if ([fileManager fileExistsAtPath:dataPath]) {
        NSLog(@"citylist存在");
        NSData *data = [[NSData alloc] initWithContentsOfFile:dataPath];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        //解档出数据模型Student
        //解码并解档出model
        NSArray *array = [unarchiver decodeObjectForKey:@"user"];
        
        //关闭解档
        [unarchiver finishDecoding];
        _dataArray=[NSMutableArray array];
        for (NSDictionary *dict in array) {
            ProModel *model=[[ProModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            //==
            CLTreeViewNode *node0=[[CLTreeViewNode alloc]init];
            node0.nodeLevel=0;
            node0.type=0;
            node0.isExpanded=FALSE;
            node0.nodeData=model;
            NSMutableArray *aa=[NSMutableArray array];//
            
            for (NSDictionary *dic in model.son) {
                CityModel *mod=[[CityModel alloc]init];
                [mod setValuesForKeysWithDictionary:dic];
                //==
                CLTreeViewNode *node1=[[CLTreeViewNode alloc]init];
                node1.nodeLevel=1;
                node1.type=1;
                node1.isExpanded=FALSE;
                node1.nodeData=mod;
                
                NSMutableArray *bb=[NSMutableArray array];
                for (NSDictionary *dd in mod.g_son) {
                    AreaModel *mm=[[AreaModel alloc]init];
                    [mm setValuesForKeysWithDictionary:dd];
                    //==
                    CLTreeViewNode *node2=[[CLTreeViewNode alloc]init];
                    node2.nodeLevel=2;
                    node2.type=2;
                    node2.isExpanded=FALSE;
                    node2.nodeData=mm;
                    
                    [bb addObject:node2];
                }
                node1.sonNodes=bb;
                [aa addObject:node1];
                
            }
            node0.sonNodes=aa;
            
            [_dataArray addObject:node0];
        }

        [self reloadDataForDisplayArray];
    }
    else{
        NSLog(@"citylist不存在");
        [self startDownloadData];

    }
    

    [self setExtraCellLineHidden:_myTableView];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]init];

    view.backgroundColor=[UIColor colorWithRed:231/255.0 green:233/255.0 blue:234/255.0 alpha:1];
    //定位
    UIView *locaView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
    [view addSubview:locaView];
    UILabel *la=[locaView addLabelWithFrame:CGRectMakeEx(10, 15, 100, 30) text:@"当前定位的城市"];
    la.font=[UIFont systemFontOfSize:14];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-115, 20, 16, 20)];
    imageView.image=[UIImage imageNamed:@"tongchengdingweitubiao.png"];
    [locaView addSubview:imageView];
    _locationBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _locationBtn.frame=CGRectMake(self.view.frame.size.width-90, 15, 80, 30);
    [_locationBtn addTarget:self action:@selector(locationClick:) forControlEvents:UIControlEventTouchUpInside];
    _locationBtn.layer.cornerRadius=7;
    _locationBtn.layer.borderWidth=0.3;
    _locationBtn.backgroundColor=[UIColor redColor];
    _locationBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    //text
    NSString *stringlo=[[NSUserDefaults standardUserDefaults]valueForKey:LocationCity];
    if (stringlo==nil) {
        stringlo=@"北京市";
    }
    [_locationBtn setTitle:stringlo forState:UIControlStateNormal];
    [locaView addSubview:_locationBtn];
    [locaView addImageViewWithFrame:CGRectMake(10, 55, 300, 2) image:@"line2line2.png"];
    
    //最近访问
    UIView *nearView=[[UIView alloc]initWithFrame:CGRectMake(0, 60, 320, 70)];
    [view addSubview:nearView];
    UILabel *titleLa=[nearView addLabelWithFrame:CGRectMakeEx(10, 0, 100, 30) text:nil];
    titleLa.font=[UIFont systemFontOfSize:14];
    titleLa.text=@"最近访问的城市";
    int xx=10,y=30;
    NSString *str=[[NSUserDefaults standardUserDefaults]valueForKey:NearSelectCity];
    BackSingle *single=[BackSingle shareInstance];
    if (str==nil) {
        [[NSUserDefaults standardUserDefaults]setObject:single.selectCity forKey:NearSelectCity];
    }
    NSString *s=[[NSUserDefaults standardUserDefaults]valueForKey:NearSelectCity];
    NSArray *nearArray=@[s];
    for (int i=0; i<nearArray.count; i++) {
        if (i%3==0&&i!=0) {
            xx=10;
            y+=40;
        }
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(xx, y, 80, 30);
        xx+=95;
        btn.titleLabel.font=[UIFont systemFontOfSize:16];
        [btn setTitle:nearArray[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(locationClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius=7;
        btn.layer.borderWidth=0.2;
        [nearView addSubview:btn];
    }
    [nearView addImageViewWithFrame:CGRectMake(10, 65, 300, 2) image:@"line2line2.png"];
    //热门
    UIView *hotView=[[UIView alloc]initWithFrame:CGRectMake(0, 130, 320, 130)];
    [view addSubview:hotView];
    UILabel *titleLa1=[hotView addLabelWithFrame:CGRectMake(10, 0, 100, 30) text:nil];
    titleLa1.font=[UIFont systemFontOfSize:14];
    titleLa1.text=@"热门城市";
    int xx1=10,y1=30;
    NSArray *hotArray=@[@"北京市",@"上海市",@"深圳市",@"长沙市",@"成都市",@"大连市"];
    for (int i=0; i<hotArray.count; i++) {
        if (i%3==0&&i!=0) {
            xx1=10;
            y1+=40;
        }
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(xx1, y1, 80, 30);
        xx1+=95;
        btn.titleLabel.font=[UIFont systemFontOfSize:16];
        [btn setTitle:hotArray[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(locationClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius=7;
        btn.layer.borderWidth=0.2;
        [hotView addSubview:btn];
    }
    [hotView addImageViewWithFrame:CGRectMake(10, 110, 300, 2) image:@"line2line2.png"];
    
    UILabel *allLab=[view addLabelWithFrame:CGRectMake(10, 245, 100, 30) text:@"全部城市"];
    allLab.font=[UIFont systemFontOfSize:14];
    
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 280;
}
-(void)createTitleView
{
    UIView *view=[[UIView alloc]init];
    _myTableView.tableHeaderView=view;
    
    view.backgroundColor=[UIColor colorWithRed:231/255.0 green:233/255.0 blue:234/255.0 alpha:1];
    //定位
    UIView *locaView=[[UIView alloc]initWithFrame:CGRectMakeEx(0, 0, 320, 60)];
    [view addSubview:locaView];
    UILabel *la=[locaView addLabelWithFrame:CGRectMakeEx(10, 15, 100, 30) text:@"当前定位的城市"];
    la.font=[UIFont systemFontOfSize:14];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-115, 20, 16, 20)];
    imageView.image=[UIImage imageNamed:@"tongchengdingweitubiao.png"];
    [locaView addSubview:imageView];
    
    _locationBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _locationBtn.frame=CGRectMake(self.view.frame.size.width-90, 15, 80, 30);
    _locationBtn.layer.cornerRadius=7;
    _locationBtn.layer.borderWidth=0.3;
    
    _locationBtn.backgroundColor=[UIColor redColor];
    [locaView addSubview:_locationBtn];
    
}


- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
#pragma mark - 下载数据
-(void)startDownloadData
{
    _dataArray=[NSMutableArray array];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [manager GET:ALLCITY_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSArray *array=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //------
        //写入本笃文件
        NSString *dataPath=[NSHomeDirectory() stringByAppendingString:@"/Documents/newcity.txt"];
        NSLog(@"dataPath=%@",dataPath);
        //
        NSMutableData *data = [[NSMutableData alloc] init];
        //创建归档辅助类
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        //编码
        [archiver encodeObject:array forKey:@"user"];
        //结束编码
        [archiver finishEncoding];
        //写入
        
        if([data writeToFile:dataPath atomically:YES])
            NSLog(@"citylist写入成功");
        else
            NSLog(@"citylist写入失败");
        //==============================
        for (NSDictionary *dict in array) {
            ProModel *model=[[ProModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            //==
            CLTreeViewNode *node0=[[CLTreeViewNode alloc]init];
            node0.nodeLevel=0;
            node0.type=0;
            node0.isExpanded=FALSE;
            node0.nodeData=model;
            NSMutableArray *aa=[NSMutableArray array];//
            
            for (NSDictionary *dic in model.son) {
                CityModel *mod=[[CityModel alloc]init];
                [mod setValuesForKeysWithDictionary:dic];
                //==
                CLTreeViewNode *node1=[[CLTreeViewNode alloc]init];
                node1.nodeLevel=1;
                node1.type=1;
                node1.isExpanded=FALSE;
                node1.nodeData=mod;
                
                NSMutableArray *bb=[NSMutableArray array];
                for (NSDictionary *dd in mod.g_son) {
                    AreaModel *mm=[[AreaModel alloc]init];
                    [mm setValuesForKeysWithDictionary:dd];
                    //==
                    CLTreeViewNode *node2=[[CLTreeViewNode alloc]init];
                    node2.nodeLevel=2;
                    node2.type=2;
                    node2.isExpanded=FALSE;
                    node2.nodeData=mm;
                    
                    [bb addObject:node2];
                }
                node1.sonNodes=bb;
                [aa addObject:node1];
                
            }
            node0.sonNodes=aa;
            
            [_dataArray addObject:node0];
        }

        //刷新
        [self reloadDataForDisplayArray];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",[error description]);
    }];
    
}
-(void)reloadDataForDisplayArray
{
    NSMutableArray *tmp = [[NSMutableArray alloc]init];
    for (CLTreeViewNode *node in _dataArray) {
        [tmp addObject:node];
        if(node.isExpanded){
            for(CLTreeViewNode *node2 in node.sonNodes){
                [tmp addObject:node2];
                if(node2.isExpanded){
                    for(CLTreeViewNode *node3 in node2.sonNodes){
                        [tmp addObject:node3];
                    }
                }
            }
        }
    }
    _displayArray = [NSArray arrayWithArray:tmp];
    [self.myTableView reloadData];
    
}



#pragma mark - 数据源方法
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    return _displayArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentifier = @"level0cell";
    static NSString *indentifier1 = @"level1cell";
    static NSString *indentifier2 = @"level2cell";
    CLTreeViewNode *node = [_displayArray objectAtIndex:indexPath.row];
    
    if(node.type == 0){//类型为0的cell
        
        CityOneTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:indentifier];
        
        if(cell == nil){
            cell = [[CityOneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        }
        cell.node = node;
        [self loadDataForTreeViewCell:cell with:node];//重新给cell装载数据
        
        [cell setNeedsDisplay]; //重新描绘cell
        [cell setSetCityBlock:^{
            ProModel *mm=node.nodeData;

            BOOL flag = [NSKeyedArchiver archiveRootObject:mm toFile:SelectCity_Path];
            if(!flag) {
                NSLog(@"归档失败！");
            }
            //写入backsingle
            [self createNewSingleWithModel:mm];
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
        return cell;
    }
    else if(node.type == 1){//类型为1的cell
        CityTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier1];
        if(cell == nil){
            cell = [[CityTwoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier1];
        }
        cell.node = node;
        [self loadDataForTreeViewCell:cell with:node];
        [cell setNeedsDisplay];
        [cell setSetCityBlock:^{
            CityModel *mm=node.nodeData;

            BOOL flag = [NSKeyedArchiver archiveRootObject:mm toFile:SelectCity_Path];
            if(!flag) {
                NSLog(@"归档失败！");
            }
            [self createNewSingleWithModel:mm];
            [[NSUserDefaults standardUserDefaults]setValue:mm.city forKey:NearSelectCity];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        return cell;
    }
    else{//类型为2的cell
        CityThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier2];
        if(cell == nil){
            cell = [[CityThreeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier2];
        }
        cell.node = node;
        [self loadDataForTreeViewCell:cell with:node];
        [cell setNeedsDisplay];
        [cell setSetCityBlock:^{
            
            AreaModel *mm=node.nodeData;
            BOOL flag = [NSKeyedArchiver archiveRootObject:mm toFile:SelectCity_Path];
            if(!flag) {
                NSLog(@"归档失败！");
            }
            [self createNewSingleWithModel:mm];
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
        return cell;
    }
}
//载入数据
-(void) loadDataForTreeViewCell:(UITableViewCell*)cell with:(CLTreeViewNode*)node{
    if(node.type == 0){
        ProModel *nodeData = node.nodeData;
        ((CityOneTableViewCell*)cell).nameLabel.text = nodeData.province;

    }
    
    else if(node.type == 1){
        CityModel *nodeData = node.nodeData;
        ((CityTwoTableViewCell*)cell).nameLabel.text = nodeData.city;

    }
    
    else{
        AreaModel *nodeData = node.nodeData;
        ((CityThreeTableViewCell*)cell).nameLabel.text = nodeData.area;

        
    }
}
#pragma mark - 返回高度
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 40;
}

#pragma mark - 点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CLTreeViewNode *node = [_displayArray objectAtIndex:indexPath.row];
    [self reloadDataForDisplayArrayChangeAt:indexPath.row];//修改cell的状态(关闭或打开)
    if(node.type == 2){
        //处理叶子节点选中，此处需要自定义
    }
    else{
        CityOneTableViewCell *cell = (CityOneTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        if(cell.node.isExpanded ){
            [self rotateArrow:cell with:M_PI];
        }
        else{
            [self rotateArrow:cell with:0];
        }
    }
}

#pragma mark - 修改cell的状态(关闭或打开)

-(void) reloadDataForDisplayArrayChangeAt:(NSInteger)row{
    NSMutableArray *tmp = [[NSMutableArray alloc]init];
    NSInteger cnt=0;
    for (CLTreeViewNode *node in _dataArray) {
        [tmp addObject:node];
        if(cnt == row){
            node.isExpanded = !node.isExpanded;
        }
        ++cnt;
        if(node.isExpanded){
            for(CLTreeViewNode *node2 in node.sonNodes){
                [tmp addObject:node2];
                if(cnt == row){
                    node2.isExpanded = !node2.isExpanded;
                }
                ++cnt;
                if(node2.isExpanded){
                    for(CLTreeViewNode *node3 in node2.sonNodes){
                        [tmp addObject:node3];
                        ++cnt;
                    }
                }
            }
        }
    }
    _displayArray = [NSArray arrayWithArray:tmp];
    [self.myTableView reloadData];
}

-(void) rotateArrow:(CityOneTableViewCell*) cell with:(double)degree{
    [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        cell.iconImageView.layer.transform = CATransform3DMakeRotation(degree, 0, 0, 1);
    } completion:NULL];
}

#pragma mark - 新添加Single的参数
-(void)createNewSingleWithModel:(id)model
{
    BackSingle *single=[BackSingle shareInstance];
    
    if ([model isKindOfClass:[ProModel class]]) {//省份
        ProModel *mm=model;
        single.selectCity=mm.province;
        single.provId=mm.provid;
        single.cityId=@"";
        single.areaId=@"";
    }
    else if ([model isKindOfClass:[CityModel class]]) {
        CityModel *mm=model;
        single.selectCity=mm.city;
        single.provId=mm.provid;
        single.cityId=mm.cityid;
        single.areaId=@"";
    }
    else if ([model isKindOfClass:[AreaModel class]]) {
        AreaModel *mm=model;
        single.selectCity=mm.area;
        single.areaId=mm.areaid;
        single.cityId=mm.cityid;
        single.provId=mm.provid;
    }
}

#pragma mark - 点击定位 最近 热门
-(void)locationClick:(UIButton *)btn
{
    NSString *urlString=[NSString stringWithFormat:LOCATION_URL,[btn.titleLabel.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"点击定位最近热门URL %@",urlString);
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        CityModel *model=[[CityModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        BOOL flag = [NSKeyedArchiver archiveRootObject:model toFile:SelectCity_Path];
        if(!flag) {
            NSLog(@"归档失败！");
        }
        [self createNewSingleWithModel:model];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",[error description]);
    }];
    
}


@end
