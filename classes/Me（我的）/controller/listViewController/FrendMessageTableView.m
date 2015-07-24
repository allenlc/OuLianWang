//
//  FrendMessageTableView.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/30.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "FrendMessageTableView.h"
#import "FrienMessageCell.h"
#import "FriendChaatVController.h"
#import "RootViewController.h"
@implementation FrendMessageTableView
-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}


+ (FrendMessageTableView *)sharedManager
{
    static FrendMessageTableView *friendTableView = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        friendTableView = [[self alloc] init];
        
    });
    return friendTableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;//下载数据
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FrienMessageCell * cell = [FrienMessageCell cellWithTableViewCell:tableView];
    [cell setindexPath:indexPath];
    if (self.shumuSms>0) {
        cell.shumulabel.text=[NSString stringWithFormat:@"%d",_shumuSms];
        cell.shumulabel.hidden=NO;
    }
    else{
        cell.shumulabel.text=@"";
        cell.shumulabel.hidden=YES;
    }
    return cell;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}
#pragma mark - cell点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[self viewController:self].navigationController pushViewController:[RootViewController new] animated:YES];
    
}

-(UIViewController *)viewController:(UIView *)view{
    /// Finds the view's view controller.
    // Traverse responder chain. Return first found view controller, which will be the view's view controller.
    UIResponder *responder = view;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    // If the view controller isn't found, return nil.
    return nil;
}

@end
