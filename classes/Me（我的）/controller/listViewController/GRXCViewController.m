//
//  GRXCViewController.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/23.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "GRXCViewController.h"
#import "GEXCCollectionViewCell.h"
#import "PhotoModel.h"
#import "EachPhotoViewController.h"

@interface GRXCViewController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UICollectionView *collectionView;
@end

@implementation GRXCViewController

-(NSMutableArray *)dataArray
{
    if (_dataArray==nil) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}

-(UICollectionView *)collectionView
{
    if (_collectionView==nil) {
        
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 320, 618) collectionViewLayout:layout];
        _collectionView.backgroundColor=ZQColor(231, 233, 234);
        [_collectionView registerNib:[UINib nibWithNibName:@"GEXCCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:[GEXCCollectionViewCell myIdentify]];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"个人相册";
    
    [self.collectionView reloadData];
    [self startDownloadData];
}

#pragma mark --UICollectionViewDataSource


//定义展示的UICollectionViewCell的个数
-( NSInteger )collectionView:( UICollectionView *)collectionView numberOfItemsInSection:( NSInteger )section

{
    return self.dataArray.count;//假数据
}

//每个UICollectionView展示的内容
-( UICollectionViewCell *)collectionView:( UICollectionView *)collectionView cellForItemAtIndexPath:( NSIndexPath *)indexPath

{
    
    GEXCCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GEXCCollectionViewCell myIdentify] forIndexPath :indexPath];
    
    PhotoModel *model=self.dataArray[indexPath.row];
    [cell.iconImageView setImageWithURL:[NSURL URLWithString:model.person_thumb] placeholderImage:DEFAULTIMG];
    
    cell.xiangNumber.text=model.pnums;
    cell.lookNumber.text=model.pclicks;
    return cell;
}

//定义每个UICollectionView 的大小
- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath
{
    
    return CGSizeMake(98,115);
}

//定义每个UICollectionView 的边距
-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section

{
    return UIEdgeInsetsMake (2, 1 , 1 , 2);
}

-(void)startDownloadData
{
    MyAccount *account=[MyAccountTool account];
    NSString * key =[NewMD5 md5:[NSString stringWithFormat:@"%@%@",account.userid,DefaultKey]] ;
    NSLog(@"%@  %@",account.userid,key);
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 获得参数
    NSDictionary * parames = @{@"action":@"personphoto",@"userid":account.userid,@"key":key};
    // 2.发送POST请求

    [mgr POST:PhotoAlbum_URL parameters:parames
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          
          NSString * code = [responseObj objectForKey:@"code"];
          if ([code isEqualToString:@"0"]) {
              NSDictionary * list = [responseObj objectForKey:@"list"];
              NSLog(@"登陆返回信息：%@",list);
              //缓存起来
              //[[NSUserDefaults standardUserDefaults]setValue:list forKey:Wode_Data];
              for (NSDictionary *dict in list) {
                  PhotoModel *model=[[PhotoModel alloc]init];
                  [model setValuesForKeysWithDictionary:dict];
                  [self.dataArray addObject:model];
              }
              [self.collectionView reloadData];
   
          }
          else{
              
          }
          
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"%@",error);
      }];
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PhotoModel *model=self.dataArray[indexPath.row];
    EachPhotoViewController *evc=[[EachPhotoViewController alloc]init];
    evc.pcid=model.pcid;
    [self.navigationController pushViewController:evc animated:YES];
    
    
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
