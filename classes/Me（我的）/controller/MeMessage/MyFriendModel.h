//
//  MyFriendModel.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/11.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyFriendModel : NSObject
/***  好友头像 */
@property(nonatomic,copy)NSString * photo;

/***  好友名字   */
@property(nonatomic,copy)NSString * fname;
/***  other——userid   */
@property(nonatomic,copy)NSString * other_userid;
@end
