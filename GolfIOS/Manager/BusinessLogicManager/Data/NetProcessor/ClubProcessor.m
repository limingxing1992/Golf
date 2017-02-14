//
//  ClubProcessor.m
//  GolfIOS
//
//  Created by yangbin on 16/12/2.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "ClubProcessor.h"


/** 俱乐部帖子或公告列表 */
static NSString *const kClubArticleList = @"app/clubArticle/clubArticleList.do";

/** 已加入俱乐部帖子和公告 */
static NSString *const kJoinClubArticleList = @"app/clubArticle/joinClubArticleList.app";

/** 发布公告或帖子 */
static NSString *const kAddClubArticle = @"app/clubArticle/addClubArticle.app";

/** 已推荐公告 */
static NSString *const kClubRecommendNoticeList = @"app/clubArticle/clubRecommendNoticeList.do";
/** 帖子或公告详情 */
static NSString *const kClubGetCubArticleDetail = @"app/clubArticle/getCubArticleDetail.do";
/** 搜索帖子和公告 */
static NSString *const kSearchClubArticleList = @"app/clubArticle/searchClubArticleList.do";
/** 公告或帖子评论 */
static NSString *const kClubArticleCommentList = @"app/clubcomment/clubArticleCommentList.do";
/** 俱乐部首页 */
static NSString *const kClubIndex = @"app/club/clubIndex.do";
/** 申请加入俱乐部 */
static NSString *const kJoinClub = @"app/club/joinClub.app";
/** 俱乐部简介 */
static NSString *const kClubIntro = @"app/club/clubIntro.do";
/** 推荐的俱乐部 */
static NSString *const kSysRecommendedClubList = @"app/club/sysRecommendedClubList.app";
/** 我的俱乐部(已加入) */
static NSString *const kUserJoinClubList = @"app/club/userJoinClubList.app";

/** 我的俱乐部(所有) */
static NSString *const kUserAllClubList = @"app/club/userAllClubList.app";
/** 添加帖子或公告评论 */
static NSString *const kAddClubArticleComment = @"app/clubcomment/addClubArticleComment.app";

@implementation ClubProcessor

- (void)getClubArticleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kClubArticleList parameter:parameters success:success failure:failure];
}

- (void)postClubArticleWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kAddClubArticle parameter:parameters success:success failure:failure];
}

- (void)getJoinedClubArticleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kJoinClubArticleList parameter:parameters success:success failure:failure];
}

- (void)getClubRecommendNoticeListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kClubRecommendNoticeList parameter:parameters success:success failure:failure];
}

- (void)getCubArticleDetailWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kClubGetCubArticleDetail parameter:parameters success:success failure:failure];
}

- (void)searchClubArticleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kSearchClubArticleList parameter:parameters success:success failure:failure];
}

- (void)getClubIndexWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kClubIndex parameter:parameters success:success failure:failure];
}

- (void)getClubArticleCommentListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kClubArticleCommentList parameter:parameters success:success failure:failure];
}

- (void)getJoinClubWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kJoinClub parameter:parameters success:success failure:failure];
}

- (void)getClubIntroWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kClubIntro parameter:parameters success:success failure:failure];
}


- (void)getSysRecommendedClubListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kSysRecommendedClubList parameter:parameters success:success failure:failure];
}

- (void)getMyJoinClubListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kUserJoinClubList parameter:parameters success:success failure:failure];
}

- (void)addClubArticleCommentWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kAddClubArticleComment parameter:parameters success:success failure:failure];
}

- (void)getMyAllClubListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kUserAllClubList parameter:parameters success:success failure:failure];
}
@end
