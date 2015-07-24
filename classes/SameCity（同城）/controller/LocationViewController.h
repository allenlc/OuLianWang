//
//  LocationViewController.h
//  OuLianWang
//
//  Created by allenariel on 15/6/22.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "ListViewController.h"
#import "WoAnnotation.h"
#import "WoAnnotationView.h"

@interface LocationViewController : ListViewController
@property(nonatomic,strong)UIScrollView *mainScrollView;
@property(nonatomic,strong)MAMapView *mapView;//定义地图视图
@property(nonatomic,strong)UISearchBar *searchBar;//搜索栏
@property(nonatomic,strong)UIButton *mapButton;
@property(nonatomic,strong)UIButton *listButton;
@property(nonatomic,strong)UITableView *listView;
@property(nonatomic,strong)UIView *mapUIView;
//URL中使用的参数
@property(nonatomic,assign)int provinceId;
@property(nonatomic,assign)int cityId;
@property(nonatomic,assign)int areaId;
@property(nonatomic,assign)int catId;
@property(nonatomic,assign)int big_catId;

//装在地图商家数据
@property(nonatomic,strong)NSMutableArray *locationArray;

-(void)locationChangeToIdWithProvince:(NSString *)pro andCity:(NSString *)city andArae:(NSString *)area;

@end
