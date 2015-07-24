//
//  CZhiViewController.m
//  OuLianWang
//
//  Created by hsmj on 15/6/16.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "CZhiViewController.h"
#import "CzCGViewController.h"
#import "HYCZViewController.h"
#import "OLWTabBarController.h"

@interface CZhiViewController ()
{
    UIView *view;
    UITextField *_noetextFile;
    UITextField *_twotextFile;
    UIButton * selectBtn;
    NSString *_CZDianHuaString;
    NSString *_CZJineString;
    UILabel * label1;
    UILabel * label2;
    
    
    //  充值需要的两个数据
    NSString *tradeno;
    NSString *randkey2;
    
    //  充值后返回的结果
    NSString *messagestring;
    
}
@end

@implementation CZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=ZQColor(232, 233, 232);
    
    
    [self  downloaddata];
    
    [self creatTopView];
    [self  creatChongzhiView];
    [self  deplyNavigationController1];
    
}
#pragma mark －－－－－配置导航栏

-(void)deplyNavigationController1
{
    self.navigationItem.title=@"充值中心";

    UIButton *fabubutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [fabubutton setImage:[UIImage imageNamed:@"xinxi_"] forState:0];
    fabubutton.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    fabubutton.frame=CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *rightbutton=[[UIBarButtonItem alloc]initWithCustomView:fabubutton];
    self.navigationItem.rightBarButtonItem=rightbutton;
    

    // 调整 leftBarButtonItem 在 iOS7 下面的位置
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0))
    {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                       target:nil action:nil];
        negativeSpacer.width = -10;//这个数值可以根据情况自由变化
        self.navigationItem.rightBarButtonItems = @[negativeSpacer, rightbutton];
    }
    else
        self.navigationItem.rightBarButtonItem = rightbutton;
    
}

-(void)diquButtonClick
{
    [self.navigationController  popViewControllerAnimated:YES];
    
}

