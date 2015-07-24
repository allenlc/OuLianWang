//
//  ShopDetailController.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/27.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "ShopDetailController.h"
#import "ShopDetailCell.h"
#import "OLWTabBarController.h"
#import "HZPhotoBrowser.h"
#import "UIButton+WebCache.h"
#import "ShopDetailModel.h"
#import "EstimateModel.h"
#import "DPErWeiMaController.h"


@interface ShopDetailController ()<UITableViewDataSource,UITableViewDelegate,HZPhotoBrowserDelegate>
{
    NSArray * titleArr;
    UIScrollView * scrollView;
    NSMutableArray * browserImgs;
    NSArray *imgArr ;
    UITableView  *tableView;
    
}
@property(nonatomic,strong)NSArray *srcStringArray;
@property(nonatomic,strong)ShopDetailModel *shopDetailModel;
@property(nonatomic,strong)EstimateModel *estimateModel;
@property(nonatomic,strong)NSMutableArray *estimateModels;
@end

@implementation ShopDetailController
-(void)viewWillAppear:(BOOL)animated
{
    ( (OLWTabBarController *)self.tabBarController).zqTabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //  在首页点击进入我的店铺的时候是不需要“修改”这个按钮的，就不调用创建方法，其他的界面进入需要的就能进行创建
    if ([_XiuGaiString  isEqualToString:@"xiugai"])
    {
        
    }
    else
        [self setNavigationTitle];

    
    
       [self requestData];
    
   
    
    
    browserImgs = [NSMutableArray array];
    _srcStringArray = @[
                        @"http://ww2.sinaimg.cn/thumbnail/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",
                        @"http://ww2.sinaimg.cn/thumbnail/67307b53jw1epqq3bmwr6j20c80axmy5.jpg",
                        @"http://ww2.sinaimg.cn/thumbnail/9ecab84ejw1emgd5nd6eaj20c80c8q4a.jpg",
                        @"http://ww2.sinaimg.cn/thumbnail/642beb18gw1ep3629gfm0g206o050b2a.gif",
                        @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr0nly5j20pf0gygo6.jpg",
                        @"http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr1d0vyj20pf0gytcj.jpg",
                        @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr1xydcj20gy0o9q6s.jpg",
                        @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg",
                        @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr39ht9j20gy0o6q74.jpg",
                        @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr3xvtlj20gy0obadv.jpg",
                        @"http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg",
                        @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg",
                        @"http://ww2.sinaimg.cn/thumbnail/677febf5gw1erma104rhyj20k03dz16y.jpg",
                        @"http://ww4.sinaimg.cn/thumbnail/677febf5gw1erma1g5xd0j20k0esa7wj.jpg",
                        ];

    self.navigationItem.title = @"店铺详情";
    titleArr = @[@"店铺简介",@"详细地址",@"店铺相册",@"店铺客服"];
    imgArr = @[@"xiangqingxiangce01",@"xiangqingxiangce02",@"xiangqingxiangce03",@"xiangqingxiangce04",@"cp2"];

    
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.height+50) style:UITableViewStylePlain];
//    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;

    [self.view addSubview:tableView];
    
}
#pragma mark -懒加载
-(NSMutableArray *)estimateModels
{
    if (_estimateModels == nil) {
        _estimateModels = [NSMutableArray array];
        
    }
    return _estimateModels;
}
#pragma -mark 请求网络数据
-(void)requestData
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //    获得参数
    NSString * storeid  =@"1";
    NSString * pageSize  = @"1";
    NSString * page  =@"1";
    
    NSString * key =[NewMD5 md5:[NSString stringWithFormat:@"%@%@%@%@",storeid,pageSize,page,@"esaafafasfafafsaff"]] ;
    NSDictionary * parames = @{@"action":@"personshopdetailshow",@"storeid":storeid,@"pageSize":pageSize,@"page":page,@"key":key};
