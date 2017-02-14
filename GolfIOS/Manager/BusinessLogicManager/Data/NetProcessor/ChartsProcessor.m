//
//  ChartsProcessor.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/30.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "ChartsProcessor.h"

#define ChartsScoreRankInterface @"app/rank/getScoreRankListPage.app" //积分排行
#define ChartsHotRankInterface @"app/rank/getHotRankListPage.app"//明日之星
#define ChartsFightRankInterface @"app/rank/getFightRankListPageApp.app"//战绩排行


@implementation ChartsProcessor


- (void)postChartsScoreListParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:ChartsScoreRankInterface parameter:parameters success:success failure:failure];
}
- (void)postChartsHotRankListParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:ChartsHotRankInterface parameter:parameters success:success failure:failure];
}

- (void)postChartsFightRankListParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:ChartsFightRankInterface parameter:parameters success:success failure:failure];
}



@end
