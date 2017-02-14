//
//  ScoreProcessor.h
//  GolfIOS
//
//  Created by yangbin on 16/12/2.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseProcessor.h"

@interface ScoreProcessor : BaseProcessor
/** 获取组队信息 */
- (void)getGroupListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 18个洞标准杆数 */
- (void)getStandatdHoleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 开始记分 */
- (void)beginScoreWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 每个洞计分 */
- (void)addScoreWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 扫描二维码组队 */
- (void)scanAddWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 记分记录列表 */
- (void)getScoreRecordListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 记分详情 */
- (void)getGroupScoreDetailWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 移除用户(组队) */
- (void)removeUserWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 确认成绩 */
- (void)confirmScoreWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 删除记录 */
- (void)deleteScoreRecordWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 添加好友 */
- (void)addFriendsWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
@end
