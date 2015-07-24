//
//  HomeShopCell.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/29.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "HomeShopCell.h"
#import "StarView.h"
#import "HomeModel.h"
#import "HomeShopModel.h"

#define margin 5
@implementation HomeShopCell


+(instancetype)cellWithTableViewCell:(UITableView *)tableView
{
    static NSString * ID = @"IDhomeshop";
    HomeShopCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HomeShopCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
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
        [self creatheaderView];
        
        [self creatCycleScrollerView];
        
    }
    
    if (indexPath.section == 1) {
        for (UIView *view in self.contentView.subviews) {
            [view removeFromSuperview];
        }
        
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, margin)];
        imgView.backgroundColor = ZQColor(232, 232, 232);
        [self.contentView addSubview:imgView];
        
        UIImageView * imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.width/2-margin/2, 0, margin, 240)];
        imgView1.backgroundColor = ZQColor(232, 232, 232);
        [self.contentView addSubview:imgView1];
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, margin, self.width/2-margin/2, self.height)];
        [self.contentView addSubview:view];
        view.backgroundColor = [UIColor whiteColor];
        [self creatShopViewWithView:view withModel:self.model1];
        
        UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(self.width/2+margin/2, margin, self.width/2-margin/2, self.height)];
        [self.contentView addSubview:view1];
        view1.backgroundColor = [UIColor whiteColor];
        [self creatShopViewWithView:view1 withModel:self.model2];
        
    }
    
}

#pragma mark --创建轮播视图
-(void)creatCycleScrollerView
{
    NSMutableArray *viewsArray = [@[] mutableCopy];

    for (int i = 0; i < 5; ++i) {
        
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 80, self.width, 100)];
        imgView.backgroundColor = [UIColor cyanColor];
        imgView.image = [UIImage imageNamed:@"dianpulunbotu"];
        [viewsArray addObject:imgView];
    }
    self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 80, self.width, 100) animationDuration:2];
    self.mainScorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
    self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewsArray[pageIndex];
    };
    self.mainScorllView.totalPagesCount = ^NSInteger(void){
        return 5;
    };
    self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
        //NSLog(@"点击了第%d个",pageIndex);
    };
    [self.contentView addSubview:self.mainScorllView];
    
}

-(void)creatShopViewWithView:(UIView *)aView withModel:(HomeShopModel *)model
{

    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, aView.width, aView.width)];
    
    [imgView setImageWithURL:[NSURL URLWithString:model.goods_img] placeholderImage:DEFAULTIMG];
    
   

    [aView addSubview:imgView];
    
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, aView.width, aView.width, 40 )];
    if (model.goodsname==nil) {
        label1.text = @"床头柜地中海床头柜佛山厂家象牙白实木";
    }
    else
        label1.text = model.goodsname;

    label1.numberOfLines = 0;
    label1.font = [UIFont systemFontOfSize:13];
    [aView addSubview:label1];
    
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, (aView.width)+45, label1.width/2, 10)];
    label2.font = [UIFont systemFontOfSize:12];
    label2.textColor = [UIColor grayColor];
    [aView addSubview:label2];
    
    NSString *oldPrice ;
    if (model.pfprice==nil) {
        oldPrice = @"¥12345";
    }
    else
        oldPrice=model.pfprice;

    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(2, length-2)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(2, length-2)];
    [label2 setAttributedText:attri];
    
    UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(label1.width/2, (aView.width)+55, label1.width/2, 10)];
    label3.font = [UIFont systemFontOfSize:12];
    if (model.sales==nil) {
        label3.text = @"122";
    }
    else
        label3.text=model.sales;
    label3.text= @"已售 143";
    label3.textAlignment= 2;
    label3.textColor = [UIColor grayColor];
    [aView addSubview:label3];
    
    UILabel * label4 = [[UILabel alloc]initWithFrame:CGRectMake(0, (aView.width-margin/2)+55, label1.width/2, 20)];
    label4.font = [UIFont systemFontOfSize:14];
    if (model.price==nil) {
        label4.text = @"¥1000";
    }
    else
        label4.text=[NSString stringWithFormat:@"¥%@", model.price];
    label4.textColor = [UIColor redColor];
    [aView addSubview:label4];
    

    
}

