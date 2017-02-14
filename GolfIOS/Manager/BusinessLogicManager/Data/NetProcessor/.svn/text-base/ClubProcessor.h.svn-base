//
//  ClubProcessor.h
//  GolfIOS
//
//  Created by yangbin on 16/12/2.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseProcessor.h"

@interface ClubProcessor : BaseProcessor


/** 俱乐部帖子或公告列表 */
- (void)getClubArticleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 发布公告或帖子 */
- (void)postClubArticleWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 已加入俱乐部帖子和公告 */
- (void)getJoinedClubArticleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 已推荐公告 */
- (void)getClubRecommendNoticeListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 帖子或公告详情 */
- (void)getCubArticleDetailWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 搜索帖子和公告 */
- (void)searchClubArticleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 俱乐部首页 */
- (void)getClubIndexWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 公告或帖子评论 */
- (void)getClubArticleCommentListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 申请加入俱乐部 */
- (void)getJoinClubWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 俱乐部简介 */
- (void)getClubIntroWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 推荐的俱乐部 */
- (void)getSysRecommendedClubListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 我的俱乐部(已加入) */
- (void)getMyJoinClubListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 添加帖子或公告评论 */
- (void)addClubArticleCommentWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 我的俱乐部(所有) */
- (void)getMyAllClubListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
@end
