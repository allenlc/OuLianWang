//
//  ThirdTableViewCell.m
//  OuLianWang
//
//  Created by hsmj on 15/6/18.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "ThirdTableViewCell.h"

@implementation ThirdTableViewCell
-(NSMutableArray *)allBtn
{
    if (_allBtn==nil) {
        _allBtn=[NSMutableArray array];
    }
    return _allBtn;
}
+(CGFloat )myHeight;
{
    return 30;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    NSArray * listArr = @[@"全部分类",@"销量排行",@"人气排行",@"评价最高"];
    
    for (int i = 0; i<4; i++) {
        UIButton * btn = [UIButton new];
        btn.frame = CGRectMake(self.width/4*i, 0, self.width/4, 30);
        [btn setTitle:listArr[i] forState:0];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setBackgroundImage:[UIImage imageNamed:@"paihangbeijing2"] forState:0];
        [btn setBackgroundImage:[UIImage imageNamed:@"wodedianpuxiala"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor whiteColor] forState:0];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.tag = 300+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        
    }
    self.currentBtn = (UIButton *)[self.contentView viewWithTag:300];
    self.currentBtn.selected = YES;

    
    
}
-(void)btnClick:(UIButton *)btn
{
       self.currentBtn.selected = NO;
        
        btn.selected = YES;
       self. currentBtn = btn;
        switch (btn.tag) {
            case 300:
            {
                self.myBlock1(btn);
            }
                break;
            case 301:
            {
                self.myBlock2(btn);
            }
                break;
            case 302:
            {
                 self.myBlock3(btn);
                btn.backgroundColor=[UIColor whiteColor];
            }
                break;
            case 303:
            {
                self.myBlock4(btn);
            }
                break;
                
            default:
                break;
        }
    

}
-(void)setFirstClick
{
    self.currentBtn.selected=NO;
    UIButton *bt=(UIButton *)[self.contentView viewWithTag:300];
    bt.selected=YES;
}
@end
