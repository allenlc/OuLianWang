//
//  NewGoodsVC.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/7.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "NewGoodsVC.h"
#import "OLWTabBarController.h"
#import "MyTextView.h"
#import "AFNetworking.h"
#import "MD5.h"

@interface NewGoodsVC ()<UITextFieldDelegate,UITextViewDelegate>
{
    
    UIScrollView *myScrollView;
    UIScrollView * picScrollView;
    UIScrollView * sourcePicScrollView;
    UIButton * currentYesBtn;
    
    
}
@property(nonatomic,weak)UIButton * firstGoods_pic;

@end

@implementation NewGoodsVC
-(void)loadView
{
    [super loadView];
    UIButton *diqubutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [diqubutton  setImage:[UIImage imageNamed:@"返回箭头.png"] forState:UIControlStateNormal];
    [diqubutton  addTarget:self action:@selector(diquButtonClick) forControlEvents:UIControlEventTouchUpInside];
    diqubutton.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    diqubutton.frame=CGRectMake(0, 0,20,20);
    UIBarButtonItem *leftbutton=[[UIBarButtonItem alloc]initWithCustomView:diqubutton];
    
    // 调整 leftBarButtonItem 在 iOS7 下面的位置
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0))
        
    {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                       target:nil action:nil];
        negativeSpacer.width = -10;//这个数值可以根据情况自由变化
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftbutton];
    }
    else
        
        self.navigationItem.leftBarButtonItem = leftbutton;
}

-(void)diquButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    //[super viewDidLoad];
    self.view.backgroundColor = ZQColor(232, 232, 232);
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(fabu)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.title = @"发布商品";
    [self createScrollView];
    
}


-(void)fabu
{
    
  [self requestData ];
    
}

