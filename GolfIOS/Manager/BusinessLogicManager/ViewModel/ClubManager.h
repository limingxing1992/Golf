//
//  ClubManager.h
//  GolfIOS
//
//  Created by yangbin on 16/12/2.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseManager.h"

@interface ClubManager : BaseManager

/** 发布公告或帖子 */
- (void)postClubArticleWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

/** 已加入俱乐部帖子和公告列表 */
- (void)getJoinedClubArticleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

/** 已推荐公告 */
- (void)getClubRecommendNoticeListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

/** 帖子或公告详情 */
- (void)getCubArticleDetailWithParameters:(NSDictionary *)parameters Success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

/** 搜索帖子或公告 */
- (void)searchClubArticleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

/** 公告或帖子评论 */
- (void)getClubArticleCommentListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

/** 俱乐部首页 */
- (void)getClubIndexWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

/** 俱乐部帖子或公告列表 */
- (void)getClubArticleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

/** 申请加入俱乐部 */
- (void)getJoinClubWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;
/** 俱乐部简介 */
- (void)getClubIntroWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;
/** 推荐的俱乐部 */
- (void)getSysRecommendedClubListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

/** 我的俱乐部(已加入) */
- (void)getMyJoinClubListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

/** 我的俱乐部(所有) */
- (void)getMyAllClubListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

/** 添加帖子或公告评论 */
- (void)addClubArticleCommentWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;
/** 上传图片 */
- (void)upLoadImageWith:(NSArray *)imgs parameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

@end
