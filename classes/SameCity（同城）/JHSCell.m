//
//  JHSCell.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/27.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "JHSCell.h"
#define margin 5
@implementation JHSCell

+(instancetype)cellWithTableViewCell:(UITableView *)tableView
{
    static NSString * ID = @"ID";
    JHSCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JHSCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];//设置为黑色粗体
        
        //清除cell的颜色
        self.backgroundColor = [UIColor clearColor];
        UIImageView * bgImgView = [[UIImageView alloc]init];
        self.backgroundView =bgImgView;
        self.selectedBackgroundView = [[UIImageView alloc]init];
        self.selectionStyle = 0;
        
//        self.backgroundColor = ZQColor(228, 228, 228);
        
    }
    return self;
}


-(void)setindexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        for (UIView *view in self.contentView.subviews) {
            [view removeFromSuperview];
        }
        
//        self.backgroundColor = ZQColor(228, 228, 228);
        
        NSMutableArray *viewsArray = [@[] mutableCopy];
       // NSArray *colorArray = @[[UIColor cyanColor],[UIColor blueColor],[UIColor greenColor],[UIColor yellowColor],[UIColor purpleColor]];
        for (int i = 0; i < _dataimageArray.count; ++i)
        {
            
            UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 120)];
            //imgView.backgroundColor = [UIColor cyanColor];
            [imgView  setImageWithURL:[NSURL  URLWithString:_dataimageArray[i]]];
            [viewsArray addObject:imgView];
        }
        self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 120) animationDuration:2];
        self.mainScorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
        self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
            return viewsArray[pageIndex];
        };
        self.mainScorllView.totalPagesCount = ^NSInteger(void){
            return  _dataimageArray.count;
        };
        self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
            //            NSLog(@"点击了第%d个",pageIndex);
        };
        [self.contentView addSubview:self.mainScorllView];
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 120,320, 40)];
        view.backgroundColor = [UIColor whiteColor  ];
        [self.contentView addSubview:view];
        
        UIImageView  * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 10, 20)];
        imgView.backgroundColor = ZQColor(201, 0, 9);
        [view addSubview:imgView];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10,5 , 80, 30)];
        label.text = @"今日巨划算";
        label.font = [UIFont boldSystemFontOfSize:15];
        label.textColor = [UIColor blackColor];
        [view addSubview:label];
        
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(90, 5, 100, 30   )];
        label1.font = [UIFont systemFontOfSize:11];
        label1.textColor = [UIColor grayColor];
        label1.text = @"每日10：10上新";
        [view addSubview:label1];
        
    }
    
    if (indexPath.section == 1)
    {
        for (UIView *view in self.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, margin)];
        _imgView.backgroundColor = ZQColor(232, 232, 232);
        [self.contentView addSubview:_imgView];
        
        _imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.width/2-margin/2, 0, margin, 240)];
        _imgView1.backgroundColor = ZQColor(232, 232, 232);
        [self.contentView addSubview:_imgView1];
        
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, margin, self.width/2-margin/2, self.height)];
        [self.contentView addSubview:view];
        view.backgroundColor = [UIColor whiteColor];
        [self creatShopViewWithView1 :_model1 andView:view];

        
        UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(self.width/2+margin/2, margin, self.width/2-margin/2, self.height)];
        [self.contentView addSubview:view1];
        view1.backgroundColor = [UIColor whiteColor];
        [self creatShopViewWithView2 :_model2 andView:view1];
  
    }
    
   
    
}

