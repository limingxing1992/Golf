//
//  AppointmentFriendManager.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/30.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "AppointmentFriendManager.h"
#import "AppointmentFriendProcessor.h"

@interface AppointmentFriendManager ()

@property (nonatomic, strong) AppointmentFriendProcessor *processor;


@end

@implementation AppointmentFriendManager

- (instancetype)init{
    self =[super init];
    if (self) {
        _processor = [[AppointmentFriendProcessor alloc] init];
    }
    return self;
}


- (void)postAppointmentFriendSendMessageWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postAppointmentFriendSendMessageWithParameters:parameters
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

- (void)postAppointmentFriendInviteListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postAppointmentFriendInviteListWithParameters:parameters
                                                      success:^(id responObject) {
                                                          //应邀列表数据
                                                          NSLog(@"应邀列表数据%@", responObject);
                                                          if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                              
                                                              responSuccess(responObject);
                                                              
                                                          }else{
                                                              responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                                          }
                                                      } failure:^(NSError *error) {
                                                          responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                                      }];
}

- (void)postAppointmentFriendInviteDeleteWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postAppointmentFriendInviteDeleteWithParameters:parameters
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

- (void)postAppointmentFriendInviteClearWithParameterss:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postAppointmentFriendInviteClearWithParameterss:parameters
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


- (void)postAppointmentFriendMyInviteListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postAppointmentFriendMyInviteListWithParameters:parameters
                                                        success:^(id responObject) {
                                                            //我的邀请列表数据
                                                            NSLog(@"我的邀请列表数据%@", responObject);
                                                            if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                                
                                                                responSuccess(responObject);
                                                                
                                                            }else{
                                                                responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                                            }

                                                        } failure:^(NSError *error) {
                                                            responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                                        }];
}

- (void)postAppointmentFriendMyInviteClearWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postAppointmentFriendMyInviteClearWithParameters:parameters
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

- (void)postAppointmentFriendAddCommentWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postAppointmentFriendAddCommentWithParameters:parameters
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
@end
