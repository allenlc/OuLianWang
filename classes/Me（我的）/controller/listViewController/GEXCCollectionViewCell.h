//
//  GEXCCollectionViewCell.h
//  OuLianWang
//
//  Created by allenariel on 15/6/24.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GEXCCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *xiangNumber;
@property (weak, nonatomic) IBOutlet UILabel *lookNumber;
+(NSString *)myIdentify;
@property (weak, nonatomic) IBOutlet UIImageView *tubiao1;
@property (weak, nonatomic) IBOutlet UIImageView *tubiao2;

@end