//    NSLog(@"key ==%@ ",key);
//    NSLog(@"parames =%@ ",parames);
    // 2.发送POST请求
    [mgr POST:PERSONCENTER_URL parameters:parames
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          NSString * code = [responseObj objectForKey:@"code"];
          NSLog(@"respone  = %@",responseObj);
          if ([code isEqualToString:@"0"]) {
              NSDictionary * list = [responseObj objectForKey:@"list"];
             
              self.shopDetailModel = [ShopDetailModel objectWithKeyValues:list];
              
              for (int i = 0; i<self.shopDetailModel.review_list.count; i++) {
                  self.estimateModel = [EstimateModel objectWithKeyValues:self.shopDetailModel.review_list[i]];
                  [self.estimateModels addObject:self.estimateModel];
//                   NSLog(@"self.estimateModels == %@",self.estimateModel.us);
              }
              
            [tableView reloadData];
          }
          
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"fail");
      }];

}
#pragma 设置导航栏
-(void)setNavigationTitle
{
    
    UIButton *fabubutton1=[UIButton buttonWithType:UIButtonTypeCustom];
    [fabubutton1  setTitle:@"修改" forState:0];
    [fabubutton1 setTitleColor:[UIColor whiteColor] forState:0];
    [fabubutton1 addTarget:self action:@selector(getMessage) forControlEvents:UIControlEventTouchUpInside];
    fabubutton1.frame=CGRectMake(0, 0, 40, 30);
    fabubutton1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc]initWithCustomView:fabubutton1];
    self.navigationItem.rightBarButtonItem=rightBtn;
    
}

-(void)getMessage
{


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return  2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 5;
    }
    else{
        return self.estimateModels.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
       
        if (indexPath.row==0) {
             UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            [self creatFirstCellWithCell:cell];
            return cell;
        
        }
        else
        {
            UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
          cell.selectionStyle = UITableViewCellSelectionStyleNone;
          UIView * View =  [self creatMidCellWithCell:cell andTitle:titleArr[indexPath.row-1]];
            if (indexPath.row == 1) {
                UITextView * label = [[UITextView alloc]initWithFrame:CGRectMake(10, 30, cell.width-20, 80)];
//                label.numberOfLines = 0;
                label.text = @"我店产品全部来自正规的渠道，以最直接有效的方式送达最终端消费者手里，避免了中间过多的流通环节。并且本店一直是以薄利多销为原则";
                if (![self.shopDetailModel.information isKindOfClass:[NSNull class]]) {
                    label.text = self.shopDetailModel.information;
                }
                label.font = [UIFont systemFontOfSize:14];
                [View addSubview:label];
                
                
            }
            else if (indexPath.row ==2)
            {
                UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, cell.width-120, 80)];
                label.numberOfLines = 0;
                label.text = self.shopDetailModel.address;
                label.font = [UIFont systemFontOfSize:14];
                [View addSubview:label];
                
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(cell.width-70, 50, 20, 25)];
                imgView.image = [UIImage imageNamed:@"dianpuditutubiao"];
                [View addSubview:imgView];
                
                UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(cell.width-75, 75, 30, 20)];
                label1.text = @"地图";
                label1.textAlignment = 1;
                label1.font = [UIFont systemFontOfSize:13];
                label1.textColor = [UIColor grayColor];
                [View addSubview:label1];
            }
            else if (indexPath.row ==3)
            {
                
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 30, cell.width, 80)];
                imgView.image = [UIImage imageNamed:@"dianpuxiangqingxiangcelun"];
                imgView.userInteractionEnabled = YES;
                [View addSubview:imgView];
                
                scrollView  = [[UIScrollView alloc]initWithFrame:imgView.bounds];
                scrollView.showsHorizontalScrollIndicator = NO;
                [imgView addSubview:scrollView];
                scrollView.contentSize = CGSizeMake(cell.width/4*imgArr.count, 80);
                [imgView addSubview:scrollView];
                for (int i = 0; i<imgArr.count; i++) {
                    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20+(cell.width-20)/4*i , 10, (cell.width-100)/4, 60)];
                    UIImage *img =[UIImage imageNamed:imgArr[i]];
                    [browserImgs addObject:img];

                    imgView.image = img;
                
                    imgView.tag = i;
                    imgView.userInteractionEnabled = YES;
                    UITapGestureRecognizer * tapImg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImg:)];
                    [imgView addGestureRecognizer:tapImg];
                    [scrollView addSubview:imgView];
                    
                }
                
             }
            else
            {
                NSDictionary * dic = [self.shopDetailModel.custom_list objectAtIndex:0];//获得字典
                
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 40, 60, 60)];//客服头像
                
                NSString * icon = [dic objectForKey:@"photo"];
                [imgView setImageWithURL:[NSURL URLWithString:@"http://192.168.1.147/myweb/images/apple.png"] placeholderImage:[UIImage imageNamed:@"haoyoutouxiang"]];
                imgView.layer.cornerRadius = imgView.width/2;
                imgView.userInteractionEnabled = YES;
                [View addSubview:imgView];
                
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(80, 60, 100, 20)];
                
                NSString * custom = [dic objectForKey:@"username"];
                label.text =custom;
                [View addSubview:label];
                label.font = [UIFont systemFontOfSize:14];
                
                UIButton * messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                messageBtn.frame = CGRectMake(self.view.width-115, 60-2.5, 30,30);
                [messageBtn setImage:[UIImage  imageNamed:@"dianpuxiangqingxiaoxi"] forState:0];
                [View addSubview:messageBtn];
                
                UIButton * phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                phoneBtn.frame = CGRectMake(self.view.width-50, 60-2.5, 30, 30);
                [phoneBtn setImage:[UIImage  imageNamed:@"dianpuxiangqingdianhua"] forState:0];
                [phoneBtn  addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
                [View addSubview:phoneBtn];

            }

            return cell;
        }
        
    }
    else{
    ShopDetailCell * cell = [ShopDetailCell cellWithTableViewCell:tableView];
        cell.estimateModel = self.estimateModels[indexPath.row];
    return cell;
    }
}