-(void)requestData
{
    
    NSString * storeid  =@"1";
    NSString * goodsname  =@"zhangxu";
    NSString * gcryid  = @"1";
    NSString * price  =@"1.2";
    NSString * gdiscount  =@"1";
    NSString * goods_attr  = @"zhangxu";
    NSString * goods_desc  =@"wst";
    NSString * is_attached =@"1";
    NSString * is_book=@"1";
    NSString * otid=@"1";
    NSString * inventory=@"500";
    
    //   key============================================
    NSString * key =[NewMD5 md5:[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",storeid,goodsname,gcryid,price,otid,gdiscount,is_book,is_attached,inventory,@"esaafafasfafafsaff"]] ;
    
    //    接口
    //  http://weixin.hsmja.com/wolian/personcenter.php?action=releasegoods&storeid=1&goodsname=aaa&gcryid=1&price=1.2&otid=1&gdiscount=1&is_book=1&is_attached=1&inventory=500&goods_attr=aaa&goods_desc=bbb&key=d9f3b1bc961795da72a1823068018d0b
    
    //  http://weixin.hsmja.com/wolian/personcenter.php?action=releasegoods&storeid=1&goodsname=aaa&gcryid=1&price=1.2&otid=服务时间ID&gdiscount=产品折扣&is_book=是否可预定&is_attached=是否有附属产品&inventory=库存量&goods_attr=商品属性&goods_desc=商品简介&goodsimg_list=图片相册的文件域name属性&materialimg_list=原料相册的文件域name属性&goods_video=商品视频文件域的name属性&key=d9f3b1bc961795da72a1823068018d0b
    
    // 参数字典==========================================
    NSString *urlString=@"http://weixin.hsmja.com/wolian/personcenter.php?";
    NSDictionary * parames = @{@"action":@"releasegoods",@"storeid":storeid,@"goodsname":goodsname,@"gcryid":gcryid,@"price":price,@"otid":otid,@"gdiscount":gdiscount,@"goods_attr":goods_attr,@"is_book":is_book,@"is_attached":is_attached,@"inventory":inventory,@"goods_desc":goods_desc,@"key":key};
    
    NSLog(@"%@",parames);
    
    //  图片相册数组===============================================
    UIImage *image1=[UIImage imageNamed:@"shangpinguanlichanpin"];
    UIImage *image2=[UIImage imageNamed:@"gengduokaixinyike"];
    UIImage *image3=[UIImage imageNamed:@"gengduojingcaishipin"];
    NSArray *array=@[image1,image2,image3];
    
    //  原料相册数组===============================================
//    UIImage *Yimage1=[UIImage imageNamed:@"shangpinguanlichanpin"];
//    UIImage *Yimage2=[UIImage imageNamed:@"gengduokaixinyike"];
//    UIImage *Yimage3=[UIImage imageNamed:@"gengduojingcaishipin"];
//    NSArray *YLarray=@[Yimage1,Yimage2,Yimage3];
    
//  视频数据===================================================
//    NSString * str1 = [[NSBundle mainBundle]pathForResource:@"梁宝强-请让我爱你-国语[www.mtvxz.cn]" ofType:@"mp4"];
//    NSString * str2 = [[NSBundle mainBundle]pathForResource:@"梁宝强-请让我爱你-国语[www.mtvxz.cn]" ofType:@"mp4"];
//
//    
//    NSURL * url1  = [NSURL fileURLWithPath:str1];
//    NSURL * url2  = [NSURL fileURLWithPath:str2];
//    NSArray *SPArray=@[url1,url2];
//    
    
    
    //1================= 获得请求管理者 上传图片
    AFHTTPRequestOperationManager *mgr1 = [AFHTTPRequestOperationManager manager];
    [mgr1   POST:urlString parameters:parames constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         
         
         //  添加图片相册数据===========================================添加图片相册数据
         for ( UIImage *image  in array)
         {
             NSData * imagedata = UIImagePNGRepresentation(image);
             [formData appendPartWithFileData:imagedata name:@"goodsimg_list[]" fileName:@"image.png" mimeType:@"image/png"];
         }
         
        //  添加原料相册数据===========================================添加原料相册数据
//         for ( UIImage *Yimage  in YLarray)
//         {
//             NSData * imagedata = UIImagePNGRepresentation(Yimage);
//             [formData appendPartWithFileData:imagedata name:@"materialimg_list[]" fileName:@"Yimage.png" mimeType:@"image/png"];
//         }
         
        //  添加视频数据===========================================添加视频数据
         
//         for (NSURL  * SPUrl in SPArray)
//         {
//             NSData *SPdata=[NSData dataWithContentsOfURL:SPUrl];
//             [formData appendPartWithFileData:SPdata name:@"goods_video[]" fileName:@"video1.mp4" mimeType:@"video/mp4"];
//            
//         }
         //  打印上传的数据  NSLog(@"========%@",formData);
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
           //  没法解析返回的responseObject。只能根据返回的 code 的值来判断。。
           NSLog(@"respone  ========= %@",responseObject);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
           // 打印错误
           NSLog(@" ==========%@",error);
         
     }];}

#pragma mark-----隐藏标签栏
-(void)viewWillAppear:(BOOL)animated
{
    ((OLWTabBarController *)self.tabBarController).zqTabBar.hidden = YES;

}

-(void)viewWillDisappear:(BOOL)animated
{
    ((OLWTabBarController *)self.tabBarController).zqTabBar.hidden = YES;
}
-(void)createScrollView
{
    myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height+50)];
    myScrollView.backgroundColor = ZQColor(232, 232, 232);
    myScrollView.contentSize = CGSizeMake(self.view.width, 1170);
    [self.view addSubview:myScrollView];
    [self createfirstView];
    [self createNumberAndTimeView];
    [self createSecondView];
    [self createThreeView];
    [self createFourthView];
    [self createFifthView];
   
}
-(void)createfirstView
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 135)];
    [myScrollView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel  * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 70, 20)];
    label.text = @"商品名称";
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    UITextField  * textField = [[UITextField alloc]initWithFrame:CGRectMake(85, 10, 100, 20)];
    textField.delegate = self;
    textField.placeholder = @"请输入商品名称";
    textField.font = [UIFont systemFontOfSize:14];
    [view addSubview:textField];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(15, 40, 60, 60)];
    [btn setImage:[UIImage imageNamed:@"fabushangpin"] forState:UIControlStateNormal];
    [view addSubview:btn];
    btn.tag = 1001;
    [btn addTarget:self action:@selector(selectPic:) forControlEvents:UIControlEventTouchUpInside];
    _firstGoods_pic= btn;
    
    UILabel  * label2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 105, 60, 20)];
    label2.text = @"商品图片";
    label2.textAlignment = 1;
    label2.font = [UIFont systemFontOfSize:14];
    label2.textColor = [UIColor grayColor];
    [view addSubview:label2];
}
-(void)createNumberAndTimeView
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 145, self.view.width, 245)];
    [myScrollView addSubview:view];
    
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel  * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 70, 20)];
    label.text = @"库存数量";
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    UILabel  * label1 = [[UILabel alloc]initWithFrame:CGRectMake(85, 10, 100, 20)];
    label1.text = @"请输入库存数量";
    label1.font = [UIFont systemFontOfSize:14];
    label1.textColor = [UIColor grayColor];
    [view addSubview:label1];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.width-80, 7, 70, 30)];
    [btn addTarget:self action:@selector(selectYes:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitle:@"可预订" forState:0];
    [btn setTitleColor:[UIColor blackColor] forState:0];
    [btn setImage:[UIImage imageNamed:@"NewGoods_no-sel"] forState:0];
    [btn setImage:[UIImage imageNamed:@"NewGoods_sel"] forState:UIControlStateSelected];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(5, 0, 5, 50)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(5, -20, 5, 0)];
    [view addSubview:btn];
    
    UILabel  * label2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 40, 70, 20)];
    label2.text = @"服务时间";
    label2.font = [UIFont systemFontOfSize:14];
    [view addSubview:label2];
    
    for (int i = 0; i<4; i++) {
        UIButton * selectTimeBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 65+35*i, 30, 30)];

        [selectTimeBtn setImage:[UIImage imageNamed:@"NewGoods_no-sel"] forState:0  ];
        [selectTimeBtn setImage:[UIImage imageNamed:@"NewGoods_sel"] forState:UIControlStateSelected];
        [selectTimeBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        [selectTimeBtn addTarget:self action:@selector(selectYes:) forControlEvents:UIControlEventTouchUpInside];

        [view addSubview:selectTimeBtn];
    }
    
    NSArray * arrLabTexts = @[@"每天 12:30-13:30",@"每天 18:30-19:30",@"2015/06/05~2015/07/08 12:30~13:30",@"2015/06/05~2015/07/08 18:30~19:30"];
    for (int i = 0; i<4; i++) {
        UILabel * selectTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(50, 65+35*i, self.view.width-65, 30)];
        selectTimeLab.font = [UIFont systemFontOfSize:14];
        selectTimeLab.text = arrLabTexts[i];
               [view addSubview:selectTimeLab];
    }
    UILabel * label4 = [[UILabel alloc]initWithFrame:CGRectMake(15, view.height-40, 100, 30)];
    label4.text = @"是否有附属产品";
    label4.font = [UIFont systemFontOfSize:13];
    [view addSubview:label4];
    
    NSArray * arr = @[@"是",@"否"];
    for (int i = 0; i<2; i++) {
        UIButton * selectYesBtn = [[UIButton alloc]initWithFrame:CGRectMake(160+50*i, view.height-40, 40, 30)];
        [selectYesBtn setTitle:arr[i] forState:0];
        selectYesBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [selectYesBtn setTitleColor:[UIColor blackColor] forState:0];
        //        selectTimeBtn.backgroundColor = ZQRandomColor   ;
        [selectYesBtn setImage:[UIImage imageNamed:@"NewGoods_noselect"] forState:0  ];
        [selectYesBtn setImage:[UIImage imageNamed:@"NewGoods_select"] forState:UIControlStateSelected];
        [selectYesBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 0, 5, 20)];
        [selectYesBtn setTitleEdgeInsets:UIEdgeInsetsMake(5, -20, 5, 0)];
        [selectYesBtn addTarget:self action:@selector(selectYesOrNO:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:selectYesBtn];
    }

    
   }
