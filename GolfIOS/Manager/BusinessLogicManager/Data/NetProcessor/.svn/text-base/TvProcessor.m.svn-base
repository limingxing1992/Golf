//
//  TvProcessor.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/30.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TvProcessor.h"

#define TvPopularityRankListInterface @"app/activity/getPopularityRankListPage.app"//人气排行
#define TvHotRankListInterface @"app/activity/getHotRankListPage.app"   //热度排行
#define TvVoteRankListInterface @"app/activity/getVoteRankListPage.app" //票数排行
#define TvActionListInterface @"app/activity/getActivityListPage.app"   //活动列表
#define TvVoteActionDetailInfoInterface @"app/activity/getActivityDetail.app"//活动详情
#define TvVoteUserInterface @"app/activity/voteUser.app"            //活动候选人点赞
#define TvVoteRemindInterface @"app/activity/getAllPerfectUser.do"  //热门推荐
#define TvVoteResultInterface @"app/activity/getActivityVoteRankResult.app"//投票结果
#define TvVoteUserDetailInfoInterface @"app/activity/getUserVoteDetail.app"//候选人详情

#pragma mark ----------------小鸟视频
#define TvVideoListInterface @"app/video/getVideoListPage.app"//视频列表
#define TvViedeoCommentInterface @"app/video/getCommentListByVideoId.app"//视频评论
#define TvAddCommetnInterface @"app/video/saveUserComment.app"//提交视频评论


@implementation TvProcessor

- (void)postTvPopRankListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:TvPopularityRankListInterface parameter:parameters success:success failure:failure];
}

- (void)postTvHotRankListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:TvHotRankListInterface parameter:parameters success:success failure:failure];
}

- (void)postTvVoteRankListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:TvVoteRankListInterface parameter:parameters success:success failure:failure];
}

- (void)postTvActionListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:TvActionListInterface parameter:parameters success:success failure:failure];
}

- (void)postTvVoteUserWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:TvVoteUserInterface parameter:parameters success:success failure:failure];
}

- (void)postTvRemindListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:TvVoteRemindInterface parameter:parameters success:success failure:failure];
}

- (void)postTvVoteResultWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:TvVoteResultInterface parameter:parameters success:success failure:failure];
}

- (void)postTvVideoListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:TvVideoListInterface parameter:parameters success:success failure:failure];
}

- (void)postTvVideoCommentListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:TvViedeoCommentInterface parameter:parameters success:success failure:failure];
}

- (void)postTvVideoAddCommentWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:TvAddCommetnInterface parameter:parameters success:success failure:failure];
}

- (void)postTvVoteUserDetailInfoWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:TvVoteUserDetailInfoInterface parameter:parameters success:success failure:failure];
}

- (void)postTvVoteActionDetailInfoWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:TvVoteActionDetailInfoInterface parameter:parameters success:success failure:failure];
}
@end
