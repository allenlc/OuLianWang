//
//  LogInViewController.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/16.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "LogInViewController.h"
#import "EnrollViewController.h"
#import "AFNetworking.h"
#import "SameCityViewController.h"
#import "MBProgressHUD+ZQ.h"
#import "OLWTabBarController.h"
#import "FindPassword.h"
#import "BackSingle.h"


@interface LogInViewController ()<UITextFieldDelegate>
{
    UITextField *idTextField ;
    UITextField *passWord;
}
@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户登录";
    
    UIImageView * backImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64)];
    backImgView.image =[UIImage imageNamed:@"bjbjx"];
    [self.view addSubview:backImgView];
    
    UIImageView * midImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.view.height*0.37, self.view.width, 80)];
    midImgView.image = [UIImage imageNamed:@"dl_dl"];
    [self.view addSubview:midImgView];
    
    idTextField = [[UITextField alloc]initWithFrame:CGRectMake(60, self.view.height*0.38, self.view.width-120, 30)];
    idTextField.placeholder = @"请输入手机号";
    idTextField.keyboardType = UIKeyboardTypeNumberPad;
    idTextField.delegate = self;
    idTextField.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:idTextField];
    
    UIButton * aBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    aBtn.frame = CGRectMake(self.view.width-40, 10, 20, 20);
    [aBtn setImage:[UIImage imageNamed:@"x_x"] forState:0];
    [midImgView addSubview:aBtn];
    
    passWord = [[UITextField alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(idTextField.frame)+10, self.view.width-120, 30)];
    passWord.placeholder = @"请输入密码";
    passWord.keyboardType = UIKeyboardTypeNumberPad;
    passWord.font = [UIFont systemFontOfSize:13];
    passWord.secureTextEntry = YES;
    passWord.delegate = self;
    passWord.secureTextEntry=YES;
    [self.view addSubview:passWord];
    //测试
    idTextField.text=@"13726292624";
    passWord.text=@"123456";
    
    UIButton * bBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bBtn.frame = CGRectMake(self.view.width-40, 50, 20, 20);
    [bBtn setImage:[UIImage imageNamed:@"eay"] forState:0];
    
    [midImgView addSubview:bBtn];
    
    
    UIButton *logIn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    logIn.frame =CGRectMake(15, CGRectGetMaxY(passWord.frame)+30, self.view.width-30, 30);
    logIn.backgroundColor = ZQColor(245, 225, 225);
    [logIn setTitle:@"登录" forState:0];
    [logIn setTitleColor:[UIColor redColor] forState:0];
    logIn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    logIn.layer.cornerRadius = 5;
    [logIn addTarget: self action:@selector(logIn) forControlEvents:UIControlEventTouchUpInside];
    logIn.tintColor = [UIColor blackColor];
    [self.view addSubview:logIn];
    
    
    UIButton * forgetPassWord = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    forgetPassWord.frame = CGRectMake(self.view.width-90, CGRectGetMaxY(passWord.frame)+70, 70, 20);
    [forgetPassWord setTitle:@"忘记密码？" forState:0];
    [forgetPassWord setTitleColor:ZQColor(245, 225, 225) forState:0];
    forgetPassWord.titleLabel.font = [UIFont systemFontOfSize:13];
    forgetPassWord.contentHorizontalAlignment = 2;
    [forgetPassWord addTarget: self action:@selector(findPassWord) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPassWord];
    
    UILabel * tLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.width/2-50, CGRectGetMaxY(logIn.frame)+60, 80, 20    )];
    tLabel .text = @"还没有账号?";
    tLabel.font = [UIFont systemFontOfSize:13];
    tLabel.textColor = ZQColor(245, 225, 225);
    [self.view addSubview:tLabel];
    
    UIButton *enrollBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    enrollBtn.backgroundColor = ZQColor(245, 225, 225);
    enrollBtn.layer.cornerRadius = 5;
     enrollBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [enrollBtn setTitleColor:[UIColor redColor] forState:0];
    enrollBtn.frame =CGRectMake(self.view.width/2+30, CGRectGetMaxY(logIn.frame)+60, 60, 20);
    [enrollBtn setTitle:@"快速注册" forState:0];
    [enrollBtn addTarget: self action:@selector(enroll) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:enrollBtn];
    self.view.userInteractionEnabled = YES;
    
    
}