-(void)creatShopViewWithView1:(JHSModel *)model andView:(UIView *)aView
{
    _model1=model;
    _imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, aView.width, aView.width)];
    [_imgView2 setImageWithURL:[NSURL URLWithString:_model1.goods_img] placeholderImage:[UIImage imageNamed:@"shafa1"]];
    [aView  addSubview:_imgView2];
    
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(5, aView.width, aView.width-5, 40 )];
    _label1.text = _model1.goodsname;
    _label1.numberOfLines = 0;
    _label1.font = [UIFont systemFontOfSize:13];
    [aView addSubview:_label1];
    
    _label2 = [[UILabel alloc]initWithFrame:CGRectMake(8, (aView.width)+45, _label1.width/2, 10)];
    _label2.font = [UIFont systemFontOfSize:12];
    _label2.textColor = [UIColor grayColor];
    [aView addSubview:_label2];
    _oldPrice = _model1.price;
    NSUInteger length = [_oldPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:_oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(2, length-2)];
    [_label2 setAttributedText:attri];
    
    _label3 = [[UILabel alloc]initWithFrame:CGRectMake(_label1.width/2-10, (aView.width)+45, _label1.width/2, 10)];
    _label3.font = [UIFont systemFontOfSize:12];
    _label3.text=[NSString stringWithFormat:@"已售 %@",_model1.gid];
    //NSLog(@"、、、、、、、、、%@",_label3.text);
    
    _label3.textAlignment=2;
    _label3.textColor = [UIColor grayColor];
    [aView addSubview:_label3];
    
    _label4 = [[UILabel alloc]initWithFrame:CGRectMake(5, (aView.width-margin/2)+58, _label1.width/2, 20)];
    _label4.font = [UIFont systemFontOfSize:14];
    _label4.text=[NSString stringWithFormat:@"￥ %@",_model1.price];
    _label4.textColor = [UIColor redColor];
    [aView addSubview:_label4];
    
    _label5 = [[UILabel alloc]initWithFrame:CGRectMake(_label1.width/2-10, (aView.width)+58, _label1.width/2, 20)];
    _label5.font = [UIFont systemFontOfSize:12];
    _label5.textAlignment = 2;
    NSString *string=[NSString  stringWithFormat:@"%d",_model2.kilometer.integerValue/100];
    _label5.text= [NSString stringWithFormat:@"%@ Km",string];
    _label5.textColor = [UIColor grayColor];
    [aView addSubview:_label5];
}


-(void)creatShopViewWithView2:(JHSModel *)model andView:(UIView *)aView
{
    _model2=model;
    _imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, aView.width, aView.width)];
    [_imgView2 setImageWithURL:[NSURL URLWithString:_model2.goods_img] placeholderImage:[UIImage imageNamed:@"shafa1"]];
    [aView  addSubview:_imgView2];
    
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(8, aView.width, aView.width-5, 40 )];
    _label1.text = _model2.goodsname;
    _label1.numberOfLines = 0;
    _label1.font = [UIFont systemFontOfSize:13];
    [aView addSubview:_label1];
    
    _label2 = [[UILabel alloc]initWithFrame:CGRectMake(5, (aView.width)+45, _label1.width/2, 10)];
    _label2.font = [UIFont systemFontOfSize:12];
    _label2.textColor = [UIColor grayColor];
    [aView addSubview:_label2];
    
    _oldPrice = _model2.price;
    NSUInteger length = [_oldPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:_oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(2, length-2)];
    [_label2 setAttributedText:attri];
    
    _label3 = [[UILabel alloc]initWithFrame:CGRectMake(_label1.width/2-10, (aView.width)+45, _label1.width/2, 10)];
    _label3.font = [UIFont systemFontOfSize:12];
      _label3.text=[NSString stringWithFormat:@"已售 %@",_model2.gid];
    _label3.textAlignment=2;
    _label3.textColor = [UIColor grayColor];
    [aView addSubview:_label3];
    
    _label4 = [[UILabel alloc]initWithFrame:CGRectMake(5, (aView.width-margin/2)+58, _label1.width/2, 20)];
    _label4.font = [UIFont systemFontOfSize:14];
     _label4.text=[NSString stringWithFormat:@"￥ %@",_model1.price];
    _label4.textColor = [UIColor redColor];
    [aView addSubview:_label4];
    
    _label5 = [[UILabel alloc]initWithFrame:CGRectMake(_label1.width/2-10, (aView.width)+58, _label1.width/2, 20)];
    _label5.font = [UIFont systemFontOfSize:12];
    _label5.textAlignment = 2;
    NSString *string=[NSString  stringWithFormat:@"%d",_model2.kilometer.integerValue/100];
    _label5.text= [NSString stringWithFormat:@"%@ Km",string];
    _label5.textColor = [UIColor grayColor];
    [aView addSubview:_label5];
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
