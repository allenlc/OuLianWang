//
//  MyDatabaseQueue.h
//  OuLianWang
//
//  Created by allenariel on 15/6/29.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum RecordType
{
    RecordTypeFav,
    RecordTypeHis,
}RecordType;

@class FMDatabaseQueue;
@class LiaoTianModel;

@interface MyDatabaseQueue : NSObject
{
    FMDatabaseQueue *_dbQueue;
}
+(id)shareInstance;
//搜索记录表
-(void)addHis:(NSString *)string recordType:(RecordType)type;
-(void)deleteHis:(NSString *)string recordType:(RecordType)type;
-(void)deleteAllHis:(RecordType)type;
-(NSArray *)getAllDataWithRecordType:(RecordType)type;
-(BOOL)isExistsWithHis:(NSString *)string recordType:(RecordType)recordType;
//==聊天表
-(void)addLiaotianModel:(LiaoTianModel *)model;
-(void)deleteLiaotianModel:(LiaoTianModel *)model;
-(void)deleteAllLiaotianModel:(LiaoTianModel *)model;
-(NSArray *)getAllLiaotian;

@end
