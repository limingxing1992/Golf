//
//  ScoreProcessor.m
//  GolfIOS
//
//  Created by yangbin on 16/12/2.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "ScoreProcessor.h"

//获取组队信息
static NSString *const kGetGroupList = @"app/user/ballscore/getGroupList.app";
//18个洞标准杆数
static NSString *const kHoleList = @"app/hole/holeList.app";
//开始记分
static NSString *const kBeginScore = @"app/user/ballscore/beginScore.app";
//每个洞计分
static NSString *const kAddScore = @"app/user/ballscore/addScore.app";
//扫描二维码组队
static NSString *const kScanAdd = @"app/user/ballscore/scanAdd.app";
//计分记录列表
static NSString *const kGetScoreRecordList = @"app/user/ballscore/getScoreRecordList.app";
//计分详情
static NSString *const kGetGroupScoreDetail = @"app/user/ballscore/getGroupScoreDetail.app";
//移除用户
static NSString *const kRemoveUser = @"app/user/ballscore/removeUser.app";
//确认成绩
static NSString *const kConfirmScore = @"app/user/ballscore/confirmScore.app";
//删除成绩
static NSString *const kDeleteScoreRecord = @"app/user/ballscore/deleteScoreRecord.app";
//主动添加好友
static NSString *const kAddFriends = @"app/user/ballscore/addFriends.app";

@implementation ScoreProcessor

- (void)getGroupListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kGetGroupList parameter:parameters success:success failure:failure];
}


- (void)getStandatdHoleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kHoleList parameter:parameters success:success failure:failure];
}


- (void)beginScoreWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kBeginScore parameter:parameters success:success failure:failure];
}

- (void)addScoreWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kAddScore parameter:parameters success:success failure:failure];
}

- (void)scanAddWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kScanAdd parameter:parameters success:success failure:failure];
}

- (void)getScoreRecordListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kGetScoreRecordList parameter:parameters success:success failure:failure];
}

- (void)getGroupScoreDetailWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kGetGroupScoreDetail parameter:parameters success:success failure:failure];
}


- (void)removeUserWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kRemoveUser parameter:parameters success:success failure:failure];
}

- (void)confirmScoreWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kConfirmScore parameter:parameters success:success failure:failure];
}

- (void)deleteScoreRecordWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kDeleteScoreRecord parameter:parameters success:success failure:failure];
}

- (void)addFriendsWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kAddFriends parameter:parameters success:success failure:failure];
}
@end
