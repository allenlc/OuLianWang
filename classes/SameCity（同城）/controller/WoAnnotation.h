//
//  WoAnnotation.h
//  OuLianWang
//
//  Created by allenariel on 15/6/23.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import "ShopModel.h"
@interface WoAnnotation : NSObject <MAAnnotation>

@property(nonatomic,assign)CLLocationCoordinate2D coordinate;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *subtitle;

@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *pointerimg;
@property (nonatomic, strong) ShopModel *model;


@end
