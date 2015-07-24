//
//  HYCZViewController.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/23.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "HYCZViewController.h"
#import "UIView+LCView.h"
#import "LCTapGesture.h"
#import "OLWTabBarController.h"
#import "ZFcgViewController.h"
#import "Order.h"
#import "Product.h"
//#import 

@interface HYCZViewController ()
{
    UILabel *_shouKuanLabel;
    UILabel *_dingDanHaoLabel;
    int _buyNumber;
    UIImageView *_zhifuImageView;
    UIView *_zhifuView;
    UITextField *_moneyField;
}
@end

@implementation HYCZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"会员充值";
    self.view.backgroundColor=ZQColor(224, 227, 229);
    [self createUI];
}
-(void)createUI
{
    __weak  typeof (self)WeakSelf=self;
    
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 64, 320, 100)];
    view1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view1];
    
    [view1 addImageViewWithFrame:CGRectMake(5, 50, 310, 1) image:@"fengeline.png"];
    
    [view1 addLabelWithFrame:CGRectMake(15, 10, 80, 30) text:@"收款商家"];
    _shouKuanLabel=[view1 addLabelWithFrame:CGRectMake(105, 10, 80, 30) text:@"皇家美室"];
    //模拟购买号
    _buyNumber=888;
    [view1 addLabelWithFrame:CGRectMake(15, 10+50, 80, 30) text:@"订单编号"];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYYMMDD"];
    
    _dingDanHaoLabel= [view1 addLabelWithFrame:CGRectMake(105, 10+50, 200, 30) text:[NSString stringWithFormat:@"%@%d",[dateFormatter stringFromDate:[NSDate date]],_buyNumber]];

    
    //付款方式
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, 64+100+15, 320, 50)];
    view2.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view2];
    [view2 addLabelWithFrame:CGRectMake(15, 10, 80, 30) text:@"付款方式"];
    _zhifuImageView=[view2 addImageViewWithFrame:CGRectMake(105, 10, 200, 30) image:@"chongzhi1.png"];
    [view2 addImageButtonWithFrame:CGRectMake(290, 20, 20, 20) title:nil image:@"xialazhifu.png" action:^(UIButton *button) {
        [self btnClick];
    }];
    
    
    //充值金额
    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(0, 64+100+15+50+15, 320, 50)];
    view3.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view3];
    [view3 addLabelWithFrame:CGRectMake(15, 10, 80, 30) text:@"充值金额"];
    _moneyField=[[UITextField alloc]initWithFrame:CGRectMake(105, 10, 200, 30)];
    _moneyField.clearButtonMode=UITextFieldViewModeAlways;
    _moneyField.placeholder=@"请输入充值金额";
    _moneyField.text=_JEString;
    _moneyField.keyboardType=UIKeyboardTypeNumberPad;
    [view3 addSubview:_moneyField];
    
    //充值
    [self.view addImageButtonWithFrame:CGRectMake(10, 64+100+15+50+15+50+15, 300, 40) title:nil image:@"chongzhibtn.png" action:^(UIButton *button) {
        
        //支付成功画面
//        ZFcgViewController *controller=[[ZFcgViewController alloc]init];
//        [WeakSelf.navigationController  pushViewController:controller animated:YES];
//        [self payHYCZ];
        
    }];
    
    //选择支付View
    _zhifuView=[[UIView alloc]initWithFrame:CGRectMake(105, 64+100+15+50, 180, 60)];
    [self.view addSubview:_zhifuView];
    UIImageView *iV1=[_zhifuView addImageViewWithFrame:CGRectMake(0, 0, 180, 30) image:@"chongzhi1.png"];
    iV1.tag=400;
    LCTapGesture *tap=[[LCTapGesture alloc]initWithTarget:self action:@selector(tapClick:)];
    tap.age=iV1.tag;
    [iV1 addGestureRecognizer:tap];
    _zhifuView.hidden=YES;
    
}

