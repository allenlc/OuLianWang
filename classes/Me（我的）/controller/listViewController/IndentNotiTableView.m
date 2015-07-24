//
//  IndentNotiTableView.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/30.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "IndentNotiTableView.h"
#import "IndentNotiCell.h"
@implementation IndentNotiTableView

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

+ (IndentNotiTableView *)sharedManager
{
    static IndentNotiTableView *indentTableView = nil;
    static dispatch_once_t predicate1;
    dispatch_once(&predicate1, ^{
        indentTableView = [[self alloc] init];
        
    });
    return indentTableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 12;//下载数据
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    IndentNotiCell * cell = [IndentNotiCell cellWithTableViewCell:tableView];
    [cell setindexPath:indexPath];
    return cell;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}


@end