-(void)buttonClick
{
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://13535471825"]];

}
#pragma mark -浏览店铺相册
-(void)tapImg:(UITapGestureRecognizer *)tapGestureRecognizer
{
    HZPhotoBrowser * photoBrowser = [[HZPhotoBrowser alloc]init];
    photoBrowser.sourceImagesContainerView =scrollView;
    photoBrowser.imageCount = imgArr.count;
    photoBrowser.currentImageIndex = tapGestureRecognizer.view.tag;
    photoBrowser.delegate = self;
    [self.navigationController pushViewController:photoBrowser animated:NO];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return nil;
        }
    else{
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, self.view.width-30, 29)];
        label1.text =@"店铺评价";
        label1.textColor = [UIColor orangeColor];
        [view addSubview:label1];
        
        UIImageView * leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 8, 18)];
        leftImg.backgroundColor = [UIColor orangeColor];
        [view addSubview:leftImg];
        
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 29, self.view.width, 1)];
        imgView.backgroundColor = ZQColor(232, 232, 232);
        [view addSubview:imgView];
        return view;

    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height ;
    if (section == 0) {
        height = 0;
    }
    else if(section == 1){
        height =30;
    }
    return height;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    if (indexPath.section ==0) {
        if (indexPath.row==0) {
            height = 160;
        }
        else{
        height = 120;
        }
    }
    else{
        height = 70;
    }
    return height;
}
-(void)creatFirstCellWithCell:(UITableViewCell *)senderCell
{
    //清除cell的颜色
    senderCell.backgroundColor = [UIColor clearColor];
    senderCell.backgroundView = [[UIImageView alloc]init];
    senderCell.selectedBackgroundView = [[UIImageView alloc]init];
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
    view.backgroundColor = [UIColor whiteColor];
    [senderCell.contentView  addSubview:view];
    
    UIImageView *iconImageview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 70, 70)];
    [iconImageview setImageWithURL:[NSURL URLWithString:self.shopDetailModel.logo] placeholderImage:[UIImage imageNamed:@"dianpu"]];
    [view  addSubview:iconImageview];
    
    UILabel *olabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 5, 120, 20)];
    olabel.text=self.shopDetailModel.storename;
    olabel.font=[UIFont systemFontOfSize:14];
    [view  addSubview:olabel];
    
    UILabel *tlabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 25, 90, 20)];
    tlabel.text=@"营业执照已认证";
    tlabel.textColor=[UIColor grayColor];
    tlabel.font=[UIFont systemFontOfSize:12];
    [view  addSubview:tlabel];
    
    UILabel *thlabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 45, 90, 10)];
    thlabel.text=self.shopDetailModel.operatime;
    thlabel.textAlignment=1;
    thlabel.textColor=[UIColor grayColor];
    thlabel.font=[UIFont systemFontOfSize:10];
    [view  addSubview:thlabel];
    
    UIImageView *dianhuaimageview=[[UIImageView alloc]initWithFrame:CGRectMake(180, 32.5, 30, 20)];
    dianhuaimageview.image=[UIImage  imageNamed:@"rz.png"];
    [view  addSubview:dianhuaimageview];
    
    UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(90, 55, self.view.width-100, 20) ];
    lab2.text = [NSString stringWithFormat:@"电话:%@",self.shopDetailModel.telephone];
    lab2.textColor = [UIColor grayColor];
    lab2.font=[UIFont systemFontOfSize:12];
    [view addSubview:lab2];
    
    UIButton * messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    messageBtn.frame = CGRectMake(self.view.width-90, 30, 25, 25);
    [messageBtn setImage:[UIImage  imageNamed:@"dianpuxiangqingxiaoxi"] forState:0];
    [view addSubview:messageBtn];
    
    UIButton * phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneBtn.frame = CGRectMake(self.view.width-45, 30, 25, 25);
    [phoneBtn setImage:[UIImage  imageNamed:@"dianpuxiangqingdianhua"] forState:0];
    [view addSubview:phoneBtn];
    
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame), self.view.width, 80)];
    [senderCell.contentView addSubview:view1];
    
    UIImageView * bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, view1.width, view1.height)];
    bgImgView.image = [UIImage imageNamed:@"dianpuxiangqingxiaobeijing"];
    [view1 addSubview:bgImgView];
    
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, senderCell.width, 5)];
    imgView.backgroundColor = ZQColor(232, 232, 232);
    [view1 addSubview:imgView];
    
    NSArray * arr = @[@"dianpumenmian1",@"dianpuzhixing1",@"dianpurenzheng1",@"erweima1"];
    for (int i = 0; i<4; i++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake((self.view.width/4-60)/2+(senderCell.width/4)*i, 10, 60, 60);
        btn.tag=200+i;
        [btn  addTarget:self action:@selector(buttonclicl:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:[UIImage imageNamed:arr[i]] forState:0];
        [view1 addSubview:btn];
    }
    
    UIImageView * imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 75, senderCell.width, 5)];
    imgView1.backgroundColor = ZQColor(232, 232, 232);
    [view1 addSubview:imgView1];
}

#pragma mark-----店铺详情的最上面的四个点击事件
-(void)buttonclicl:(UIButton *)button
{
    if (button.tag==203)
    {
        
        DPErWeiMaController *controller=[[DPErWeiMaController  alloc]init];
        //  传二维码生成的数据
        //controller.userID=_EWMString;
        [self.navigationController  pushViewController:controller animated:YES];
        
        
    }
    
}

-(UIView *)creatMidCellWithCell:(UITableViewCell *)senderCell andTitle:(NSString *)title
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, senderCell.width, 120)];
    [senderCell.contentView addSubview:view];
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, senderCell.width-30, 29)];
    label1.text =title;
    label1.textColor = [UIColor orangeColor];
    [view addSubview:label1];
    
    UIImageView * leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 8, 18)];
    leftImg.backgroundColor = [UIColor orangeColor];
    [view addSubview:leftImg];
    
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 29, senderCell.width, 1)];
    imgView.backgroundColor = ZQColor(232, 232, 232);
    [view addSubview:imgView];
    
    UIImageView * imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 110, senderCell.width, 10)];
    imgView1.backgroundColor = ZQColor(232, 232, 232);
    [view addSubview:imgView1];
    return view;
    
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
@end
