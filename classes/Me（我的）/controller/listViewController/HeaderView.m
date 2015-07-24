//
//  HeaderView.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/23.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        NSArray * listArr = @[@"全部分类",@"销量排行",@"人气排行",@"评价最高"];
        
        for (int i = 0; i<4; i++) {
            UIButton * btn = [UIButton new];
            btn.frame = CGRectMake(self.width/4*i, 0, self.width/4, self.height);
            [btn setTitle:listArr[i] forState:0];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setBackgroundImage:[UIImage imageNamed:@"paihangbeijing2"] forState:0];
            [btn setBackgroundImage:[UIImage imageNamed:@"wodedianpuxiala"] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor whiteColor] forState:0];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            btn.tag = 300+i;
            [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
        self.btn = (UIButton *)[self viewWithTag:300];
//        [self selectBtn:self.btn];
        self.btn.selected = YES;

    }
    return self;
}
+ (HeaderView *)sharedManagerWithFrame:(CGRect )frame
{
    
    static HeaderView *headerView = nil;
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        headerView = [[self alloc] initWithFrame:frame];
        
       
    });
    return headerView;
}
-(void)selectBtn:(UIButton *)btn
{
    
    if ([self.btn isEqual:btn]) {
        if (btn.tag == 300) {
            NSLog(@"应该弹出下拉窗口");
        }
        return;
    }
    self.btn.selected = NO;
    btn.selected = YES;
    self.btn = btn;
    if ([self.delegate respondsToSelector:@selector(btnSelect:andBtn:)]) {
         [self.delegate btnSelect:self andBtn:btn];
    }
   
}
@end
