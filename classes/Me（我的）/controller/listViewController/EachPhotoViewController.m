//
//  EachPhotoViewController.m
//  OuLianWang
//
//  Created by allenariel on 15/7/23.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "EachPhotoViewController.h"
#import "EachPhotoModel.h"
#import "GEXCCollectionViewCell.h"
#import "CustomTabBar.h"

@interface EachPhotoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>
{
    BOOL _fullScreen;
    float currentScale;
    CGFloat rotationAngleInRadians;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)UIScrollView *scrollView;

@end

@implementation EachPhotoViewController

-(UIScrollView *)scrollView
{
    if (_scrollView==nil) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64)];
        
        for (int i=0;i<self.dataArray.count;i++) {
            UIView *view=[[UIView alloc]initWithFrame:CGRectMake(self.view.width*i, 0, self.view.width, self.view.height)];
            view.backgroundColor=[UIColor blackColor];
            EachPhotoModel *model=self.dataArray[i];
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
            [imageView setImageWithURL:[NSURL URLWithString:model.person_img] placeholderImage:DEFAULTIMG];
            [view addSubview:imageView];
            [_scrollView addSubview:view];
            imageView.userInteractionEnabled=YES;
            //点击
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
            [imageView addGestureRecognizer:tap];
            //放大
            UIPinchGestureRecognizer* pinch=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchClick:)];
            [imageView addGestureRecognizer:pinch];

            
        }
        _scrollView.hidden=NO;
        _scrollView.contentSize=CGSizeMake(self.view.width*self.dataArray.count, 0);
        _scrollView.pagingEnabled=YES;
        _scrollView.delegate=self;
        _scrollView.showsHorizontalScrollIndicator=NO;
        [self.view addSubview:_scrollView];
        
    }
    return _scrollView;
}
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
    // Do any additional setup after loading the view.
    currentScale=1.0f;
    self.title=@"商品详情图片";
    [self.collectionView reloadData];
    [self startDownLoad];
    _fullScreen=NO;
}
-(void)viewWillAppear:(BOOL)animated
{
    CustomTabBar *tabBar=(CustomTabBar*)self.navigationController.tabBarController;
    tabBar.zqTabBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    CustomTabBar *tabBar=(CustomTabBar*)self.navigationController.tabBarController;
    tabBar.zqTabBar.hidden=YES;
}
-(void)startDownLoad
{
    //hp://weixin.hsmja.com/wolian/personcenter.php?action=lookpcategory&pcid=1&key=147cbf4362fa62bafd101996e276b4b5
    
    NSString * key =[NewMD5 md5:[NSString stringWithFormat:@"%@%@",self.pcid,DefaultKey]] ;
    
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    // 获得参数
    NSDictionary * parames = @{@"action":@"lookpcategory",@"pcid":self.pcid,@"key":key};
    // 2.发送POST请求
    
    [mgr POST:PERSONCENTER_URL parameters:parames
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          
          NSString * code = [responseObj objectForKey:@"code"];
          if ([code isEqualToString:@"0"]) {
              NSDictionary * list = [responseObj objectForKey:@"list"];
              NSLog(@"查看相册返回信息：%@",list);

              for (NSDictionary *dict in list) {
                  
                    EachPhotoModel *model=[[EachPhotoModel alloc]init];
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
    
    EachPhotoModel *model=self.dataArray[indexPath.row];
    
    [cell.iconImageView setImageWithURL:[NSURL URLWithString:model.person_thumb] placeholderImage:DEFAULTIMG];
    cell.tubiao1.hidden=YES;
    cell.tubiao2.hidden=YES;

    return cell;
}

//定义每个UICollectionView 的大小
- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath
{
    
    return CGSizeMake(98,100);
}

//定义每个UICollectionView 的边距
-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section

{
    return UIEdgeInsetsMake (2, 1 , 1 , 2);
}
#pragma mark - 小图片点击
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.scrollView.hidden=NO;
    self.scrollView.contentOffset=CGPointMake(indexPath.row*self.view.width, 0);
    
}
#pragma mark - 大图片点击
-(void)tapClick:(UITapGestureRecognizer *)tap
{
    _scrollView.hidden=YES;
    
}
-(void)pinchClick:(UIPinchGestureRecognizer *)paramSender
{
    if (paramSender.state == UIGestureRecognizerStateEnded){
        currentScale = paramSender.scale;
    } else if (paramSender.state == UIGestureRecognizerStateBegan &&
               currentScale != 0.0f){
        paramSender.scale = currentScale;
    }
    
    paramSender.view.transform = CGAffineTransformMakeScale(paramSender.scale, paramSender.scale);

    paramSender.view.transform = CGAffineTransformMakeScale(paramSender.scale, paramSender.scale);
    
}





#pragma mark - scrollView 
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    currentScale=1.0f;
    rotationAngleInRadians=0.0f;
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
