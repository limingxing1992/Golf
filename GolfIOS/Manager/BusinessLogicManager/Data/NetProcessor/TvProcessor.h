//
//  TvProcessor.h
//  GolfIOS
//
//  Created by 李明星 on 2016/11/30.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseProcessor.h"

@interface TvProcessor : BaseProcessor

#pragma mark ----------------小鸟投票
/** 人气排行*/
- (void)postTvPopRankListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 热度排行*/
- (void)postTvHotRankListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 票数排行*/
- (void)postTvVoteRankListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 活动列表*/
- (void)postTvActionListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 为候选人点赞*/
- (void)postTvVoteUserWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 热门推荐*/
- (void)postTvRemindListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 投票结果*/
- (void)postTvVoteResultWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 候选人详情*/
- (void)postTvVoteUserDetailInfoWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 活动详情*/
- (void)postTvVoteActionDetailInfoWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;


#pragma mark ----------------小鸟视频

/** 视频列表*/
- (void)postTvVideoListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 视频评论列表*/
- (void)postTvVideoCommentListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 提交视频评论*/
- (void)postTvVideoAddCommentWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;


@end