-(void)selectYesOrNO:(UIButton *)btn
{
    if ([currentYesBtn isEqual:btn]) {
        
    }
    else{
        currentYesBtn.selected=NO;
        currentYesBtn=btn;
        currentYesBtn.selected=YES;
    }

}
-(void)selectYes:(UIButton *)senderBt
{
    if (senderBt.selected == NO) {
        senderBt.selected =YES;
    }
    else {
        senderBt.selected = NO;
    }
}
-(void)createSecondView
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 400, self.view.width, 280)];
    [myScrollView addSubview:view];
    
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel  * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 70, 20)];
    label.text = @"所属分类";
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    UILabel  * label1 = [[UILabel alloc]initWithFrame:CGRectMake(85, 10, 100, 20)];
    label1.text = @"选择分类";
    label1.font = [UIFont systemFontOfSize:14];
    label1.textColor = [UIColor grayColor];
    [view addSubview:label1];
    
    UILabel  * label2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 40, 70, 20)];
    label2.text = @"价格(￥)";
    label2.font = [UIFont systemFontOfSize:14];
    [view addSubview:label2];
    
    UITextField  * textField = [[UITextField alloc]initWithFrame:CGRectMake(85, 40, 100, 20)];
    textField.delegate = self;
    textField.placeholder = @"请输入商品价格";
    textField.font = [UIFont systemFontOfSize:14];
    [view addSubview:textField];
    
    UILabel  * label3 = [[UILabel alloc]initWithFrame:CGRectMake(15, 72, 70, 20)];
    label3.text = @"商品属性";
    label3.font = [UIFont systemFontOfSize:14];
    [view addSubview:label3];
    
    MyTextView  * textView1 = [[MyTextView alloc]initWithFrame:CGRectMake(85, 65, self.view.width-95, 80)];
    textView1.delegate = self;
    textView1.placehoder = @"如品牌:皇室美家;风格:简约";
    textView1.font = [UIFont systemFontOfSize:14];
    [view addSubview:textView1];
    
    UILabel  * label4 = [[UILabel alloc]initWithFrame:CGRectMake(15, 167, 70, 20)];
    label4.text = @"商品简介";
    label4.font = [UIFont systemFontOfSize:14];
    [view addSubview:label4];
    
    MyTextView  * textView2 = [[MyTextView alloc]initWithFrame:CGRectMake(85, 160, self.view.width-95, 80)];
    textView2.delegate = self;
    textView2.placehoder = @"请输入商品简介";
    textView2.font = [UIFont systemFontOfSize:14];
    [view addSubview:textView2];

    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.width-40, 10, 30, 30)];
    [btn setImage:[UIImage imageNamed:@"fenlei_spgl"] forState:UIControlStateNormal];
    [view addSubview:btn];
}