-(void)back
{
    MyAccount * Account = [MyAccountTool account];
    
    if (Account) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        //2 从没登陆过
        [self.navigationController popViewControllerAnimated:YES];
        
    }

    
}
-(void)viewWillAppear:(BOOL)animated
{
    OLWTabBarController * tabBarVC =(OLWTabBarController *) self.tabBarController;
    tabBarVC.zqTabBar.hidden = YES;
}


-(void)findPassWord
{
    FindPassword * findPasswordVC= [FindPassword new];
    [self.navigationController pushViewController:findPasswordVC animated:YES];
}
-(void)enroll
{
    EnrollViewController * enrollViewController = [EnrollViewController new];
    [self.navigationController pushViewController:enrollViewController animated:YES];
}

//登录按钮
-(void)logIn
{
    
    [self.view endEditing:YES];

    [MBProgressHUD showMessage:@"正在登录中"];
    
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
//    获得参数
    
    NSString *lan=@"0";//维度
    NSString *lon=@"0";//精度
    NSString *cityId=@"0";//城市id
    NSString *prov=@"0";//省id
    BackSingle *single=[BackSingle shareInstance];
    if (single.lon) {
        lan=single.lan;
        lon= single.lon;
        cityId = single.cityId;
        prov = single.provId;
    }
    NSString * areaid = @"0";
    NSString * phoneID  =idTextField.text;
    NSString * password =[NewMD5 md5:passWord.text] ;

    NSString * key = [NewMD5 md5:[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",phoneID,password,lon,lan,prov,cityId,areaid,DefaultKey]];
    
     NSDictionary * parames = @{@"action":@"login",@"phone":phoneID,@"password":password,@"longitude":lon,@"latitude":lan,@"provid":prov,@"cityid":cityId,@"areaid":areaid,@"key":key};
    // 2.发送POST请求
    [mgr POST:PERSONCENTER_URL parameters:parames
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          [MBProgressHUD hideHUD];
          NSLog(@"responseObj=%@",responseObj);
          NSString * message = [responseObj objectForKey:@"message"];
          NSString * code = [responseObj objectForKey:@"code"];
         
          
          if ([code isEqualToString:@"0"]) {
              

              NSDictionary * dic = [responseObj objectForKey:@"list"];
              //字典转模型
              MyAccount * account = [MyAccount accountWithDic:dic];
              //存储账号模型
              [MyAccountTool save:account];
            [self.navigationController popViewControllerAnimated:YES];
              OLWTabBarController * olwTabBarController = (OLWTabBarController *)self.tabBarController;
              olwTabBarController.selectedViewController = olwTabBarController.viewControllers[4];
              
          }
          else {
             [MBProgressHUD showError:message];
          }
          //保存密码
          
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          [MBProgressHUD hideHUD];
          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败"
                                                          message:@"请检查"
                                                         delegate:nil
                                                cancelButtonTitle:@"YES" otherButtonTitles:nil];
          [alert show];
      }];
    
}

//开始编辑输入框的时候，软键盘出现，执行此事件

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
//    NSLog(@"开始编辑输入框的时候，软键盘出现，执行此事件");
    [UIView animateWithDuration:0.25 animations:^{
          self.view.center = CGPointMake(self.view.width/2, self.view.height*0.25);
    }];
  
    
}
//输入框编辑完成以后，将视图恢复到原始状态

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
//    NSLog(@"输入框编辑完成以后，将视图恢复到原始状态");
    
    [UIView animateWithDuration:0.25 animations:^{
        self.view.center = CGPointMake(self.view.width/2, self.view.height*0.5);
    }];
}
//当用户按下return键或者按回车键，keyboard消失

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSLog(@"当用户按下return键或者按回车键，keyboard消失");
    
    [textField resignFirstResponder];
    
    return YES;
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
