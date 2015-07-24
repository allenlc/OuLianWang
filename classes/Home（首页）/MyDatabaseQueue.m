//
//  MyDatabaseQueue.m
//  OuLianWang
//
//  Created by allenariel on 15/6/29.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "MyDatabaseQueue.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "LiaoTianModel.h"

static MyDatabaseQueue *single=nil;

@implementation MyDatabaseQueue
+(id)shareInstance
{
    @synchronized(self){
        if (single==nil) {
            
            single=[[MyDatabaseQueue alloc]init];
        }
    }
    return single;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *dataPath=[NSHomeDirectory() stringByAppendingString:@"/Documents/oulian.db"];
        NSLog(@"数据库路径：%@",dataPath);
        _dbQueue=[FMDatabaseQueue databaseQueueWithPath:dataPath];

        NSString *sql=@"CREATE TABLE if not exists his1 (ID integer primary key autoincrement ,string varchar(128));";
        
        [_dbQueue inDatabase:^(FMDatabase *_db) {
            BOOL symbol=[_db executeUpdate:sql];
            if (symbol) {
//                NSLog(@"创建表1成功");
            }
            else
                NSLog(@"创建表1失败");
        }];
        
        NSString *sql2=@"CREATE TABLE if not exists his5 (ID integer primary key autoincrement ,userID varchar(128),userName varchar(128),content varchar(128),sendTime varchar(128),headImg varchar(128),msgType varchar(128),isRead varchar(128),isFrom varchar(128));";
        
        [_dbQueue inDatabase:^(FMDatabase *_db) {
            BOOL symbol=[_db executeUpdate:sql2];
            if (symbol) {
                //NSLog(@"创建表1成功");
            }
            else
                NSLog(@"创建表2失败");
        }];
        



    }

    
    return self;
}
//添加一条his
-(void)addHis:(NSString *)string recordType:(RecordType)type
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        BOOL symbol=[db executeUpdate:@"insert into his1 (string) values(?);",string];
        if (symbol) {
//            NSLog(@"数据his添加成功");
        }
        else
            NSLog(@"数据his添加失败");
    }];

}
//删除一条his
-(void)deleteHis:(NSString *)string recordType:(RecordType)type
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        BOOL symbol=[db executeUpdate:@"delete from his1 where string=?;",string];
        if (symbol) {
//            NSLog(@"删除his成功");
        }
        else
            NSLog(@"删除his失败");
    }];
}
//删除全部his
-(void)deleteAllHis:(RecordType)type
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        BOOL symbol=[db executeUpdate:@"delete from his1 ;"];
        if (symbol) {
//            NSLog(@"数据his全部删除成功");
        }
        else
            NSLog(@"数据his全部删除失败");
    }];

}
//获得全部his
-(NSArray *)getAllDataWithRecordType:(RecordType)type
{
    NSMutableArray *array=[NSMutableArray array];
    NSString *sql=@"select *from his1";
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *set=[db executeQuery:sql];
        
        while ([set next]) {
            NSString *string=[set stringForColumn:@"string"];
            
            
            [array addObject:string];
        }
    }];
    return array;
}
//判断是否存在
-(BOOL)isExistsWithHis:(NSString *)string recordType:(RecordType)recordType
{
    __block  BOOL a;
    a=NO;
    NSString *sql=@"select * from his1 where string=?";
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *set=[db executeQuery:sql,string];
        
        while ([set next]) {
            a=YES;
        }
        
    }];
    return a;
}

#pragma mark - 聊天记录表
-(void)addLiaotianModel:(LiaoTianModel *)model
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        BOOL symbol=[db executeUpdate:@"insert into his5 (userID,userName,content,sendTime,headImg,msgType,isRead,isFrom) values(?,?,?,?,?,?,?,?);",model.userID,model.userName,model.content,model.sendTime,model.headImg,model.msgType,model.isRead,model.from];
        if (symbol) {
            //NSLog(@"数据his添加成功");
        }
        else
            NSLog(@"聊天记录添加失败");
    }];

}
-(void)deleteAllLiaotianModel:(LiaoTianModel *)model
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        BOOL symbol=[db executeUpdate:@"delete from his5;"];
        if (symbol) {
            //            NSLog(@"数据his全部删除成功");
        }
        else
            NSLog(@"聊天记录全部删除失败");
    }];

}
-(NSArray *)getAllLiaotian
{
    NSMutableArray *array=[NSMutableArray array];
    NSString *sql=@"select *from his5";
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *set=[db executeQuery:sql];
        
        while ([set next]) {
            LiaoTianModel *mm=[[LiaoTianModel alloc]init];
            
            mm.userID=[set stringForColumn:@"userID"];
            mm.userName=[set stringForColumn:@"userName"];
            mm.content=[set stringForColumn:@"content"];
            mm.sendTime=[set stringForColumn:@"sendTime"];
            mm.headImg=[set stringForColumn:@"headImg"];
            mm.msgType=[set stringForColumn:@"msgType"];
            mm.isRead=[set stringForColumn:@"isRead"];
            mm.from=[set stringForColumn:@"isFrom"];
            [array addObject:mm];
        }
    }];
    return array;
}


@end
