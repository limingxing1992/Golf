//
//  CommunityManager.h
//  GolfIOS
//
//  Created by yangbin on 16/12/2.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseManager.h"

@interface CommunityManager : BaseManager

/** 社区帖子列表 */
- (void)getCommunityArticleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;


/** 社区帖子评论列表 */
- (void)getCommunityArticleCommentListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

/** 社区用户信息 */
- (void)getcommunityUserDeailWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

/** 我的关注 */
- (void)getMyAttentionWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

/** 个人空间信息 */
- (void)getCommunityPersonalUserDeailWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

/** 用户社区帖子列表 */
- (void)getUserCommunityArticleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

/** 社区我的评价 */
- (void)getMyCommentListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;
/** 社区发帖 */
- (void)addCommunityArticleWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;
/** 添加社区帖子评论 */
- (void)addCommunityArticleCommentWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;
/** 帖子详情 */
- (void)getCommunityArticleDetailWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;
/** 点赞/取消点赞 */
- (void)addCommunityLikeWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

@end
