//
//  CommunityProcessor.m
//  GolfIOS
//
//  Created by yangbin on 16/12/2.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "CommunityProcessor.h"

static NSString *const kCommunityArticleList = @"app/community/communityArticleList.do";

static NSString *const kCommunityArticleCommentList = @"app/communitycomment/communityArticleCommentList.do";

static NSString *const kCommunityUserDeail = @"app/community/communityUserDeail.do";

static NSString *const kMyAttention = @"app/community/myAttention.app";

static NSString *const kCommunityPersonalUserDeail = @"app/community/communityPersonalUserDeail.app";
//用户社区帖子列表
static NSString *const kUserCommunityArticleList = @"app/community/userCommunityArticleList.do";
//我的评价列表
static NSString *const kMyCommentList = @"app/communitycomment/myCommentList.app";
//社区发帖
static NSString *const kAddCommunityArticle = @"app/community/addCommunityArticle.app";
//添加社区帖子评论
static NSString *const kAddCommunityArticleComment = @"app/communitycomment/addCommunityArticleComment.app";
//点赞/取消点赞
static NSString *const kAddCommunityLike = @"app/community/addCommunityLike.app";
//帖子详情
static NSString *const kgetCommunityArticleDetail = @"app/community/getCommunityArticleDetail.do";

@implementation CommunityProcessor


- (void)getCommunityArticleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kCommunityArticleList parameter:parameters success:success failure:failure];
}

- (void)getCommunityArticleCommentListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kCommunityArticleCommentList parameter:parameters success:success failure:failure];
}


- (void)getcommunityUserDeailWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kCommunityUserDeail parameter:parameters success:success failure:failure];
}

- (void)getMyAttentionWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kMyAttention parameter:parameters success:success failure:failure];
}




- (void)getCommunityPersonalUserDeailWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kCommunityPersonalUserDeail parameter:parameters success:success failure:failure];
}

- (void)getUserCommunityArticleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kUserCommunityArticleList parameter:parameters success:success failure:failure];
}

- (void)getMyCommentListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kMyCommentList parameter:parameters success:success failure:failure];
}

- (void)addCommunityArticleWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kAddCommunityArticle parameter:parameters success:success failure:failure];
}

- (void)addCommunityArticleCommentWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kAddCommunityArticleComment parameter:parameters success:success failure:failure];
}
- (void)getCommunityArticleDetailWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kgetCommunityArticleDetail parameter:parameters success:success failure:failure];
}

- (void)addCommunityLikeWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kAddCommunityLike parameter:parameters success:success failure:failure];
}
@end
