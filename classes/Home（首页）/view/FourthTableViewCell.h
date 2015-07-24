//
//  FourthTableViewCell.h
//  OuLianWang
//
//  Created by allenariel on 15/6/19.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FourthTableViewCell : UITableViewCell
+(NSString *)myIdentify;
+(CGFloat)myHeight;
//图片
@property(nonatomic,strong)UIImageView *lookImageView1;
@property(nonatomic,strong)UIImageView *lookImageView2;

//名字
@property(nonatomic,strong)UILabel *nameLabel1;
@property(nonatomic,strong)UILabel *nameLabel2;

//价钱
@property(nonatomic,strong)UILabel *priceLabel1;
@property(nonatomic,strong)UILabel *priceLabel2;

//销量
@property(nonatomic,strong)UILabel *coatLabel1;
@property(nonatomic,strong)UILabel *coatLabel2;

@property(nonatomic,copy)void(^tapBlock1)(void);
@property(nonatomic,copy)void(^tapBlock2)(void);

@end
