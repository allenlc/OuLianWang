//
//  HotSellCell.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/15.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "HotSellCell.h"

#define margin 10
@implementation HotSellCell

+(instancetype)cellWithTableViewCell:(UITableView *)tableView
{
    static NSString * ID = @"ID";
    HotSellCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HotSellCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];//设置为黑色粗体
        
        //清除cell的颜色
//        self.backgroundColor = [UIColor clearColor];
//        self.backgroundView = [[UIImageView alloc]init];
//        self.selectedBackgroundView = [[UIImageView alloc]init];
//        self.selectionStyle = 0;
        
//        for (int i = 0; i<3; i++) {
//            UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(margin*2+((self.width-margin*6)/3+margin)*i, margin, (self.width-margin*6)/3, (self.width-margin*6)/3)];
//            imgView.backgroundColor = ZQRandomColor;
//            imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"n_%d.jpg",2*i+1]];
//            [self.contentView addSubview:imgView];
//            imgView.userInteractionEnabled=YES;
//            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)];
//            [imgView  addGestureRecognizer:tap];
//            
//            
//            UILabel * l = [[UILabel alloc]initWithFrame:CGRectMake(margin*2+((self.width-margin*6)/3+margin)*i, CGRectGetMaxY(imgView.frame), imgView.width, 20)];
//            l.text = @"沙发椅";
//            l.font = [UIFont systemFontOfSize:13];
//            [self.contentView addSubview:l];
//            UILabel * l1 = [[UILabel alloc]initWithFrame:CGRectMake(margin*2+((self.width-margin*6)/3+margin)*i, CGRectGetMaxY(l.frame), imgView.width, 20)];
//            [self.contentView addSubview:l1];
//            l1.text = @"2000/套";
//            l1.textColor = [UIColor redColor];
//            l1.font = [UIFont systemFontOfSize:12];
//            
//        }
        
    }
    return self;
}
-(void)setindexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        for (UIView *view in self.contentView.subviews) {
            [view removeFromSuperview];
        }
        
        NSLog(@"=======%@",self.imageviewsArray);
        
        NSMutableArray *  _viewsArray = [@[] mutableCopy];
       
        for (int i = 0; i < _imageviewsArray.count; ++i) {
            
            UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 120)];
            imgView.backgroundColor = [UIColor cyanColor];
            [imgView setImageWithURL:[NSURL URLWithString:_imageviewsArray[i]] placeholderImage:[UIImage imageNamed:@"congzhizhongxin_bd"]];
            [_viewsArray addObject:imgView];
        }
        self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 120) animationDuration:2];
        self.mainScorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
        self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
            
            return _viewsArray[pageIndex];
        };
        self.mainScorllView.totalPagesCount = ^NSInteger(void){
            return  _imageviewsArray.count;
            
        };
        self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
//            NSLog(@"点击了第%d个",pageIndex);
            
        };
        [self.contentView addSubview:self.mainScorllView];
    }
}
-(void)imageClick:(UITapGestureRecognizer *)tap
{
    self.imageBlock();
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
