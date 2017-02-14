//
//  CommunityProcessor.h
//  GolfIOS
//
//  Created by yangbin on 16/12/2.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseProcessor.h"

@interface CommunityProcessor : BaseProcessor

/** 社区帖子列表 */
- (void)getCommunityArticleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 社区帖子评论列表 */
- (void)getCommunityArticleCommentListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 用户信息 */
- (void)getcommunityUserDeailWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 我的关注 */
- (void)getMyAttentionWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;


/** 个人空间信息 */
- (void)getCommunityPersonalUserDeailWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 用户社区帖子列表 */
- (void)getUserCommunityArticleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 社区我的评价 */
- (void)getMyCommentListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;


/** 社区发帖d */
- (void)addCommunityArticleWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;


/** 添加社区帖子评论 */
- (void)addCommunityArticleCommentWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 帖子详情 */
- (void)getCommunityArticleDetailWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 点赞/取消点赞 */
- (void)addCommunityLikeWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

@end
