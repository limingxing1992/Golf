//
//  ScoreManager.h
//  GolfIOS
//
//  Created by yangbin on 16/12/2.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseManager.h"

@interface ScoreManager : BaseManager

/** 获取组队信息 */
- (void)getGroupListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

/** 18个洞标准杆数 */
- (void)getStandatdHoleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

/**
 开始计分
 @param parameters afterField       后9洞场次名称半场
                   ballplaceId      球场id
                   beforeField      前9洞场次名称
                   joingUserIdList	加入用户id		多个,分隔
 @param responSuccess 成功
 @param responFailure 失败
 */
- (void)beginScoreWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

/**
每个洞计分
 @param parameters  actualBarList	实际杆数	多个,分隔
                    groupId	        组
                    hotelId         球洞
                    joingUserIdList	记分用户	多个,分隔
                    pushBarList     推杆数	多个,分隔
 standardBarList	标准杆数	number
 joingUserIdList	加入用户id	string	多个,分隔
 @param responSuccess 成功
 @param responFailure 失败
 */
- (void)addScoreWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;



/**
 扫描二维码组队
 */
- (void)scanAddWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

/**
 记分记录列表
 */
- (void)getScoreRecordListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

/**
 记分详情
 */
- (void)getGroupScoreDetailWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

/**
 移除用户
 */
- (void)removeUserWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

/**
 确认成绩
 */
- (void)confirmScoreWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

/**
 删除记录
 */
- (void)deleteScoreRecordWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

/**
 主动添加好友 获取组队信息
 */
- (void)addFriendsWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

@end