#pragma mark - 显示选择支付方式
-(void)btnClick
{
    if (_zhifuView.hidden) {
        _zhifuView.hidden=NO;
    }
    else{
        _zhifuView.hidden=YES;
    }
}
-(void)tapClick:(LCTapGesture *)tap
{
    UIImageView *imageView=(UIImageView *)[_zhifuView viewWithTag:tap.age];
    _zhifuImageView.image=imageView.image;
    _zhifuView.hidden=YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



-(void)viewWillAppear:(BOOL)animated
{
    OLWTabBarController *tabbarcontroller=(OLWTabBarController *)self.tabBarController;
    tabbarcontroller.zqTabBar.hidden=YES;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    OLWTabBarController *tabbarcontroller=(OLWTabBarController *)self.tabBarController;
    tabbarcontroller.zqTabBar.hidden=NO;
    
}
//-(void)payHYCZ
//{
//    Product *product=[[Product alloc]init];
//    product.price=[_moneyField.text floatValue];
//    
//    /*============================================================================*/
//    /*=======================需要填写商户app申请的===================================*/
//    /*============================================================================*/
//    NSString *partner = @"2088501449587500";
//    NSString *seller = @"1028646629@qq.com";
//    NSString *privateKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAOVv3ZBiCbjBIlUHwFSF0sEm11TXoJRmn1846g5TaWlsSokJK7MO5pPECe4U5jUdw3BvYnarJTtbLAFEaD8POf1xji0BVqQOfEh77aTK/LhEFFfh345Z+Rhqttx2aWya2HU2qADE5MCbRZfk0fMBUj5NBI9sbBU46BZQJ+GWvNtPAgMBAAECgYEA5FLduCiIKi8w/lN3Z+XBJWyEz67B48z4fueBrP3/IeWdix/wOAH1Hknx49cyfNuAuexunU+V/qqtcRllcJOzjQyr2tX1DlIYaaZTgNg0q9zTTjNjUCZVtm1Mx7TK4/Fu30L30dCWPuHjS/dD3TIL59ht0wljjdZGqN6dZEJWMGECQQD4IBmn0+RqW3AdzQoQh1FeZZkaDyaZpiBy7Gi2oy1dZADZ9nFq1tJQpzKGFqQ26loL1p2oIcA3aD09uUdOTME/AkEA7LfuS9DmIqTF/KC4Mz5zySU9fAQIJEjiuHfVcCsTW8s1F4HOb8PA+F1c/MoyxMvYIdV1u3zXUwpSZWQRXSpR8QJAPJCxUnrxTVjGdC/BXil5nh4UkfzSwjx/vS2hnbsU7q/jWVDDfH21VoSJW5uZN+JaWntnfkvGvH+QO0nHcwBfRwJBALTIh9opEQkWNAqKqAKiyISuxzUmUx16+IOPKVd/3kn1eHeacBFVO9OyYejBd2Jql4bHYiGs5zmJIYJDmStAvdECQQCYrmHRSWueQahM9VuBF53tDTp0gqjC0mGGE5SbXtfsdaq9d0Iu2gScY623YSaH6SIg3UM7c6oa6xYUqQH2UDyA";
//    /*============================================================================*/
//    /*============================================================================*/
//    /*============================================================================*/
//    
//    //partner和seller获取失败,提示
//    if ([partner length] == 0 ||
//        [seller length] == 0 ||
//        [privateKey length] == 0)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                        message:@"缺少partner或者seller或者私钥。"
//                                                       delegate:self
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
//    /*
//     *生成订单信息及签名
//     */
//    //将商品信息赋予AlixPayOrder的成员变量
//    Order *order = [[Order alloc] init];
//    order.partner = partner;
//    order.seller = seller;
//    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
//    order.productName = product.subject; //商品标题
//    order.productDescription = product.body; //商品描述
//    order.amount = [NSString stringWithFormat:@"%.2f",product.price]; //商品价格
//    order.notifyURL =  @"http://www.xxx.com"; //回调URL
//    
//    order.service = @"mobile.securitypay.pay";
//    order.paymentType = @"1";
//    order.inputCharset = @"utf-8";
//    order.itBPay = @"30m";
//    order.showUrl = @"m.alipay.com";
//    
//    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
//    NSString *appScheme = @"alisdkdemo";
//    
//    //将商品信息拼接成字符串
//    NSString *orderSpec = [order description];
//    NSLog(@"orderSpec = %@",orderSpec);
//    
//    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(privateKey);
//    NSString *signedString = [signer signString:orderSpec];
//    
//    将签名成功字符串格式化为订单字符串,请严格按照该格式
//    NSString *orderString = nil;
//    if (signedString != nil) {
//        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                       orderSpec, signedString, @"RSA"];
//        
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            NSLog(@"reslut = %@",resultDic);
//        }];
//        
//
//    }
//
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
