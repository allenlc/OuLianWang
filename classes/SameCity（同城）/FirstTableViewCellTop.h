//
//  FirstTableViewCellTop.h
//  OuLianWang
//
//  Created by allenariel on 15/6/27.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstTableViewCellTop : UITableViewCell
@property(nonatomic,strong)UIButton *locationBtn;
@property(nonatomic,copy)void(^locationBlock)();

@end
