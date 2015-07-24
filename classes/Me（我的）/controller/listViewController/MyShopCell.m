//
//  MyShopCell.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/27.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "MyShopCell.h"
#import "StarView.h"
#import "ShopDetailCell.h"
#import "UIKit+AFNetworking.h"

#define margin 5
@implementation MyShopCell
-(NSMutableArray *)cyclePics
{
    if (_cyclePics == nil) {
        _cyclePics = [NSMutableArray array];
        
    }
    return _cyclePics;
}
+(instancetype)cellWithTableViewCell:(UITableView *)tableView
{
    static NSString * ID = @"ID";
    MyShopCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MyShopCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
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
        
    }
    return self;
}
-(void)setindexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        for (UIView *view in self.contentView.subviews) {
            [view removeFromSuperview];
        }
         [self creatheaderView];
        
//        [self creatCycleScrollerView];
        
    }
    
    if (indexPath.section == 1) {
        for (UIView *view in self.contentView.subviews) {
            [view removeFromSuperview];
        }
        
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, margin)];
        imgView.backgroundColor = ZQColor(232, 232, 232);
        imgView.userInteractionEnabled = YES;
        [self.contentView addSubview:imgView];
        
        UIImageView * imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.width/2-margin/2, 0, margin, 240)];
        imgView1.backgroundColor = ZQColor(232, 232, 232);
        [self.contentView addSubview:imgView1];
        
         leftview = [[UIView alloc]initWithFrame:CGRectMake(0, margin, self.width/2-margin/2, 235)];
        leftview.tag =300;
        [self.contentView addSubview:leftview];
        leftview.backgroundColor = [UIColor whiteColor];
        [self creatShopViewWithView:leftview];
        
        UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(self.width/2+margin/2, margin, self.width/2-margin/2, 235)];
        view1.tag = 400;
        [self.contentView addSubview:view1];
        view1.backgroundColor = [UIColor whiteColor];
        [self creatShopViewWithView:view1];
        
    }
    
}
#pragma mark -进去商品详情
-(void)imageClick:(UITapGestureRecognizer *)tapGest
{
    self.imageBlock();
}
#pragma mark --创建轮播视图
-(void)creatCycleScrollerViewForCount:(int )cycleCount
{
    NSMutableArray *viewsArray = [@[] mutableCopy];

    for (int i = 0; i < cycleCount; ++i) {
        
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, self.width, 100)];
        imgView.backgroundColor = [UIColor cyanColor];
        imgView.image = [UIImage imageNamed:@"dianpulunbotu"];
        
        [imgView setImageWithURL:[NSURL URLWithString:self.cyclePics[i]] placeholderImage:[UIImage imageNamed:@"dianpulunbotu"]];
        [viewsArray addObject:imgView];
    }
    self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 100, self.width, 100) animationDuration:2];
    self.mainScorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
    self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return  viewsArray[pageIndex];
    };
    self.mainScorllView.totalPagesCount = ^NSInteger(void){
        return cycleCount;
    };
    self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
                    NSLog(@"点击了第%d个",pageIndex);
    };
    [self.contentView addSubview:self.mainScorllView];

}

-(void)creatShopViewWithView:(UIView *)aView
{
    
    UIImageView * imgView11 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, aView.width, aView.width)];

    imgView11.tag =aView.tag+9;
    [aView addSubview:imgView11];
//    self.goodsImgView = imageview;
    
    imgView11.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)];
    [imgView11  addGestureRecognizer:tap];
    
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, aView.width, aView.width, 40 )];
//    label1.text = @"床头柜地中海床头柜佛山厂家象牙白实木";
    label1.numberOfLines = 0;
    label1.font = [UIFont systemFontOfSize:13];
    [aView addSubview:label1];
    label1.tag = aView .tag +2;
//    self.goodsNameLabel = label1;
    
    
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, (aView.width)+45, label1.width/2, 10)];
    label2.font = [UIFont systemFontOfSize:12];
    label2.textColor = [UIColor grayColor];
    [aView addSubview:label2];
    label2.tag = aView.tag +3;
    
    
    UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(label1.width/2, (aView.width)+55, label1.width/2, 20)];
    label3.font = [UIFont systemFontOfSize:12];
//    label3.text= @"已售 143";
    label3.textAlignment= 2;
    label3.textColor = [UIColor grayColor];
    [aView addSubview:label3];
    label3.tag = aView.tag + 4;
//    self.hasSales = label3;
    
    UILabel * label4 = [[UILabel alloc]initWithFrame:CGRectMake(0, (aView.width-margin/2)+55, label1.width/2, 20)];
    label4.font = [UIFont systemFontOfSize:14];
//    label4.text= @"¥10000";
    label4.textColor = [UIColor redColor];
    [aView addSubview:label4];
    label4.tag = aView.tag +5;
//    self.goodsPrice = label4;
    
    
}

