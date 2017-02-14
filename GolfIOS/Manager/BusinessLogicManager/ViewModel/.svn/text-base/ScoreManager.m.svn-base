//
//  ScoreManager.m
//  GolfIOS
//
//  Created by yangbin on 16/12/2.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "ScoreManager.h"
#import "ScoreProcessor.h"
#import "ScoreUserModel.h"
#import "StandardHoleListModel.h"
#import "SeverStatus.h"
#import "ScoreInfo.h"
#import "ScoreRecordModel.h"
//#import "NSDictionary+Log.h"

@interface ScoreManager ()
/**processor*/
@property (nonatomic, strong) ScoreProcessor *processor;

@end

@implementation ScoreManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        _processor = [[ScoreProcessor alloc] init];
    }
    return self;
}


//MARK: - 获取组队信息
- (void)getGroupListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor getGroupListWithParameters:parameters success:^(id responObject) {
        NSLog(@"获取组队信息%@",responObject);
        ScoreUserModel *model = [ScoreUserModel mj_objectWithKeyValues:responObject];
        responSuccess(model);
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
}

//MARK: - 18个洞标准杆数

- (void)getStandatdHoleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor getStandatdHoleListWithParameters:parameters success:^(id responObject) {
        
//        NSLog(@"18个洞标准杆数%@",responObject);
        StandardHoleListModel *model = [StandardHoleListModel mj_objectWithKeyValues:responObject];
        
        
        responSuccess(model);
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
}


//MARK: - 开始计分

- (void)beginScoreWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor beginScoreWithParameters:parameters success:^(id responObject) {
        
        
        NSLog(@"开始计分%@",responObject);
        ScoreInfo *model = [ScoreInfo mj_objectWithKeyValues:responObject];
  
        responSuccess(model);
    } failure:^(NSError *error) {
         responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
}

//MARK: - 每个洞计分

- (void)addScoreWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor addScoreWithParameters:parameters success:^(id responObject) {
        NSLog(@"每个洞计分%@",responObject);
        SeverStatus *model = [SeverStatus mj_objectWithKeyValues:responObject];
        responSuccess(model);
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
}

//MARK: - 扫描二维码组队

- (void)scanAddWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor scanAddWithParameters:parameters success:^(id responObject) {
        NSLog(@"扫描二维码组队%@",responObject);
        ScoreUserModel *model = [ScoreUserModel mj_objectWithKeyValues:responObject];
        responSuccess(model);
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
}


//MARK: - 记分记录列表

- (void)getScoreRecordListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor getScoreRecordListWithParameters:parameters success:^(id responObject) {
        
        NSLog(@"记分记录列表%@",responObject);
        ScoreRecordModel *model = [ScoreRecordModel mj_objectWithKeyValues:responObject];
        responSuccess(model);
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
}

//MARK: -记分详情

- (void)getGroupScoreDetailWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor getGroupScoreDetailWithParameters:parameters success:^(id responObject) {
        
        NSLog(@"记分详情%@",responObject);
        ScoreInfo *model = [ScoreInfo mj_objectWithKeyValues:responObject];
        responSuccess(model);
    } failure:^(NSError *error) {
         responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
}

//MARK: -移除用户(组队)

- (void)removeUserWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor removeUserWithParameters:parameters success:^(id responObject) {
        NSLog(@"移除用户(组队)%@",responObject);
        SeverStatus *model = [SeverStatus mj_objectWithKeyValues:responObject];
        responSuccess(model);
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
}

//MARK: -确认成绩

- (void)confirmScoreWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor confirmScoreWithParameters:parameters success:^(id responObject) {
        NSLog(@"确认成绩%@",responObject);
        SeverStatus *model = [SeverStatus mj_objectWithKeyValues:responObject];
        responSuccess(model);
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
}


//MARK: -删除记录

- (void)deleteScoreRecordWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor deleteScoreRecordWithParameters:parameters success:^(id responObject) {
        NSLog(@"删除记录%@",responObject);
        SeverStatus *model = [SeverStatus mj_objectWithKeyValues:responObject];
        responSuccess(model);
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
}

//MARK: -主动添加好友

- (void)addFriendsWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor addFriendsWithParameters:parameters success:^(id responObject) {
        NSLog(@"主动添加好友获取组队信息%@",responObject);
        ScoreUserModel *model = [ScoreUserModel mj_objectWithKeyValues:responObject];
        responSuccess(model);
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);    }];
}

@end
