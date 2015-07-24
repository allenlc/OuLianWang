//
//  CommunityViewController.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/14.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "CommunityViewController.h"
#import "YMTableViewCell.h"
#import "ContantHead.h"
#import "YMShowImageView.h"
#import "YMTextData.h"
#import "YMReplyInputView.h"
#import "WFReplyBody.h"
#import "WFMessageBody.h"
#import "WFPopView.h"
#import "WFActionSheet.h"

#import "OLWTabBarController.h"
#import "XieshuoshuoController.h"


#define dataCount 10
#define kLocationToBottom 20
#define kAdmin @"程琪琪"
@interface CommunityViewController ()<UITableViewDataSource,UITableViewDelegate,cellDelegate,InputDelegate,UIActionSheetDelegate>
{
    NSMutableArray *_imageDataSource;
    
    NSMutableArray *_contentDataSource;//模拟接口给的数据
    
    NSMutableArray *_tableDataSource;//tableview数据源
    
    NSMutableArray *_shuoshuoDatasSource;//说说数据源
    
    UITableView *mainTable;
    
    UIView *popView;
    
    YMReplyInputView *replyView ;
    
    NSInteger _replyIndex;
    
    
}
@property (nonatomic,strong) WFPopView *operationView;
@property (nonatomic,strong) NSIndexPath *selectedIndexPath;
@end

@implementation CommunityViewController

