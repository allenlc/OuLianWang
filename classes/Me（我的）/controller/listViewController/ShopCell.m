//
//  ShopCell.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/24.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "ShopCell.h"

@implementation ShopCell

+(instancetype)cellWithTableViewCell:(UITableView *)tableView
{
    static NSString * ID = @"ID";
    ShopCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[ShopCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        
    }
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont boldSystemFontOfSize:14];//设置为黑色粗体
        //        //清除cell的颜色
                self.backgroundColor = [UIColor whiteColor];
                self.backgroundView = [[UIImageView alloc]init];
                self.selectedBackgroundView = [[UIImageView alloc]init];
        
        self.selectionStyle = 0;
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame =  CGRectMake(0, 0, 20, 20);
        btn.center = CGPointMake(17.5, 40);
        [btn setImage:[UIImage imageNamed:@"noselect_gwc"] forState:0];
        [btn setImage:[UIImage imageNamed:@"select_gwc"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(selectCell:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        self.selectBtn = btn;

        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(35, 10, 60, 60)];
        [self.contentView addSubview:imgView];
        self.iconImg = imgView;
        
        UILabel * mainLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 5, self.width-160, 40 )];
        mainLabel.numberOfLines = 0;
        mainLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:mainLabel];
        self.titleLabel= mainLabel;
        
        UIButton * delectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [delectBtn setTitle:@"删除" forState:0];
        [delectBtn setTitleColor:[UIColor whiteColor] forState:0];
        delectBtn.backgroundColor = [UIColor redColor];
        delectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        delectBtn.frame = CGRectMake(self.width-52, 10, 40, 25);
        delectBtn.layer.cornerRadius = 5;
        [delectBtn addTarget:self action:@selector(removeCell) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:delectBtn];
        
        UILabel * subLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 60, 90, 15)];
//        subLabel.text = @"颜色分类:乳白色";
        subLabel.textColor = [UIColor grayColor];
        subLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:subLabel ];
        self.shuxinLabel = subLabel;
        
       self.accountLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 40, 80, 20)];
//        self.accountLabel.text = @"￥3999.00";
        self.accountLabel.textColor = [UIColor redColor];
        self.accountLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.accountLabel ];
        
        
        UIImageView * lineImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 79, self.width, 1)];
        lineImgView.backgroundColor =  ZQColor(214, 214, 214);
        [self.contentView addSubview:lineImgView];
        
        [self createNumberBtn];
        
    }
    return self;
}
//-(void)down
//{
//    
//}
-(void)createNumberBtn
{ 
    UIImageView * editNumberView = [[UIImageView alloc]initWithFrame:CGRectMake(self.width-100, 43, 90, 30)];
    editNumberView.userInteractionEnabled = YES;
    editNumberView.image = [UIImage imageNamed:@"quantity"];
    [self.contentView addSubview:editNumberView];
    
    for (int i = 0; i<2; i++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(60*i, 0, 30, 30)];
        btn.tag = 300+i;
        [btn addTarget:self action:@selector(editNumber:) forControlEvents:UIControlEventTouchUpInside];
        [editNumberView addSubview:btn];
    }
    self.numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 30, 30)];
    self.numberLabel.textAlignment = 1;
    
    [editNumberView addSubview:self.numberLabel];
}

-(void)editNumber:(UIButton *)sender
{
    int x = [self.numberLabel.text intValue];
    switch (sender.tag) {
        case 300:
        {
            if (x!=1) {
//                if (self.selectBtn.selected == YES) {
                    self.editBlock(sender.tag);
//                }
                  x--;
            }
        }
            break;
        case 301:
        {
//            if (self.selectBtn.selected == YES) {
            
                self.editBlock(sender.tag);
                
//            }
            x++;
        }
            break;
            
        default:
            break;
    }
    _item.number = [NSString stringWithFormat:@"%d",x];
    self.numberLabel.text = _item.number;
   
    
}

-(void)removeCell
{
    self.removeBlock(self);
}
-(void)selectCell:(UIButton *)sender
{
    
    
    if (_item.isSelect ==NO) {
        _item.isSelect = YES;
    }
    else{
        _item.isSelect = NO;
    }
    sender.selected = _item.isSelect;
    self.accountBlock(sender);
    
}
-(void)setItem:(ShopCartItem *)item
{
    _item = item;
    NSLog(@"%@",item.number);
    self.numberLabel.text = item.number;
    self.titleLabel.text = item.gname;
    self.accountLabel.text =[NSString stringWithFormat:@"￥%@", item.price];
    self.shuxinLabel.text = item.goods_attr;
    self.selectBtn.selected = _item.isSelect;
    [self.iconImg setImageWithURL:[NSURL URLWithString:_item.goods_img] placeholderImage:DEFAULTIMG];
}

-(void)setindexPath:(NSIndexPath *)indexPath rowInSecton:(int)rows
{

    
}

@end