#pragma mark-----下载数据
-(void)downloaddata
{
    
    NSString *str=@"http://weixin.hsmja.com/wolian/personcenter.php?action=showprecharge";
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer  serializer];
    [manager  GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic=[NSJSONSerialization   JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        tradeno=dic[@"tradeno"];
        randkey2=dic[@"randkey2"];
        
        NSLog(@"%@   %@",tradeno,randkey2);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
}



-(void)creatTopView
{
    view=[[UIView  alloc]init];
    //    view.backgroundColor=ZQColor(220, 220, 220);
    view.alpha=0.9;
    view.frame=CGRectMake(0, 0, 320, 568);
    [self.view  addSubview:view];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Viewclick:)];
    [view  addGestureRecognizer:tap];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, 180-64)];
    imgView.image = [UIImage imageNamed:@"congzhizhongxin_bd"];
    imgView.backgroundColor = [UIColor cyanColor];
    [view addSubview:imgView];
}
-(void)creatChongzhiView
{
    
    _noetextFile=[[UITextField alloc]initWithFrame:CGRectMake(10, 190, 300, 30)];
    _noetextFile.backgroundColor=[UIColor  whiteColor];
    _noetextFile.layer.borderColor = ZQColor(208, 203, 208).CGColor;
    _noetextFile.layer.borderWidth = 1;
    _noetextFile.layer.cornerRadius=5;
    _noetextFile.placeholder=@"请输入要充值的手机号码";
    _noetextFile.keyboardType=UIKeyboardTypeNumberPad;
    
    
    [view addSubview: _noetextFile];
    
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(_noetextFile.width-40, 5, 30, 20)];
    imgView.image = [UIImage imageNamed:@"chongzhizhognxin_sf"];
    [_noetextFile addSubview:imgView];
    
    NSArray * arr = @[@"10元",@"20元",@"30元",@"50元",@"100元",@"200元",@"300元",@"400元",@"其它金额"];
    int x = 0;
    for (int i = 0; i<3; i++) {
        for (int j = 0 ; j<3; j++) {
            
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(10+((self.view.width-10*6)/3+2*10)*i, 230+(10+30)*j, (self.view.width-10*6)/3, 30);
            btn.tag = x+100;
            [btn setTitleColor:[UIColor blackColor] forState:0];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            btn.layer.cornerRadius = 5;
            btn.layer.borderColor = ZQColor(208, 203, 208).CGColor;
            btn.layer.borderWidth = 1;
            [btn setTitle:arr[x] forState:0];
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn addTarget:self action:@selector(selectDenomination:) forControlEvents:UIControlEventTouchUpInside];
            btn.selected = NO;
            x++;
            [view addSubview:btn];
        }
    }
    
    selectBtn = (UIButton *)[view viewWithTag:100];
    
    UIImageView * imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 375, 20, 20)];
    imgView2.image = [UIImage imageNamed:@"czhi_yidong"];
    [view addSubview:imgView2];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(50, 370, 100, 30 )];
    label.text = @"中国移动";
    label.textColor = [UIColor grayColor];
    [view addSubview:label];
    
    label1 = [[UILabel alloc]initWithFrame:CGRectMake(200, 370, 100, 30)];
    label1.text = @"售价:         元";
    label1.textAlignment = 2;
    label1.textColor = [UIColor redColor];
    
    label2 = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 40,30)];
    label2.text = @"100";
    label2.textAlignment =0;
    label2.textColor = [UIColor redColor];
    [label1  addSubview:label2];
    
    
    [view addSubview:label1];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
    [button  setTitle:@"立即充值" forState:UIControlStateNormal];
    button.frame=CGRectMake(10, 420, 300, 30);
    button.layer.cornerRadius=10;
    button.backgroundColor=[UIColor redColor];
    [button  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont  boldSystemFontOfSize:20];
    [button  addTarget:self action:@selector(buttonclick) forControlEvents:UIControlEventTouchUpInside];
    [view  addSubview:button];
    
    
}
-(void)selectDenomination:(UIButton *)sender
{
    selectBtn.selected = NO;
    selectBtn.backgroundColor = [UIColor whiteColor];
    selectBtn = sender;
    selectBtn.selected = YES;
    selectBtn.backgroundColor = [UIColor redColor];
    
    if (sender.tag==100)
    {
        label2.text=@"10";
    }
    if (sender.tag==101)
    {
        label2.text=@"20";
    }
    if (sender.tag==102)
    {
        label2.text=@"30";
    }
    if (sender.tag==103)
    {
        label2.text=@"50";
    }
    if (sender.tag==104)
    {
        label2.text=@"100";
    }
    if (sender.tag==105)
    {
        label2.text=@"200";
    }
    if (sender.tag==106)
    {
        label2.text=@"300";
    }
    if (sender.tag==107)
    {
        label2.text=@"400";
    }
    if (sender.tag==108)
    {
        
    }
    
    
    
}
-(void)Viewclick:(UITapGestureRecognizer *)tap
{
    [_noetextFile  resignFirstResponder];
    
    [_twotextFile  resignFirstResponder];
    
}

//   立即充值按钮
-(void)buttonclick
{
    
    //  ==============充值的电话信息
    _CZDianHuaString=_noetextFile.text;
    //  正则表达判断是不是电话号码
    BOOL A= [self  checkTel:_CZDianHuaString];
    if (A==NO)
    {
        return;
    }
    
    //  =============充值的金额
    _CZJineString=label2.text;
    
    
    NSString *userID=@"123";
    NSString *payment=@"支付宝支付";
    NSString * key=[NewMD5 md5:[NSString  stringWithFormat:@"%@%@%@%@%@%@%@",_CZDianHuaString,_CZJineString,userID,payment,tradeno,@"esaafafasfafafsaff",randkey2]];
    
    //  NSLog(@" %@  %@",_CZDianHuaString,_CZJineString);
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    NSDictionary * pameters=@{@"phone":_CZDianHuaString,@"money":_CZJineString,@"userid":userID,@"payment":payment,@"tradeno":tradeno,@"key":key};
    
    [manager  POST: ChongZhi_URL parameters:pameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic=responseObject;
        NSLog(@"%@",dic);
        
        messagestring=dic[@"message"];
        
        HYCZViewController *controller=[[HYCZViewController alloc]init];
        controller.JEString=label2.text;
        [self.navigationController  pushViewController:controller animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}



#pragma mark-----正则表达式，判断是否为电话号码

- (BOOL)checkTel:(NSString *)str
{
    
    if ([str length] == 0)
    {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"号码不能为空", nil) message:NSLocalizedString(@"请重新出输入", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        return NO;
        
    }
    
    //1[0-9]{10}
    
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    
    //    NSString *regex = @"[0-9]{11}";
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch)
    {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        return NO;
        
    }
    
    return YES;
}

-(void)startDownloadData
{
    
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
