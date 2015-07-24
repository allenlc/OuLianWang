//
//  SystemNotification.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/30.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "SystemNotification.h"
#import "SystemNotiCell.h"
@implementation SystemNotification

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

+ (SystemNotification *)sharedManager
{
    static SystemNotification *systemTableView = nil;
    static dispatch_once_t predicate1;
    dispatch_once(&predicate1, ^{
        systemTableView = [[self alloc] init];
        
    });
    return systemTableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 12;//下载数据
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SystemNotiCell * cell = [SystemNotiCell cellWithTableViewCell:tableView];
    [cell setindexPath:indexPath];
    return cell;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}


@end