-(void)createThreeView
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 690, self.view.width, 100)];
    [myScrollView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel  * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 75, 60, 20)];
    label.text = @"商品相册";
    label.textAlignment = 1;
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    picScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, self.view.width, 65)];
    picScrollView.contentSize = CGSizeMake(self.view.width, 65);
    [view addSubview:picScrollView];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(15, 0, 60, 60)];
    [btn setImage:[UIImage imageNamed:@"fabushangpin"] forState:0];
    btn.tag = 1000;
    [btn addTarget:self action:@selector(selectPic:) forControlEvents:UIControlEventTouchUpInside];
    
    [picScrollView addSubview:btn];
    
}

-(void)createFourthView
{

    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 800, self.view.width, 100)];
    [myScrollView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel  * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 75, 60, 20)];
    label.text = @"商品原料";
    label.textAlignment = 1;
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    sourcePicScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, self.view.width, 65)];
    sourcePicScrollView.contentSize = CGSizeMake(self.view.width, 65);
    [view addSubview:sourcePicScrollView];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(15, 0, 60, 60)];
    [btn setImage:[UIImage imageNamed:@"fabushangpin"] forState:0];
    btn.tag = 1002;
    [btn addTarget:self action:@selector(selectPic:) forControlEvents:UIControlEventTouchUpInside];
    
    [sourcePicScrollView addSubview:btn];

}

