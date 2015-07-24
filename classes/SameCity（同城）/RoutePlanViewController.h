//
//  RoutePlanViewController.h
//  officialDemoNavi
//
//  Created by LiuX on 14-9-1.
//  Copyright (c) 2014年 AutoNavi. All rights reserved.
//

#import "BaseNaviViewController.h"
#import "HomeModel.h"

@interface RoutePlanViewController : BaseNaviViewController
@property(nonatomic,strong)HomeModel *model;
- (id)initWithModel:(HomeModel *)mm;

@end
