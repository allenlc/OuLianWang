//
//  RootViewController.h
//  UUChatTableView
//
//  Created by shake on 15/1/4.
//  Copyright (c) 2015年 uyiuyao. All rights reserved.
//


//#import "RootsRootViewController.h"
#import "ListViewController.h"

@protocol SendSms <NSObject>

-(void)sendSmsWith:(NSString *)string;


@end

@interface RootViewController : ListViewController
-(void)reloadNewSms;
@property(nonatomic,weak)id<SendSms> delegate;

@end
