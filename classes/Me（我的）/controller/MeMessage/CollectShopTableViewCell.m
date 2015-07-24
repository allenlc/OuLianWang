//
//  CollectShopTableViewCell.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/2.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "CollectShopTableViewCell.h"
#import "StarView.h"

@implementation CollectShopTableViewCell


+(instancetype)cellWithTableViewCell:(UITableView *)tableView
{
    static NSString * ID = @"ID";
    CollectShopTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CollectShopTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    
    
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];//设置为黑色粗体
        
        //清除cell的颜色
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = [[UIImageView alloc]init];
        self.selectedBackgroundView = [[UIImageView alloc]init];
        self.selectionStyle = 0;
        [self creatheaderView];
        
    }
    return self;
}
-(void)setindexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark--------创建顶部视图
-(void)creatheaderView
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView  addSubview:view];
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 70, 70)];
    imageview.image=[UIImage  imageNamed:@"dianpu"];
    [view  addSubview:imageview];
    
    UILabel *olabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 5, 120, 20)];
    olabel.text=@"保定电谷家居广场";
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
    JTBtn.frame = CGRectMake(self.width-50, 25, 30, 30);
    [JTBtn addTarget:self action:@selector(enterDetail) forControlEvents:UIControlEventTouchUpInside];
    [JTBtn setImage:[UIImage  imageNamed:@"jr"] forState:0];
    [view addSubview:JTBtn];
    
    
}
-(void)enterDetail
{
    
}

@end