-(void)createFifthView
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 910, self.view.width, 260)];
    [myScrollView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel  * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 70, 20)];
    label.text = @"视频介绍";
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    NSArray * arr = @[@"fabuzaixianshipin",@"fabubendishipin"];
    for ( int i = 0; i<2; i++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.width/2+80*i, 15,70,25)];
        [btn setBackgroundImage:[UIImage imageNamed:arr[i]] forState:0];
        [view addSubview:btn];
    }
    
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(40, 55, self.view.width-80, self.view.width-80-50)];
    imgView.image = [UIImage imageNamed:@"shipingjieshao"];
    [view addSubview:imgView];

}

-(void)selectPic:(UIButton * )sender
{
    [self popActionSheet:sender.tag];
}
- (void)popActionSheet:(int)tag
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:@"拍照上传"
                                                    otherButtonTitles:@"本地照片上传",nil];
    [actionSheet setBackgroundColor:[UIColor clearColor]];
    actionSheet.tag = tag;
    [actionSheet showInView:self.view.window];
}
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    switch (buttonIndex)
    {
            
        case 0://take photo
        {
            [self presentModalViewController:picker animated:YES];
            
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.allowsEditing = YES;
            picker.delegate = self;
            
            break;
        }
        case 1://upload image
        {
            //            UIImagePickerController * picker = [[UIImagePickerController alloc]init];
            [self presentModalViewController:picker animated:YES];
            picker.view.tag = actionSheet.tag;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.allowsEditing = YES;
            picker.delegate = self;
            
            break;
        }
        case 2://cancel
        {
            [self.presentedViewController dismissModalViewControllerAnimated:YES];
            break;
        }
        default:
            break;
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    /*添加处理选中图像代码*/
    [picker dismissModalViewControllerAnimated:YES];
    //img_head = image;
    switch (picker.view.tag) {
        case 1000:
        {
            static int i = 0;
            if (i>2) {
                picScrollView.contentSize = CGSizeMake(75*(i+2)+15, 65);
                picScrollView.contentOffset =CGPointMake(75*(i-2), 0);
            }
            
            
            
            UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(15+75*i, 0, 60, 60)];
            imgView.image = image;
            [picScrollView addSubview:imgView];
            ( (UIButton *)[picScrollView viewWithTag:1000]).x+=75;
            i++;
            
        }
            break;
        case 1001:
        {
            [_firstGoods_pic setImage:image forState:0];
            
        }
            break;
        case 1002:
        {
            static int i = 0;
            if (i>2) {
                sourcePicScrollView.contentSize = CGSizeMake(75*(i+2)+15, 65);
                sourcePicScrollView.contentOffset =CGPointMake(75*(i-2), 0);
            }
            UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(15+75*i, 0, 60, 60)];
            imgView.image = image;
            [sourcePicScrollView addSubview:imgView];
            ( (UIButton *)[sourcePicScrollView viewWithTag:1002]).x+=75;
            i++;
            
        }
            
        default:
            break;
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
//开始编辑输入框的时候，软键盘出现，执行此事件

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    NSLog(@"开始编辑输入框的时候，软键盘出现，执行此事件");
    [UIView animateWithDuration:0.25 animations:^{
        self.view.center = CGPointMake(self.view.width/2, 100);
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