#pragma mark--------创建顶部视图
-(void)creatheaderView
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView  addSubview:view];
    
    imageview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 70, 70)];
    [view  addSubview:imageview];
    
    olabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 15, 120, 20)];
    olabel.font=[UIFont systemFontOfSize:14];
    [view  addSubview:olabel];
    
    UILabel *tlabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 35, 90, 20)];
    tlabel.text=@"营业执照已认证";
    tlabel.textColor=[UIColor grayColor];
    tlabel.font=[UIFont systemFontOfSize:12];
    [view  addSubview:tlabel];
    
    UILabel *thlabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 55, 90, 10)];
    thlabel.tag = 500;
    thlabel.textAlignment=1;
    thlabel.textColor=[UIColor grayColor];
    thlabel.font=[UIFont systemFontOfSize:10];
    [view  addSubview:thlabel];
    
    UIImageView *dianhuaimageview=[[UIImageView alloc]initWithFrame:CGRectMake(180, 42.5, 30, 20)];
    dianhuaimageview.image=[UIImage  imageNamed:@"rz.png"];
    [view  addSubview:dianhuaimageview];
    
    UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(90, 65, 30, 20) ];
    lab2.text = @"好评:";
    lab2.textColor = [UIColor grayColor];
    lab2.font=[UIFont systemFontOfSize:12];
    [view addSubview:lab2];
    
    
    startView = [[StarView alloc]initWithFrame:CGRectMake(120, 65, 80, 20)];
    [view addSubview:startView ];
    
    UIButton * JTBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    JTBtn.frame = CGRectMake(self.width-40, 35, 30, 30);
    [JTBtn addTarget:self action:@selector(enterDetail) forControlEvents:UIControlEventTouchUpInside];
    [JTBtn setImage:[UIImage  imageNamed:@"jr"] forState:0];
    [view addSubview:JTBtn];
    
    
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame)+15, self.width, 40)];
    view1.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view1];
    
    }

#pragma mark -进入店铺详情
-(void)enterDetail
{
    self.enterDetailBlock();
    
}

-(void)setWddpModel:(WDDPModel *)wddpModel{
    _wddpModel = wddpModel;
    
    
    NSLog(@"cyclepic = %@",self.cyclePics);
    UILabel * label = (UILabel *)[self viewWithTag:500];
    NSString * a = self.wddpModel.operatime;
    label.text = a;
    
    [imageview setImageWithURL:[NSURL URLWithString:_wddpModel.logo] placeholderImage:[UIImage  imageNamed:@"dianpu"]];
    olabel.text = _wddpModel.storename;
    [startView setStar:[_wddpModel.goodrate floatValue]/20];

    for (int i = 0; i<wddpModel.ad_list.count; i++) {
        NSString * url = [wddpModel.ad_list[i] objectForKey:@"adimg"];
        [self.cyclePics addObject:url];
    }
       NSLog(@"----%@",self.cyclePics);
    static int  count =0;
    if (self.cyclePics.count==0&&_wddpModel) {
        
        count = 1;
    }
    else{
        count = self.cyclePics.count;
    }
    [self creatCycleScrollerViewForCount:count];

}

   





-(void)setGoodsModel1:(WDDPGoodsModel *)goodsModel1
{
    
    _goodsModel1 = goodsModel1;
    self.goodsNameLabel = (UILabel *)[leftview viewWithTag:302];
        self.goodsNameLabel.text= goodsModel1.goodsname;
    self.goodsImgView = (UIImageView *)[leftview viewWithTag:309];
    
    NSString * shopImgUrl = nil;
    if (![goodsModel1.goods_img isKindOfClass:[NSNull class ]]) {
        shopImgUrl = goodsModel1.goods_img;
    }
    
    [self.goodsImgView setImageWithURL:[NSURL URLWithString:shopImgUrl] placeholderImage:DEFAULTIMG];
    
    self.goodsPrice = (UILabel *)[self viewWithTag:305];
    self.goodsPrice.text=[NSString stringWithFormat:@"￥%@", goodsModel1.price];
    
    self.goodsOriginPrice = (UILabel *)[self viewWithTag:303];
    self.goodsOriginPrice.text= goodsModel1.price;
    NSString *oldPrice = [NSString stringWithFormat:@"￥%.2f",[goodsModel1.price floatValue]/0.8];
    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
    [self.goodsOriginPrice setAttributedText:attri];
    
    self.hasSales = (UILabel *)[self viewWithTag:304];
    self.hasSales.text=[NSString stringWithFormat:@"已售%@", goodsModel1.sales];


   
    
}
-(void)setGoodsModel2:(WDDPGoodsModel *)goodsModel2{
    _goodsModel2 = goodsModel2;
    self.goodsNameLabel = (UILabel *)[self viewWithTag:402];
    self.goodsNameLabel.text= goodsModel2.goodsname;
    
    self.goodsImgView = (UIImageView *)[self viewWithTag:409];
    NSString * shopImgUrl = nil;
    if (![goodsModel2.goods_img isKindOfClass:[NSNull class ]]) {
        shopImgUrl = goodsModel2.goods_img;
    }
    
    [self.goodsImgView setImageWithURL:[NSURL URLWithString:shopImgUrl] placeholderImage:DEFAULTIMG];
    
    self.goodsPrice = (UILabel *)[self viewWithTag:405];
    self.goodsPrice.text=[NSString stringWithFormat:@"￥%@", goodsModel2.price];
    
    self.goodsOriginPrice = (UILabel *)[self viewWithTag:403];
    self.goodsOriginPrice.text= goodsModel2.price;
    NSString *oldPrice = [NSString stringWithFormat:@"￥%.2f",[goodsModel2.price floatValue]/0.8];
    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
    [self.goodsOriginPrice setAttributedText:attri];
    
    self.hasSales = (UILabel *)[self viewWithTag:404];
    self.hasSales.text=[NSString stringWithFormat:@"已售%@", goodsModel2.sales];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