#pragma mark - 数据源
- (void)configData{
    
    _tableDataSource = [[NSMutableArray alloc] init];
    _contentDataSource = [[NSMutableArray alloc] init];
    _replyIndex = -1;//代表是直接评论
    
    
    WFReplyBody *body1 = [[WFReplyBody alloc] init];
    body1.replyUser = kAdmin;
    body1.repliedUser = @"红领巾";
    body1.replyInfo = kContentText1;
    
    
    WFReplyBody *body2 = [[WFReplyBody alloc] init];
    body2.replyUser = @"程琪琪";
    body2.repliedUser = @"";
    body2.replyInfo = kContentText2;
    
    
    WFReplyBody *body3 = [[WFReplyBody alloc] init];
    body3.replyUser = @"张旭";
    body3.repliedUser = @"";
    body3.replyInfo = kContentText3;
    
    
    WFReplyBody *body4 = [[WFReplyBody alloc] init];
    body4.replyUser = @"李聪";
    body4.repliedUser = @"刘德华";
    body4.replyInfo = kContentText4;
    
    
    WFReplyBody *body5 = [[WFReplyBody alloc] init];
    body5.replyUser = kAdmin;
    body5.repliedUser = @"张三丰";
    body5.replyInfo = kContentText5;
    
    
    WFReplyBody *body6 = [[WFReplyBody alloc] init];
    body6.replyUser = @"红领巾";
    body6.repliedUser = @"";
    body6.replyInfo = kContentText6;
    
    
    WFMessageBody *messBody1 = [[WFMessageBody alloc] init];
    messBody1.posterContent = kShuoshuoText1;
    messBody1.posterPostImage = @[@"shequxiangce.png",@"shequxiangce.png",@"shequxiangce.png"];
    messBody1.posterReplies = [NSMutableArray arrayWithObjects:body1,body2,body4, nil];
    messBody1.posterImgstr = @"pengyouquandatouxiang";
    messBody1.posterName = @"程茜茜";
    messBody1.posterIntro = @"这个人很懒，什么都没有留下";
    messBody1.posterFavour = [NSMutableArray arrayWithObjects:@"路人甲",@"希尔瓦娜斯",kAdmin,@"鹿盔", nil];
    messBody1.isFavour = YES;
    
    WFMessageBody *messBody2 = [[WFMessageBody alloc] init];
    messBody2.posterContent = kShuoshuoText1;
    messBody2.posterPostImage = @[@"shequxiangce.png",@"shequxiangce.png",@"shequxiangce.png"];
    messBody2.posterReplies = [NSMutableArray arrayWithObjects:body1,body2,body4, nil];
    messBody2.posterImgstr = @"pengyouquandatouxiang";
    messBody2.posterName = @"黄海波";
    messBody2.posterIntro = @"这个人很懒，什么都没有留下";
    messBody2.posterFavour = [NSMutableArray arrayWithObjects:@"卡卡西",@"希尔瓦娜斯",@"鹿盔", nil];
    messBody2.isFavour = NO;
    
    
    WFMessageBody *messBody3 = [[WFMessageBody alloc] init];
    messBody3.posterContent = kShuoshuoText3;
    messBody3.posterPostImage = @[@"shequxiangce.png",@"shequxiangce.png",@"shequxiangce.png",@"shequxiangce.png",@"shequxiangce.png",@"shequxiangce.png"];
    messBody3.posterReplies = [NSMutableArray arrayWithObjects:body1,body2,body4,body6,body5,body4, nil];
    messBody3.posterImgstr = @"pengyouquandatouxiang";
    messBody3.posterName = @"成龙";
    messBody3.posterIntro = @"这个人很懒，什么都没有留下";
    messBody3.posterFavour = [NSMutableArray arrayWithObjects:@"路人甲",kAdmin,@"希尔瓦娜斯",@"鹿盔",@"黑手", nil];
    messBody3.isFavour = YES;
    
    WFMessageBody *messBody4 = [[WFMessageBody alloc] init];
    messBody4.posterContent = kShuoshuoText4;
    messBody4.posterPostImage = @[@"shequxiangce.png",@"shequxiangce.png",@"shequxiangce.png",@"shequxiangce.png",@"shequxiangce.png"];
    messBody4.posterReplies = [NSMutableArray arrayWithObjects:body1, nil];
    messBody4.posterImgstr = @"pengyouquandatouxiang";
    messBody4.posterName = @"周星驰";
    messBody4.posterIntro = @"这个人很懒，什么都没有留下";
    messBody4.posterFavour = [NSMutableArray arrayWithObjects:nil];
    messBody4.isFavour = NO;
    
    WFMessageBody *messBody5 = [[WFMessageBody alloc] init];
    messBody5.posterContent = kShuoshuoText5;
    messBody5.posterPostImage = @[@"shequxiangce.png",@"shequxiangce.png",@"shequxiangce.png",@"shequxiangce.png"];
    messBody5.posterReplies = [NSMutableArray arrayWithObjects:body2,body4,body5, nil];
    
    messBody5.posterImgstr = @"pengyouquandatouxiang";
    
    // 这个人的昵称
    messBody5.posterName = @"呵呵";
    
    // 这个人得签名
    messBody5.posterIntro = @"这个人很懒，什么都没有留下";
    
    //  喜欢点了赞的人
    messBody5.posterFavour = [NSMutableArray arrayWithObjects:@"希尔瓦娜斯",@"格鲁尔",@"魔兽世界5区石锤人类联盟女圣骑丨阿诺丨",@"钢铁女武神",@"魔兽世界5区石锤人类联盟女盗贼chaotics",@"克苏恩",@"克尔苏加德",@"钢铁议会", nil];
    messBody5.isFavour = NO;
    
    WFMessageBody *messBody6 = [[WFMessageBody alloc] init];
    messBody6.posterContent = kShuoshuoText5;
    messBody6.posterPostImage = @[@"shequxiangce.png",@"shequxiangce.png",@"shequxiangce.png",@"shequxiangce.png",@"shequxiangce.png"];
    messBody6.posterReplies = [NSMutableArray arrayWithObjects:body2,body4,body5,body4,body6, nil];
    messBody6.posterImgstr = @"pengyouquandatouxiang";
    messBody6.posterName = @"红领巾";
    messBody6.posterIntro = @"这个人很懒，什么都没有留下";
    messBody6.posterFavour = [NSMutableArray arrayWithObjects:@"爆裂熔炉",@"希尔瓦娜斯",@"阿尔萨斯",@"死亡之翼",@"玛里苟斯", nil];
    messBody6.isFavour = NO;
    
    
    [_contentDataSource addObject:messBody1];
    [_contentDataSource addObject:messBody2];
    [_contentDataSource addObject:messBody3];
    [_contentDataSource addObject:messBody4];
    [_contentDataSource addObject:messBody5];
    [_contentDataSource addObject:messBody6];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
    [self configData];
    
    [self initTableview];
    
    [self loadTextData];
    
    [self  deplyNavigationController1];
}

