//
//  CorrectViewController.m
//  OuLianWang
//
//  Created by allenariel on 15/7/23.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "CorrectViewController.h"

@interface CorrectViewController ()<UITextFieldDelegate>

@end

@implementation CorrectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self create];
}
-(void)create
{
    self.view.backgroundColor=[UIColor whiteColor];
    UITextField *text=[[UITextField alloc]init];
    text.layer.borderWidth=0.3;
    if ([self.text isKindOfClass:[NSNull class]]) {
        text.text=@"";
    }
    else
        text.text=self.text;
    text.delegate=self;
    text.frame=CGRectMake(10, 84, 300, 40);
    [self.view addSubview:text];
    [text setEnabled:YES];
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