#pragma mark--------创建顶部视图
-(void)creatheaderView
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView  addSubview:view];
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 70, 70)];

    if (self.homeModel.logo==nil) {
        imageview.image=[UIImage  imageNamed:@"dianpu"];
    }
    else
        [imageview setImageWithURL:[NSURL URLWithString:_homeModel.logo] placeholderImage:DEFAULTIMG];
    
    [view  addSubview:imageview];
    
    UILabel *olabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 5, 120, 20)];
    if (self.homeModel.storename==nil) {
         olabel.text=@"豪瑟家具";
    }
    else
        olabel.text=_homeModel.storename;
    
    olabel.font=[UIFont systemFontOfSize:14];
    [view  addSubview:olabel];
    
    UILabel *tlabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 25, 90, 20)];
    tlabel.text=@"营业执照已认证";
    tlabel.textColor=[UIColor grayColor];
    tlabel.font=[UIFont systemFontOfSize:12];
    [view  addSubview:tlabel];
    
    UILabel *thlabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 45, 90, 10)];
    thlabel.text=@"2015-06-13";
    thlabel.textAlignment=1;
    thlabel.textColor=[UIColor grayColor];
    thlabel.font=[UIFont systemFontOfSize:10];
    [view  addSubview:thlabel];
    
    UIImageView *dianhuaimageview=[[UIImageView alloc]initWithFrame:CGRectMake(180, 32.5, 30, 20)];
    dianhuaimageview.image=[UIImage  imageNamed:@"rz.png"];
    [view  addSubview:dianhuaimageview];
    
    UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(90, 55, 30, 20) ];
    lab2.text = @"好评:";
    lab2.textColor = [UIColor grayColor];
    lab2.font=[UIFont systemFontOfSize:12];
    [view addSubview:lab2];
    
    
    StarView * startView = [[StarView alloc]initWithFrame:CGRectMake(120, 55, 80, 20)];
    [startView setStar:4.5 ];
    [view addSubview:startView ];
    
    UIButton * JTBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    JTBtn.frame = CGRectMake(self.width-40, 30, 20, 20);
    [JTBtn addTarget:self action:@selector(enterDetail) forControlEvents:UIControlEventTouchUpInside];
    [JTBtn setImage:[UIImage  imageNamed:@"dt"] forState:0];
    [view addSubview:JTBtn];
    
    UIButton *daohangBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    daohangBtn.frame=CGRectMake(view.width-60, view.height-60, 25, 25);
    [daohangBtn setBackgroundImage:[UIImage imageNamed:@"dtjjdp.png"] forState:UIControlStateNormal];
    [daohangBtn addTarget:self action:@selector(daohang) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:daohangBtn];
    
    UILabel *howlong=[[UILabel alloc]initWithFrame:CGRectMake(view.width-87, view.height-30, 80, 20)];
    howlong.textAlignment=NSTextAlignmentCenter;
    howlong.textColor=[UIColor grayColor];
    howlong.font=[UIFont systemFontOfSize:12];
    if ([self.meter floatValue]<1000) {
        
        howlong.text=[NSString stringWithFormat:@"%@ m",self.meter];
    }
    else{
        howlong.text=[NSString stringWithFormat:@"%.2f km",[self.meter floatValue]/1000];

    }
    [view addSubview:howlong];
//    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame)+5, self.width, 40)];
//    view1.backgroundColor = [UIColor yellowColor];
//    [self.contentView addSubview:view1];
//    
}

#pragma mark -进入店铺详情
-(void)enterDetail
{
    self.enterDetailBlock();
    
}
-(void)imageClick:(UITapGestureRecognizer *)tap
{
    self.imageBlock();
}


- (void)awakeFromNib {
    // Initialization code
}
-(void)daohang
{
    
    
    
    self.daoHangBlock(self.homeModel);
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



@end
