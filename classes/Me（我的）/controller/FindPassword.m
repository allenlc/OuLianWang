//
//  FindPassword.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/25.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "FindPassword.h"
#import "OLWTabBarController.h"

@interface FindPassword ()<UITextFieldDelegate>
{
    UITextField *idTextField;
    UITextField *passWord;
    UITextField *confirmField;
    UITextField *authCode;
}
@end

@implementation FindPassword
-(void)viewWillAppear:(BOOL)animated
{
    OLWTabBarController * tabBarVC =(OLWTabBarController *) self.tabBarController;
    tabBarVC.zqTabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    OLWTabBarController * tabBarVC =(OLWTabBarController *) self.tabBarController;
    tabBarVC.zqTabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"找回密码";
    
    UIImageView * backImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64)];
    backImgView.image =[UIImage imageNamed:@"bjbjx"];
    [self.view addSubview:backImgView];
    
    UIImageView * midImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.view.height*0.35, self.view.width, 170)];
    midImgView.image = [UIImage imageNamed:@"zhaohuimimajiemian"];
    [self.view addSubview:midImgView];
    
    
    
    idTextField = [[UITextField alloc]initWithFrame:CGRectMake(80, midImgView.y+4, self.view.width-120, 170/4-5)];
    idTextField.placeholder = @"请输入您的手机号";
    idTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:idTextField];
    idTextField.delegate = self;
    
    passWord = [[UITextField alloc]initWithFrame:CGRectMake(80, CGRectGetMaxY(idTextField.frame)+8, self.view.width-120, idTextField.height)];
    passWord.placeholder = @"请设置您的新密码";
    passWord.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    passWord.delegate = self;
    [self.view addSubview:passWord];
    
    confirmField = [[UITextField alloc]initWithFrame:CGRectMake(80, CGRectGetMaxY(passWord.frame)+6, self.view.width-120, idTextField.height)];
    confirmField.placeholder = @"请确认您的新密码";
    confirmField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    confirmField.delegate = self;
    [self.view addSubview:confirmField];
    
    authCode = [[UITextField alloc]initWithFrame:CGRectMake(80, CGRectGetMaxY(confirmField.frame)+4, confirmField.width/2, idTextField.height)];
    authCode.placeholder = @"验证码";
    authCode.keyboardType = UIKeyboardTypeNumberPad;
    authCode.delegate = self;
    [self.view addSubview:authCode];
    
    UIButton * authCodeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    authCodeBtn.frame = CGRectMake(100+authCode.width, CGRectGetMaxY(confirmField.frame)+5, authCode.width, 27);
    authCodeBtn.layer.borderWidth = 1;
    authCodeBtn.layer.cornerRadius = 3;
    authCodeBtn.layer.borderColor = ZQColor(201, 0, 9).CGColor;
    authCodeBtn.layer.shadowOffset= CGSizeMake(3, 5);
    authCodeBtn.layer.shadowOpacity = 2 ;
    authCodeBtn.layer.backgroundColor = [UIColor blackColor].CGColor;
    authCodeBtn.backgroundColor = [UIColor whiteColor];
    authCodeBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    [authCodeBtn setTitle:@"获取验证码" forState:0];
    [authCodeBtn setTitleColor:ZQColor(201, 0, 9) forState:0];
    [authCodeBtn addTarget:self action:@selector(getAuthCode) forControlEvents:UIControlEventTouchUpInside];
    authCodeBtn.tintColor = [UIColor blackColor];
    [self.view addSubview:authCodeBtn];
    
    UIButton *enroll = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    enroll.backgroundColor = ZQColor(246, 210, 208);
    enroll.frame =CGRectMake(20, CGRectGetMaxY(authCodeBtn.frame)+30, self.view.width-40, 40);
    enroll.layer.cornerRadius = 3;
    enroll.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [enroll setTitle:@"确认" forState:0];
    [enroll setTitleColor:ZQColor(201, 0, 9) forState:0];
    [enroll addTarget: self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:enroll];
    
    
    
}

-(void)getAuthCode
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //    获得参数
    NSString * phoneID  =idTextField.text;
    NSString * password =[NewMD5 md5:passWord.text] ;
    NSLog(@"%@",password);
    NSString * key = [NewMD5 md5:[NSString stringWithFormat:@"%@%@",phoneID,DefaultKey]];
    NSLog(@"key = %@",key);
    
    NSDictionary * parames = @{@"action":@"send",@"phone":phoneID,@"key":key};
    // 2.发送POST请求
    [mgr POST:DefaultUrl parameters:parames
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          NSLog(@"获取验证码成功");
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"fail");
      }];
    
}

-(void)confirm
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //    获得参数
    NSString * phoneID  =idTextField.text;
    NSString * password =[NewMD5 md5:passWord.text] ;
    NSLog(@"%@",password);
    NSString * word = authCode.text;
    NSString * key = [NewMD5 md5:[NSString stringWithFormat:@"%@%@%@%@",phoneID,password,word,DefaultKey]];
    NSLog(@"key = %@",key);
    
    NSDictionary * parames = @{@"action":@"findpwd",@"phone":phoneID,@"newpwd":password,@"word":word,@"key":key};
    // 2.发送POST请求
    [mgr POST:DefaultUrl parameters:parames
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          NSLog(@"responseObj=%@",responseObj);
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"fail");
      }];

}

//开始编辑输入框的时候，软键盘出现，执行此事件

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    NSLog(@"开始编辑输入框的时候，软键盘出现，执行此事件");
    [UIView animateWithDuration:0.25 animations:^{
        self.view.center = CGPointMake(self.view.width/2, self.view.height*0.3);
    }];
    
    
}
//输入框编辑完成以后，将视图恢复到原始状态

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSLog(@"输入框编辑完成以后，将视图恢复到原始状态");
    
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
