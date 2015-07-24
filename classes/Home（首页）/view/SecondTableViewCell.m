//
//  SecondTableViewCell.m
//  OuLianWang
//
//  Created by hsmj on 15/6/18.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "SecondTableViewCell.h"
#import "UIView+LCView.h"
#import "CycleScrollView.h"
#import "XunHGdModel.h"

@implementation SecondTableViewCell
+(CGFloat)myHeight
{
    return 120;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }
    return self;
}
-(void)createUI:(int )imgCount andImgStrings:(NSArray *)imgStrings
{
    //大图
//    self.bigImageView=[self.contentView addImageViewWithFrame:CGRectMake(0, 0, 320, 120) image:nil];
    
    
    NSLog(@"%d",imgCount);

    

    
}
-(void)setImagearray:(NSMutableArray *)imagearray
{

    viewsArray = [@[] mutableCopy];
    for (int i = 0; i < imagearray.count; ++i)
        {
            XunHGdModel *mm=imagearray[i];
            
            cycleImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 120)];
            cycleImgView.backgroundColor = [UIColor cyanColor];
            [cycleImgView setImageWithURL:[NSURL URLWithString:mm.prom_img] placeholderImage:[UIImage imageNamed:@"cysleIcon"]];
            
            [viewsArray addObject:cycleImgView];
        }
        self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 120) animationDuration:2];
        self.mainScorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
        self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
            return viewsArray[pageIndex];
        };
        self.mainScorllView.totalPagesCount = ^NSInteger(void){
            return imagearray.count;
        };
        self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
            //NSLog(@"点击了第%d个",pageIndex);
        };
        [self.contentView addSubview:self.mainScorllView];


    
}

@end
