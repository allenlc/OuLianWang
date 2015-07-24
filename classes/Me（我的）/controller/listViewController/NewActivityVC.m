//
//  NewActivityVC.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/7.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "NewActivityVC.h"
#import "OLWTabBarController.h"
@interface NewActivityVC ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    UIScrollView *myScrollView;
    UIScrollView * picScrollView;
    UIScrollView * contentPicScrollView;
}
@property(nonatomic,weak    )UIButton * firstGoods_pic;
@end

@implementation NewActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(fabu)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.title = @"发布活动信息";
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
    myScrollView.contentSize = CGSizeMake(self.view.width, 795);
    [self.view addSubview:myScrollView];
    [self createfirstView];
    [self createSecondView];
    [self createThreeView];
    [self createFourthView];
    [self createFifthView];
    
}

-(void)fabu
{
    
   
    
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
    label2.text = @"宣传图片(尺寸480*200,用于首页轮播)";
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
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 305, self.view.width, 260)];
    [myScrollView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    
    picScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, self.view.width, 85)];
    picScrollView.contentSize = CGSizeMake(self.view.width, 65);
    [view addSubview:picScrollView];
    
    NSArray * arr = @[@"一等奖",@"二等奖",@"三等奖"];
    for (int i = 0; i<3; i++) {
        UILabel  * label = [[UILabel alloc]initWithFrame:CGRectMake(15+75*i, 10, 60, 20)];
        label.text = arr[i];
        label.textAlignment = 1;
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:14];
        [view addSubview:label];
        
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(15+75*i, 20, 60, 60)];
        [btn setImage:[UIImage imageNamed:@"fabushangpin"] forState:0];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(selectPic:) forControlEvents:UIControlEventTouchUpInside];
        [picScrollView addSubview:btn];
    }
   
    UILabel  * label1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 105, 290, 20)];
    label1.text = @"活动产品(添加商品作为活动奖品)";
    label1.textColor = [UIColor grayColor];
    label1.font = [UIFont systemFontOfSize:14];
    [view addSubview:label1];
    
    UILabel  * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 135, 70, 20)];
    label.text = @"奖品人数";
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    UILabel *l1 =  [[UILabel alloc]initWithFrame:CGRectMake(90, 135, self.view.width-90, 20)];
    l1.text = @"一等奖      人  二等奖      人  三等奖      人";
    l1.textColor = [UIColor orangeColor];
    [view addSubview:l1];
    l1.font = [UIFont systemFontOfSize:12];
    l1.userInteractionEnabled = YES;
    
    for (int i  = 0; i<3; i++) {
        UITextField * textField1 = [[UITextField alloc]initWithFrame:CGRectMake(36+76*i, 0, 22, 20)];
        textField1.delegate = self;
        textField1.background = [UIImage imageNamed:@"输入01(1)"];
        [l1 addSubview:textField1];
    }
    
    UILabel  * label2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 165, 70, 20)];
    label2.text = @"活动奖品价";
    label2.font = [UIFont systemFontOfSize:14];
    [view addSubview:label2];
    
    UILabel *l2 =  [[UILabel alloc]initWithFrame:CGRectMake(90, 165, self.view.width-90, 20)];
    l2.text = @"原价的\t\t%";
    l2.textColor = [UIColor orangeColor];
    [view addSubview:l2];
    l2.font = [UIFont systemFontOfSize:12];
    l2.userInteractionEnabled = YES;
    
        UITextField * textField2 = [[UITextField alloc]initWithFrame:CGRectMake(38, 0, 46, 20)];
        textField2.delegate = self;
        textField2.background = [UIImage imageNamed:@"输入01(1)"];
        [l2 addSubview:textField2];
   

    UILabel  * label3 = [[UILabel alloc]initWithFrame:CGRectMake(15, 195, 70, 20)];
    label3.text = @"活动方式";
    label3.font = [UIFont systemFontOfSize:14];
    [view addSubview:label3];
    static int x = 0;
    NSArray * arr1 = @[@"现场抽奖",@"现场活动",@"摇一摇",@"刮刮乐",@"在线抽奖"];
    for (int j  = 0; j<2; j++) {
        for (int i = 0 ; i<3; i++) {
            if (j==1&&i==2) {
                return;
            }
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame =CGRectMake(90+(self.view.width-90)/3*i, 195+30*j,80 , 20);
            [btn setTitle:arr1[x] forState:0];
            [btn setTitleColor:[UIColor redColor] forState:0];
            [btn setImage:[UIImage imageNamed:@"不选择"] forState:0];
            [btn setImage:[UIImage imageNamed:@"选择(1)"] forState:UIControlStateSelected];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(2, 0, 2, 65)];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -65, 0, 0)];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            btn .tag = 100+x;
            [btn addTarget:self action:@selector(selectActiBtn:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn];
            x++;
            
        }
}

    
}
-(void)selectActiBtn:(UIButton *)sender
{
    if (sender.selected== NO) {
        sender.selected = YES;
    }
    else{
        sender.selected = NO;
    }
    
}
-(void)createFourthView
{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 575, self.view.width, 90)];
    [myScrollView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel  * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 70, 20)];
    label.text = @"活动时间";
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    UILabel  * label4 = [[UILabel alloc]initWithFrame:CGRectMake(85, 20, 70, 20)];
    label4.text = @"开始时间";
    label4.textColor = [UIColor orangeColor];
    label4.font = [UIFont systemFontOfSize:14];
    [view addSubview:label4];
    
    UILabel  * label5 = [[UILabel alloc]initWithFrame:CGRectMake(85, 50, 60, 20)];
    label5.text = @"结束时间";
    label5.textColor = [UIColor orangeColor];
    label5.font = [UIFont systemFontOfSize:14];
    [view addSubview:label5];
    
    UIImageView * imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(249, 20, 20, 20)];
    imgView1.image = [UIImage imageNamed:@"date_fbcx"];
    [view addSubview:imgView1];
    
    UIImageView * imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(249, 50, 20, 20)];
    imgView2.image = [UIImage imageNamed:@"date_fbcx"];
    [view addSubview:imgView2];
    
    
    UITextField  * textField1 = [[UITextField alloc]initWithFrame:CGRectMake(145, 20, 100, 20)];
    textField1.delegate = self;
    textField1.background = [UIImage imageNamed:@"输入02(1)"];
    textField1.font = [UIFont systemFontOfSize:14];
    [view addSubview:textField1];
    
    UITextField  * textField3 = [[UITextField alloc]initWithFrame:CGRectMake(145, 50, 100, 20)];
    textField3.delegate = self;
    textField3.background = [UIImage imageNamed:@"输入02(1)"];
    textField3.font = [UIFont systemFontOfSize:14];
    [view addSubview:textField3];
    
    
    
    
}

-(void)createFifthView
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 675, self.view.width, 120)];
    [myScrollView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel  * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 70, 20)];
    label.text = @"活动简介";
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
//
    UITextField  * textField1 = [[UITextField alloc]initWithFrame:CGRectMake(85, 10, self.view.width-95, 20)];
    textField1.delegate = self;
    textField1.placeholder = @"请输入本次活动的介绍";
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
        {
            UIButton * btn =    ((UIButton *)[picScrollView viewWithTag:picker.view.tag]);
            [btn setImage:image forState:0];
        }
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