#pragma mark -加载数据
- (void)loadTextData{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray * ymDataArray =[[NSMutableArray alloc]init];
        
        for (int i = 0 ; i < _contentDataSource.count; i ++) {
            
            WFMessageBody *messBody = [_contentDataSource objectAtIndex:i];
            
            YMTextData *ymData = [[YMTextData alloc] init ];
            ymData.messageBody = messBody;
            
            [ymDataArray addObject:ymData];
            
        }
        [self calculateHeight:ymDataArray];
        
    });
}



#pragma mark - 计算高度
- (void)calculateHeight:(NSMutableArray *)dataArray{
    
    
    NSDate* tmpStartData = [NSDate date];
    
    for (YMTextData *ymData in dataArray) {
        
        ymData.shuoshuoHeight = [ymData calculateShuoshuoHeightWithWidth:self.view.frame.size.width withUnFoldState:NO];//折叠
        
        ymData.unFoldShuoHeight = [ymData calculateShuoshuoHeightWithWidth:self.view.frame.size.width withUnFoldState:YES];//展开
        
        ymData.replyHeight = [ymData calculateReplyHeightWithWidth:self.view.frame.size.width];
        
        ymData.favourHeight = [ymData calculateFavourHeightWithWidth:self.view.frame.size.width];
        
        [_tableDataSource addObject:ymData];
        
    }
    
    double deltaTime = [[NSDate date] timeIntervalSinceDate:tmpStartData];
    NSLog(@"cost time = %f", deltaTime);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [mainTable reloadData];
        
    });
    
}




- (void) initTableview{
    
    mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -64-44)];
    mainTable.backgroundColor = [UIColor clearColor];
     mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTable.delegate = self;
    mainTable.dataSource = self;
    [self.view addSubview:mainTable];
    
}

