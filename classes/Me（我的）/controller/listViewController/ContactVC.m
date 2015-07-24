//
//  ContactVC.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/14.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "ContactVC.h"
#import "FriendGroup.h"
#import "Friend.h"
#import "HeadView.h"
#import "ChatVController.h"
#import "ZQSearchBar.h"
@interface ContactVC ()<HeadViewDelegate>
{
    NSArray *_friendsData;
}


@end

@implementation ContactVC
-(void)loadView
{
    [super loadView];
    
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setSearchBar];

    self.tableView.sectionHeaderHeight = 40;
    
    [self loadData];
}
-(void)setSearchBar
{
    ZQSearchBar *searchBar = [[ZQSearchBar alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-250)/2, 120, 250, 30)];
    searchBar.layer.cornerRadius = 30/2;
    searchBar.backgroundColor = [UIColor redColor];
    searchBar.placeholder = @"大家都在搜何志强";
    [self.view addSubview:searchBar];
}

#pragma mark 加载数据
- (void)loadData
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"friends.plist" withExtension:nil];
    NSArray *tempArray = [NSArray arrayWithContentsOfURL:url];
    
    NSMutableArray *fgArray = [NSMutableArray array];
    for (NSDictionary *dict in tempArray) {
        FriendGroup *friendGroup = [FriendGroup friendGroupWithDict:dict];
        [fgArray addObject:friendGroup];
    }
    
    _friendsData = fgArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _friendsData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    FriendGroup *friendGroup = _friendsData[section];
    NSInteger count = friendGroup.isOpened ? friendGroup.friends.count : 0;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    FriendGroup *friendGroup = _friendsData[indexPath.section];
    Friend *friend = friendGroup.friends[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:friend.icon];
    cell.textLabel.textColor = friend.isVip ? [UIColor redColor] : [UIColor blackColor];
    cell.textLabel.text = friend.name;
    cell.detailTextLabel.text = friend.intro;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeadView *headView = [HeadView headViewWithTableView:tableView];
    
    headView.delegate = self;
    headView.friendGroup = _friendsData[section];
    
    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatVController *viewController = [[ChatVController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    FriendGroup *friendGroup = _friendsData[indexPath.section];
    Friend *friend = friendGroup.friends[indexPath.row];
    
    viewController.navigationItem.title = friend.name;
}

- (void)clickHeadView
{
    [self.tableView reloadData];
}
@end
