//
//  ChartsManager.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/30.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "ChartsManager.h"
#import "ChartsProcessor.h"

@interface ChartsManager ()

@property (nonatomic, strong) ChartsProcessor *processor;


@end

@implementation ChartsManager

- (instancetype)init{
    self = [super init];
    if (self) {
        _processor = [[ChartsProcessor alloc] init];
    }
    return self;
}


- (void)postChartsScoreListParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postChartsScoreListParameters:parameters
                                       success:^(id responObject) {
                                           if ([responObject[@"status"] isEqualToNumber:@1]) {
                                               ChartsModel *model = [ChartsModel mj_objectWithKeyValues:responObject[@"data"]];
                                               responSuccess(model);

                                           }else{
                                               responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                           }

                                       } failure:^(NSError *error) {
                                           responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                       }];
}

- (void)postChartsHotRankListParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postChartsHotRankListParameters:parameters
                                        success:^(id responObject) {
                                            if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                ChartsModel *model = [ChartsModel mj_objectWithKeyValues:responObject[@"data"]];
                                                responSuccess(model);
                                            }else{
                                                responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                            }
                                        } failure:^(NSError *error) {
                                            responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                        }];
}

- (void)postChartsFightRankListParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postChartsFightRankListParameters:parameters
                                          success:^(id responObject) {
                                              if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                  ChartsModel *model = [ChartsModel mj_objectWithKeyValues:responObject[@"data"]];
                                                  responSuccess(model);
                                              }else{
                                                  responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                              }
                                          } failure:^(NSError *error) {
                                              responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                          }];
}

@end