//**
// *  ///////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  _tableDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        return 170;
    }
    else{
    YMTextData *ym = [_tableDataSource objectAtIndex:indexPath.row];
    BOOL unfold = ym.foldOrNot;
    return  kLocationToBottom + ym.replyHeight + ym.showImageHeight  + kDistance + (ym.islessLimit?0:30) + (unfold?ym.shuoshuoHeight:ym.unFoldShuoHeight) + kReplyBtnDistance + ym.favourHeight + (ym.favourHeight == 0?0:kReply_FavourDistance);
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        UITableViewCell * cell = [[UITableViewCell alloc]init];
        UIImageView * imgviewBG;
        if (imgviewBG==nil) {
            imgviewBG= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 120)];
            imgviewBG.image = [UIImage imageNamed:@"sx_bg.png"];
            [cell.contentView addSubview:imgviewBG];
            UIImageView * iconImgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.width-90, 80, 70, 70)];
            iconImgView.image = [UIImage imageNamed:@"pengyouquandatouxiang"];
            [cell.contentView addSubview:iconImgView];
            
            UILabel * nameLable = [[UILabel alloc]initWithFrame:CGRectMake(self.view.width-160, 90, 70, 20)];
            nameLable.text = @"程琪琪";
             nameLable.textColor = [UIColor whiteColor];
            [cell.contentView addSubview:nameLable];
        }
        return cell;
        

        
    }
    else{
    static NSString *CellIdentifier = @"ILTableViewCell";
    
    YMTableViewCell *cell = (YMTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[YMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.stamp = indexPath.row;
    cell.replyBtn.appendIndexPath = indexPath;
    [cell.replyBtn addTarget:self action:@selector(replyAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.delegate = self;
    [cell setYMViewWith:[_tableDataSource objectAtIndex:indexPath.row]];
        if (indexPath.row ==_tableDataSource.count-1) {
            cell.botLine.hidden = YES;
        }
        else{
            cell.botLine.hidden = NO;
        }
    return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
////////////////////////////////////////////////////////////////////

#pragma mark - 按钮动画

- (void)replyAction:(YMButton *)sender{
    
    CGRect rectInTableView = [mainTable rectForRowAtIndexPath:sender.appendIndexPath];
    CGFloat origin_Y = rectInTableView.origin.y + sender.frame.origin.y;
    CGRect targetRect = CGRectMake(CGRectGetMinX(sender.frame), origin_Y, CGRectGetWidth(sender.bounds), CGRectGetHeight(sender.bounds));
    if (self.operationView.shouldShowed) {
        [self.operationView dismiss];
        return;
    }
    _selectedIndexPath = sender.appendIndexPath;
    YMTextData *ym = [_tableDataSource objectAtIndex:_selectedIndexPath.row];
    [self.operationView showAtView:mainTable rect:targetRect isFavour:ym.hasFavour];
}



- (WFPopView *)operationView {
    if (!_operationView) {
        _operationView = [WFPopView initailzerWFOperationView];
        WS(ws);
        _operationView.didSelectedOperationCompletion = ^(WFOperationType operationType) {
            switch (operationType) {
                case WFOperationTypeLike:
                    
                    [ws addLike];
                    break;
                case WFOperationTypeReply:
                    [ws replyMessage: nil];
                    break;
                default:
                    break;
            }
        };
    }
    return _operationView;
}

#pragma mark - 赞
- (void)addLike{
    
    YMTextData *ymData = (YMTextData *)[_tableDataSource objectAtIndex:_selectedIndexPath.row];
    WFMessageBody *m = ymData.messageBody;
    if (m.isFavour == YES) {//此时该取消赞
        [m.posterFavour removeObject:kAdmin];
        m.isFavour = NO;
    }else{
        [m.posterFavour addObject:kAdmin];
        m.isFavour = YES;
    }
    ymData.messageBody = m;
    
    
    //清空属性数组。否则会重复添加
    
    [ymData.attributedDataFavour removeAllObjects];
    
    
    ymData.favourHeight = [ymData calculateFavourHeightWithWidth:self.view.frame.size.width];
    [_tableDataSource replaceObjectAtIndex:_selectedIndexPath.row withObject:ymData];
    
    [mainTable reloadData];
    
}


#pragma mark - 真の评论
- (void)replyMessage:(YMButton *)sender{
    
    if (replyView) {
        return;
    }
    replyView = [[YMReplyInputView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, screenWidth,44) andAboveView:self.view];
    replyView.delegate = self;
    replyView.replyTag = _selectedIndexPath.row;
    [self.view addSubview:replyView];
    
}


#pragma mark -移除评论按钮
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.operationView dismiss];
    
}


#pragma mark -cellDelegate
- (void)changeFoldState:(YMTextData *)ymD onCellRow:(NSInteger)cellStamp{
    
    [_tableDataSource replaceObjectAtIndex:cellStamp withObject:ymD];
    [mainTable reloadData];
    
}

#pragma mark - 图片点击事件回调
- (void)showImageViewWithImageViews:(NSArray *)imageViews byClickWhich:(NSInteger)clickTag{
    
    UIView *maskview = [[UIView alloc] initWithFrame:self.view.bounds];
    maskview.backgroundColor = [UIColor blackColor];
    [self.view addSubview:maskview];
    
    YMShowImageView *ymImageV = [[YMShowImageView alloc] initWithFrame:self.view.bounds byClick:clickTag appendArray:imageViews];
    [ymImageV show:maskview didFinish:^(){
        
        [UIView animateWithDuration:0.5f animations:^{
            
            ymImageV.alpha = 0.0f;
            maskview.alpha = 0.0f;
            
        } completion:^(BOOL finished) {
            
            [ymImageV removeFromSuperview];
            [maskview removeFromSuperview];
        }];
        
    }];
    
}

#pragma mark - 长按评论整块区域的回调
- (void)longClickRichText:(NSInteger)index replyIndex:(NSInteger)replyIndex{
    
    [self.operationView dismiss];
    YMTextData *ymData = (YMTextData *)[_tableDataSource objectAtIndex:index];
    WFReplyBody *b = [ymData.messageBody.posterReplies objectAtIndex:replyIndex];
    
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = b.replyInfo;
    
}

#pragma mark - 点评论整块区域的回调
- (void)clickRichText:(NSInteger)index replyIndex:(NSInteger)replyIndex{
    
    [self.operationView dismiss];
    
    _replyIndex = replyIndex;
    
    YMTextData *ymData = (YMTextData *)[_tableDataSource objectAtIndex:index];
    WFReplyBody *b = [ymData.messageBody.posterReplies objectAtIndex:replyIndex];
    if ([b.replyUser isEqualToString:kAdmin]) {
        WFActionSheet *actionSheet = [[WFActionSheet alloc] initWithTitle:@"删除评论？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
        actionSheet.actionIndex = index;
        [actionSheet showInView:self.view];
        
        
        
    }else{
        //回复
        if (replyView) {
            return;
        }
        replyView = [[YMReplyInputView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, screenWidth,44) andAboveView:self.view];
        replyView.delegate = self;
        replyView.lblPlaceholder.text = [NSString stringWithFormat:@"回复%@:",b.replyUser];
        replyView.replyTag = index;
        [self.view addSubview:replyView];
    }
}

#pragma mark - 评论说说回调
- (void)YMReplyInputWithReply:(NSString *)replyText appendTag:(NSInteger)inputTag{
    
    YMTextData *ymData = nil;
    if (_replyIndex == -1) {
        
        WFReplyBody *body = [[WFReplyBody alloc] init];
        body.replyUser = kAdmin;
        body.repliedUser = @"";
        body.replyInfo = replyText;
        
        ymData = (YMTextData *)[_tableDataSource objectAtIndex:inputTag];
        WFMessageBody *m = ymData.messageBody;
        [m.posterReplies addObject:body];
        ymData.messageBody = m;
        
    }else{
        
        ymData = (YMTextData *)[_tableDataSource objectAtIndex:inputTag];
        WFMessageBody *m = ymData.messageBody;
        
        WFReplyBody *body = [[WFReplyBody alloc] init];
        body.replyUser = kAdmin;
        body.repliedUser = [(WFReplyBody *)[m.posterReplies objectAtIndex:_replyIndex] replyUser];
        body.replyInfo = replyText;
        
        [m.posterReplies addObject:body];
        ymData.messageBody = m;
        
    }
    
    
    
    //清空属性数组。否则会重复添加
    [ymData.completionReplySource removeAllObjects];
    [ymData.attributedDataReply removeAllObjects];
    
    
    ymData.replyHeight = [ymData calculateReplyHeightWithWidth:self.view.frame.size.width];
    [_tableDataSource replaceObjectAtIndex:inputTag withObject:ymData];
    
    [mainTable reloadData];
    
}

- (void)destorySelf{
    
    //  NSLog(@"dealloc reply");
    [replyView removeFromSuperview];
    replyView = nil;
    _replyIndex = -1;
    
}

- (void)actionSheet:(WFActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        //delete
        YMTextData *ymData = (YMTextData *)[_tableDataSource objectAtIndex:actionSheet.actionIndex];
        WFMessageBody *m = ymData.messageBody;
        [m.posterReplies removeObjectAtIndex:_replyIndex];
        ymData.messageBody = m;
        [ymData.completionReplySource removeAllObjects];
        [ymData.attributedDataReply removeAllObjects];
        
        
        ymData.replyHeight = [ymData calculateReplyHeightWithWidth:self.view.frame.size.width];
        [_tableDataSource replaceObjectAtIndex:actionSheet.actionIndex withObject:ymData];
        
        [mainTable reloadData];
        
    }else{
        
    }
    _replyIndex = -1;
}

- (void)dealloc{
    
    // NSLog(@"销毁");
    
}

#pragma mark-------配置导航栏

-(void)deplyNavigationController1
{
    
    self.navigationItem.title=@"朋友圈";
    
    
    UIButton *fabubutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [fabubutton  setImage:[UIImage imageNamed:@"加号.png"] forState:UIControlStateNormal];
    fabubutton.frame=CGRectMake(0, 0, 20, 20);
    [fabubutton  addTarget:self action:@selector(fabuclick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightbutton=[[UIBarButtonItem alloc]initWithCustomView:fabubutton];
    self.navigationItem.rightBarButtonItem=rightbutton;
    
    
    
}

-(void)fabuclick
{
    XieshuoshuoController *xiecontroller=[[XieshuoshuoController alloc]init];
    [self.navigationController  pushViewController:xiecontroller animated:YES];
    
}


-(void)diquButtonClick
{
    [self.navigationController  popViewControllerAnimated:YES];
    
}

#pragma mark------标签栏的隐藏和现实
-(void)viewWillAppear:(BOOL)animated
{
    
    OLWTabBarController * tabBarVC =(OLWTabBarController *) self.tabBarController;
    tabBarVC.zqTabBar.hidden = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    OLWTabBarController * tabBarVC =(OLWTabBarController *) self.tabBarController;
    tabBarVC.zqTabBar.hidden = NO;
    
}

@end
