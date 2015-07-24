//
//  NewpromoInfoVC.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/7.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "NewpromoInfoVC.h"
#import "OLWTabBarController.h"
#import "NewGoodsVC.h"
@interface NewpromoInfoVC ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    UIScrollView *myScrollView;
    UIScrollView * picScrollView;
    UIScrollView * contentPicScrollView;
}
@property(nonatomic,weak    )UIButton * firstGoods_pic;
@end

@implementation NewpromoInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(fabu)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.title = @"发布促销信息";
    [self createScrollView];
    
    
}
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
    myScrollView.contentSize = CGSizeMake(self.view.width, 685);
    [self.view addSubview:myScrollView];
    [self createfirstView];
    [self createSecondView];
    [self createThreeView];
    [self createFourthView];
    [self createFifthView];
    
}

-(void)fabu
{
   // [self.navigationController pushViewController:[NewGoodsVC new] animated:YES];
}
-(void)createfirstView
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 135)];
    [myScrollView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel  * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 70, 20)];
    label.text = @"推广标题";
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    UITextField  * textField = [[UITextField alloc]initWithFrame:CGRectMake(85, 10, 100, 20)];
    textField.placeholder = @"请输入推广标题";
    textField.font = [UIFont systemFontOfSize:14];
    [view addSubview:textField];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(15, 40, 120, 60)];
    [btn setImage:[UIImage imageNamed:@"add01"] forState:UIControlStateNormal];
    [view addSubview:btn];
    btn.tag = 1001;
    [btn addTarget:self action:@selector(selectPic:) forControlEvents:UIControlEventTouchUpInside];
    _firstGoods_pic= btn;
    
    UILabel  * label2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 105, self.view.width-30, 20)];
    label2.text = @"宣传图片(尺寸480*200,用于信息的宣传图)";
    label2.font = [UIFont systemFontOfSize:14];
    label2.textColor = [UIColor grayColor];
    [view addSubview:label2];
}

-(void)createSecondView
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 145, self.view.width, 150)];
    [myScrollView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel  * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 120, 200, 20)];
    label.text = @"内容图片(尺寸480*800)";
    label.textAlignment = 0;
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    contentPicScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, self.view.width, 115)];
    contentPicScrollView.contentSize = CGSizeMake(self.view.width, 65);
    [view addSubview:contentPicScrollView];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(15, 0, 60, 100)];
    [btn setImage:[UIImage imageNamed:@"add02"] forState:0];
    btn.tag = 1002;
    [btn addTarget:self action:@selector(selectPic:) forControlEvents:UIControlEventTouchUpInside];
    
    [contentPicScrollView addSubview:btn];
}

-(void)createThreeView
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 305, self.view.width, 120)];
    [myScrollView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel  * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 95, 60, 20)];
    label.text = @"推广产品";
    label.textAlignment = 1;
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    picScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, self.view.width, 85)];
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
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 435, self.view.width, 120)];
    [myScrollView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel  * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 70, 20)];
    label.text = @"促销价格";
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    UILabel  * label1 = [[UILabel alloc]initWithFrame:CGRectMake(85, 10, 50, 20)];
    label1.text = @"原价的";
    label1.textColor = [UIColor greenColor];
    label1.font = [UIFont systemFontOfSize:14];
    [view addSubview:label1];
    
    UILabel  * label2 = [[UILabel alloc]initWithFrame:CGRectMake(185, 10, 20, 20)];
    label2.text = @"%";
    label2.textColor = [UIColor greenColor];
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label2];
    
    UITextField  * textField = [[UITextField alloc]initWithFrame:CGRectMake(132, 10, 50, 20)];
    textField.delegate = self;
    textField.background = [UIImage imageNamed:@"输入01(1)"];
    textField.font = [UIFont systemFontOfSize:14];
    [view addSubview:textField];
    
    UILabel  * label3 = [[UILabel alloc]initWithFrame:CGRectMake(15, 50, 70, 20)];
    label3.text = @"促销时间";
    label3.font = [UIFont systemFontOfSize:14];
    [view addSubview:label3];
    
    UILabel  * label4 = [[UILabel alloc]initWithFrame:CGRectMake(85, 50, 70, 20)];
    label4.text = @"开始时间";
    label4.textColor = [UIColor orangeColor];
    label4.font = [UIFont systemFontOfSize:14];
    [view addSubview:label4];
    
    UILabel  * label5 = [[UILabel alloc]initWithFrame:CGRectMake(85, 80, 60, 20)];
    label5.text = @"结束时间";
     label5.textColor = [UIColor orangeColor];
    label5.font = [UIFont systemFontOfSize:14];
    [view addSubview:label5];
    
    UIImageView * imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(249, 50, 20, 20)];
    imgView1.image = [UIImage imageNamed:@"date_fbcx"];
    [view addSubview:imgView1];
    
    UIImageView * imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(249, 80, 20, 20)];
    imgView2.image = [UIImage imageNamed:@"date_fbcx"];
    [view addSubview:imgView2];

    
    UITextField  * textField1 = [[UITextField alloc]initWithFrame:CGRectMake(145, 50, 100, 20)];
    textField1.delegate = self;
    textField1.background = [UIImage imageNamed:@"输入02(1)"];
    textField1.font = [UIFont systemFontOfSize:14];
    [view addSubview:textField1];
    
    UITextField  * textField3 = [[UITextField alloc]initWithFrame:CGRectMake(145, 80, 100, 20)];
    textField3.delegate = self;
    textField3.background = [UIImage imageNamed:@"输入02(1)"];
    textField3.font = [UIFont systemFontOfSize:14];
    [view addSubview:textField3];



    
}

-(void)createFifthView
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 565, self.view.width, 120)];
    [myScrollView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel  * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 70, 20)];
    label.text = @"推广内容";
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    UITextField  * textField1 = [[UITextField alloc]initWithFrame:CGRectMake(85, 10, 100, 20)];
    textField1.delegate = self;
    textField1.placeholder = @"请输入本次推广的内容";
    textField1.font = [UIFont systemFontOfSize:14];
    [view addSubview:textField1];
    
    
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
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(15+75*i, 60, 60, 20)];
            label.textAlignment = 1;
            label.font = [UIFont systemFontOfSize:13];
            label.text = [NSString stringWithFormat:@"产品%d",i+1];
            [picScrollView addSubview:label];
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
                contentPicScrollView.contentSize = CGSizeMake(75*(i+2)+15, 65);
                contentPicScrollView.contentOffset =CGPointMake(75*(i-2), 0);
            }
            UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(15+75*i, 0, 60, 100)];
            imgView.image = image;
            [contentPicScrollView addSubview:imgView];
            ( (UIButton *)[contentPicScrollView viewWithTag:1002]).x+=75;
            i++;
            
        }
            
        default:
            break;
    }
    
    
    
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
