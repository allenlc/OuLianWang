//
//  NearTableViewCell.m
//  exex
//
//  Created by allenariel on 15/6/26.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "NearTableViewCell.h"
#import "SingleNearCity.h"
#import "UIView+LCView.h"
#import "ZJScreenAdaptation.h"

@implementation NearTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }
    return self;
}
-(void)createUIWith:(NSMutableArray *)dataArray
{

    self.backgroundColor=[UIColor colorWithRed:231/255.0 green:233/255.0 blue:234/255.0 alpha:1];
    
    self.titleLabel=[self.contentView addLabelWithFrame:CGRectMakeEx(10, 0, 150, 30) text:nil];
    _titleLabel.font=[UIFont systemFontOfSize:14];
    
    int xx=10,y=30;
    
    for (int i=0; i<dataArray.count; i++) {
        if (i%3==0&&i!=0) {
            xx=10;
            y+=40;
        }
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMakeEx(xx, y, 80, 30);
        xx+=95;
        btn.titleLabel.font=[UIFont systemFontOfSize:16];
        [btn setTitle:dataArray[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.layer.cornerRadius=7;
        btn.layer.borderWidth=0.2;
        [self.contentView addSubview:btn];
    }
    
}
@end
