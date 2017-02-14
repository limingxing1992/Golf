//
//  ChartsManager.h
//  GolfIOS
//
//  Created by 李明星 on 2016/11/30.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseManager.h"

@interface ChartsManager : BaseManager
/** 积分排行*/
- (void)postChartsScoreListParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;
/** 明日之星排行*/
- (void)postChartsHotRankListParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;
/** 战绩排行*/
- (void)postChartsFightRankListParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

@end
