//
//  CityListController.m
//  CityListDemo
//
//  Created by 夏威夷man on 15-5-9.
//  Copyright (c) 2015年 夏威夷man. All rights reserved.
//

#define CELL @"cell"
#import "CityListController.h"
#import "JuHeCityModel.h"
#import "LocationManager.h"
#import "NearTableViewCell.h"
#import "SingleNearCity.h"
#import "FirstTableViewCellTop.h"
#import "ChineseString.h"

@interface CityListController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) UITableView *cityTable;
@property (strong,nonatomic) NSMutableDictionary *cityList;
@property (strong,nonatomic) NSArray *cityKey;
@property (strong,nonatomic) NSMutableArray *modelArr;
@property (strong,nonatomic) JuHeCityModel *currentCity;
@property (strong,nonatomic) JuHeCityModel *positionCity;
@property (assign,nonatomic) BOOL selectedEnable;
@property(nonatomic,strong)UIButton *locationBtn;
@end

@implementation CityListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"城市列表";
    _selectedEnable = NO;
    [self configureTableView];

    [self configureLoaction1];
    [self configureData];
}

#pragma mark - location
- (void)configureLoaction1{
    __weak typeof(self) weakSelf = self;

    LocationManager *manager = [LocationManager shareLocationManager];
    [manager updatingLoaction];
    [manager setActionBlock:^(JuHeCityModel *city) {
        weakSelf.locationName = city.city_name;
        weakSelf.selectedEnable = YES;
        //定位刷新表格
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        [self.cityTable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    }];

}

#pragma mark - configgure Table
- (void)configureTableView{

    CGRect rect = self.view.bounds;
    _cityTable = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _cityTable.backgroundColor=[UIColor colorWithRed:231 green:233 blue:234 alpha:1];
    _cityTable.delegate = self;
    _cityTable.dataSource = self;
    _cityTable.sectionIndexBackgroundColor=[UIColor clearColor];
    _cityTable.sectionIndexColor = [UIColor darkGrayColor];
    _currentCity = [JuHeCityModel currentCity];
    _positionCity = [JuHeCityModel positionCity];

    [self.view addSubview:_cityTable];
}


- (void)configureData{
    _modelArr = [[NSMutableArray alloc] init];
    _cityList = [[NSMutableDictionary alloc] init];
    //载入地址数据
    //===========
    NSString *urlString=[NSString stringWithFormat:ALLCITY_URL];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"array=%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",[error description]);
    }];
//===============
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CityList" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSArray *arr = dict[@"list"];
    for (NSDictionary *dict in arr) {
        JuHeCityModel *model = [[JuHeCityModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [_modelArr addObject:model];
    }
    for (JuHeCityModel *model in _modelArr) {
        NSString *key = model.city_pre;
        NSMutableArray *muArr = _cityList[key];
        if (muArr == nil) {
            muArr = [[NSMutableArray alloc] init];
            [_cityList setObject:muArr forKey:key];
        }
        [muArr addObject:model];
    }
    _cityKey = [_cityList.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString * obj1, NSString *obj2) {
        return [obj1 compare:obj2];
    }];
    
    [_cityTable reloadData];
}

#pragma mark - tableDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _cityKey.count + 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 1 ||section==2) {
        return 1;
    }
    else{
        NSString *key = _cityKey[section - 3];
        NSArray *arr = _cityList[key];
        return arr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    switch (indexPath.section) {
        case 0:{
            FirstTableViewCellTop *firCell=[[FirstTableViewCellTop alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            [firCell.locationBtn setTitle:self.locationName forState:UIControlStateNormal];
            [firCell setLocationBlock:^{
//                if (_selectedEnable) {
                    [_positionCity setCurrentCity];
                    [self.navigationController popViewControllerAnimated:YES];
//                }
            }];
            return firCell;
        }
            break;
        case 1:{
            NearTableViewCell *nearCell=[[NearTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            [nearCell createUIWith:[SingleNearCity shareInstance].nearArray];
            nearCell.titleLabel.text=@"最近被访问的城市";
            return nearCell;
            
        }
            break;
        case 2:{
            NearTableViewCell *nearCell=[[NearTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            NSArray *arr=@[@"北京",@"上海",@"深圳",@"长沙",@"成都",@"大连"];
            NSMutableArray *aa=[NSMutableArray arrayWithArray:arr];
            [nearCell createUIWith:aa];
            nearCell.titleLabel.text=@"热门城市";
            return nearCell;
        }
            break;
        default:{
            
            JuHeCityModel *model = [self findCityModelWithIndexPath:indexPath];
            cell.textLabel.text = model.city_name;
            cell.backgroundColor=[UIColor colorWithRed:231/255.0 green:233/255.0 blue:234/255.0 alpha:1];
            if (model.id.integerValue == _currentCity.id.integerValue) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
             return cell;
        }
    }
   
}
#pragma mark tableView Delegate

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    view.backgroundColor=[UIColor colorWithRed:231/255.0 green:233/255.0 blue:234/255.0 alpha:1];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 200, 30)];
    label.font=[UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    if (section==0) {

    }
    else if (section==1) {

    }
    else if (section==2) {

    }
    else if (section==3){
        label.text= @"全部城市";
        UIButton *tn=[UIButton buttonWithType:UIButtonTypeCustom];
        tn.frame=CGRectMake(15, 40, 30, 30);
        [tn setBackgroundImage:[UIImage imageNamed:@"chengshizimubeijing.png"] forState:UIControlStateNormal];
        [tn setTitle:@"A" forState:UIControlStateNormal];
        [view addSubview:tn];
    }
    else{
        UIButton *tn=[UIButton buttonWithType:UIButtonTypeCustom];
        tn.frame=CGRectMake(15, 5, 30, 30);
        [tn setBackgroundImage:[UIImage imageNamed:@"chengshizimubeijing.png"] forState:UIControlStateNormal];
        
        [tn setTitle:[NSString stringWithFormat:@"%@",_cityKey[section - 3]] forState:UIControlStateNormal];
        [view addSubview:tn];
    }
   
    return view;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:@"定位",@"最近",@"热门",nil];
    [arr addObjectsFromArray:_cityKey];
    return arr;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return;
    }else if (indexPath.section == 1)
    {
        if (_selectedEnable) {
            [_positionCity setCurrentCity];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if (indexPath.section == 2)
    {
        if (_selectedEnable) {
            [_positionCity setCurrentCity];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else{
        JuHeCityModel *city = [self findCityModelWithIndexPath:indexPath];
        city.latitude = @-1;
        city.longtitude = @-1;
        [city setCurrentCity];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (JuHeCityModel *)findCityModelWithIndexPath:(NSIndexPath *)indexPath
{
    return [_cityList[_cityKey[indexPath.section-3]] objectAtIndex:indexPath.row];
}
#pragma mark - tableView头部底部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0||section==1||section==2) {
        return 1;
    }
    else if (section==3)
        return 80;
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 60;
    }
    else if (indexPath.section==1)
    {
        SingleNearCity *sin=[SingleNearCity shareInstance];
        int a=(int)sin.nearArray.count;
        return (a/3+1)*35+30;
    }
    else if (indexPath.section==2)
    {
        int a=6;
        return (a/3+1)*30+20;
    }
    return 50;
}


@end
