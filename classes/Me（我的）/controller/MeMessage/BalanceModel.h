//
//  BalanceModel.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/18.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BalanceModel : NSObject
/***  总收入 */
@property(nonatomic,copy)NSString * zmoney;

/***  总支出   */
@property(nonatomic,copy)NSString * smoney;
/***  总收入 */
@property(nonatomic,copy)NSString * remain;

/***  总支出   */
@property(nonatomic,copy)NSString * rows;
@end
