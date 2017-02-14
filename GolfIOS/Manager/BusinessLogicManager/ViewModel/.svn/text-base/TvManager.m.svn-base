//
//  TvManager.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/30.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TvManager.h"
#import "TvProcessor.h"


@interface TvManager ()

@property (nonatomic, strong) TvProcessor *processor;

@end

@implementation TvManager

- (instancetype)init{
    self = [super init];
    if (self) {
        _processor = [[TvProcessor alloc] init];
    }
    return self;
}

- (void)postTvPopRankListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postTvPopRankListWithParameters:parameters
                                        success:^(id responObject) {
                                            if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                NSArray *data = responObject[@"data"];
                                                NSMutableArray *obj = [NSMutableArray new];
                                                for (NSDictionary *dict in data) {
                                                    TvVoteModel *model = [TvVoteModel mj_objectWithKeyValues:dict];
                                                    [obj addObject:model];
                                                }
                                                responSuccess(obj);
                                            }else{
                                                responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                            }

                                        } failure:^(NSError *error) {
                                            responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                        }];
}

- (void)postTvHotRankListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postTvHotRankListWithParameters:parameters
                                        success:^(id responObject) {
                                            if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                    NSArray *data = responObject[@"data"];
                                                    NSMutableArray *obj = [NSMutableArray new];
                                                    for (NSDictionary *dict in data) {
                                                        TvVoteModel *model = [TvVoteModel mj_objectWithKeyValues:dict];
                                                        [obj addObject:model];
                                                    }
                                                    responSuccess(obj);
                                                }else{
                                                    responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                                }
                                                
                                            }else{
                                                responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                            }

                                        } failure:^(NSError *error) {
                                            responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                        }];

}

- (void)postTvVoteRankListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postTvVoteRankListWithParameters:parameters
                                         success:^(id responObject) {
                                             if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                 
                                                 if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                     NSArray *data = responObject[@"data"];
                                                     NSMutableArray *obj = [NSMutableArray new];
                                                     for (NSDictionary *dict in data) {
                                                         TvVoteModel *model = [TvVoteModel mj_objectWithKeyValues:dict];
                                                         [obj addObject:model];
                                                     }
                                                     responSuccess(obj);
                                                 }else{
                                                     responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                                 }
                                             }else{
                                                 responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                             }

                                         } failure:^(NSError *error) {
                                             responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                         }];

}

- (void)postTvActionListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postTvActionListWithParameters:parameters
                                       success:^(id responObject) {
                                           NSLog(@"%@", responObject);
                                           if ([responObject[@"status"] isEqualToNumber:@1]) {
                                               NSArray *data = responObject[@"data"];
                                               NSMutableArray *obj = [NSMutableArray array];
                                               for (NSDictionary *dict in data) {
                                                   TvVoteActionModel *model = [TvVoteActionModel mj_objectWithKeyValues:dict];
                                                   [obj addObject:model];
                                               }
                                               responSuccess(obj);
                                           }else{
                                               responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                           }

                                       } failure:^(NSError *error) {
                                           responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                       }];

}

- (void)postTvVoteUserWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postTvVoteUserWithParameters:parameters
                                     success:^(id responObject) {
                                         if ([responObject[@"status"] isEqualToNumber:@1]) {
                                             responSuccess(responObject[@"showMessage"]);
                                         }else{
                                             responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                         }

                                     } failure:^(NSError *error) {
                                         responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                     }];

}

- (void)postTvRemindListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postTvRemindListWithParameters:parameters
                                       success:^(id responObject) {
                                           if ([responObject[@"status"] isEqualToNumber:@1]) {
                                               NSArray *data = responObject[@"data"];
                                               NSMutableArray *obj = [NSMutableArray array];
                                               for (NSDictionary *dict in data) {
                                                   TvVoteModel *model = [TvVoteModel mj_objectWithKeyValues:dict];
                                                   [obj addObject:model];
                                               }
                                               responSuccess(obj);
                                           }else{
                                               responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                           }
                                           

                                       } failure:^(NSError *error) {
                                           responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                       }];
}

- (void)postTvVoteResultWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postTvVoteResultWithParameters:parameters
                                       success:^(id responObject) {
                                           if ([responObject[@"status"] isEqualToNumber:@1]) {
                                               NSArray *data = responObject[@"data"];
                                               NSMutableArray *obj = [NSMutableArray array];
                                               for (NSDictionary *dict in data) {
                                                   TvVoteModel *model = [TvVoteModel mj_objectWithKeyValues:dict];
                                                   [obj addObject:model];
                                               }
                                               responSuccess(obj);
                                           }else{
                                               responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                           }
                                       } failure:^(NSError *error) {
                                           responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                       }];
}

- (void)postTvVoteUserDetailInfoWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postTvVoteUserDetailInfoWithParameters:parameters
                                               success:^(id responObject) {
                                                   if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                       TvVoteModel *model = [TvVoteModel mj_objectWithKeyValues:responObject[@"data"]];
                                                       responSuccess(model);
                                                   }else{
                                                       responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                                   }
                                               } failure:^(NSError *error) {
                                                   responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                               }];
}

- (void)postTvVideoListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postTvVideoListWithParameters:parameters
                                      success:^(id responObject) {
                                          if ([responObject[@"status"] isEqualToNumber:@1]) {
                                              NSArray *data = responObject[@"data"];
                                              NSMutableArray *obj = [NSMutableArray array];
                                              for (NSDictionary *dict in data) {
                                                  TvVideoModel *model = [TvVideoModel mj_objectWithKeyValues:dict];
                                                  [obj addObject:model];
                                              }
                                              responSuccess(obj);
                                          }else{
                                              responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                          }

                                      } failure:^(NSError *error) {
                                          responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                      }];
}

- (void)postTvVideoCommentListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postTvVideoCommentListWithParameters:parameters
                                             success:^(id responObject) {
                                                 if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                     responSuccess(responObject);
                                                 }else{
                                                     
                                                 }
                                                 
                                             } failure:^(NSError *error) {
                                                 responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                             }];
}


- (void)postTvVideoAddCommentWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postTvVideoAddCommentWithParameters:parameters
                                             success:^(id responObject) {
                                                 if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                     responSuccess(responObject[@"showMessage"]);
                                                 }else{
                                                     responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                                 }
                                                 
                                             } failure:^(NSError *error) {
                                                 responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                             }];
}

- (void)postTvVoteActionDetailInfoWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postTvVoteActionDetailInfoWithParameters:parameters
                                                 success:^(id responObject) {
                                                     if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                         TvVoteActionModel *model = [TvVoteActionModel mj_objectWithKeyValues:responObject[@"data"]];
                                                         
                                                         responSuccess(model);
                                                     }else{
                                                         responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                                     }
                                                     
                                                 } failure:^(NSError *error) {
                                                     responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                                 }];
}
@end
