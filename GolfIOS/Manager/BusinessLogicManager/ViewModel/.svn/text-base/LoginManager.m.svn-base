//
//  LoginManager.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/30.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "LoginManager.h"
#import "LoginProcessor.h"

@interface LoginManager ()

@property (nonatomic, strong) LoginProcessor *processor;


@end

@implementation LoginManager

- (instancetype)init{
    self = [super init];
    if (self) {
        _processor = [[LoginProcessor alloc] init];
    }
    return self;
}


- (void)postLoginWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postLoginWithParameters:parameters success:^(id responObject) {
        if ([responObject[@"status"] isEqualToNumber:@1]) {
            //
            NSDictionary *data = responObject[@"data"];
            [[UserModel sharedUserModel] mj_setKeyValues:data];
            [[UserModel sharedUserModel] setIsLogin:YES];
            [GOLFUserDefault setObject:data forKey:@"userInfo"];//缓存用户资料
            
            [GOLFNotificationCenter postNotificationName:LoginSuccess object:nil];
            
            responSuccess(responObject[@"resParam"]);
            
        }else{
            [[UserModel sharedUserModel] setIsLogin:NO];
            responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
        }
    } failure:^(NSError *error) {
        [[UserModel sharedUserModel] setIsLogin:NO];
        responFailure(0, [weakself analyticalHttpErrorDescription:error]);
    }];
}

-(void)tagsAliasCallback:(int)iResCode
                    tags:(NSSet*)tags
                   alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}


- (void)postRegisterWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postRegisterWithParameters:parameters
                                   success:^(id responObject) {
                                       if ([responObject[@"status"] isEqualToNumber:@1]) {
                                           responSuccess(responObject[@"showMessage"]);
                                       }else{
                                           responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                       }
                                   }
                                   failure:^(NSError *error) {
                                       responFailure(0, [weakself analyticalHttpErrorDescription:error]);
 
                                   }];
}

- (void)postRegCodeWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postRegCodeWithParameters:parameters
                                  success:^(id responObject) {
                                      if ([responObject[@"status"] isEqualToNumber:@1]) {
                                          responSuccess(responObject[@"showMessage"]);
                                      }else{
                                          responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                      }
                                  }
                                  failure:^(NSError *error) {
                                      responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                  }];
}

- (void)postEditUserInfoWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postEditUserInfoWithParameters:parameters
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

- (void)postTieUserInfoWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postTieUserInfoWithParameters:parameters
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

- (void)postLoginElseWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postLoginElseWithParameters:parameters
                                    success:^(id responObject) {
                                        if ([responObject[@"status"] isEqualToNumber:@1]) {
                                            NSDictionary *data = responObject[@"data"];
                                            [[UserModel sharedUserModel] mj_setKeyValues:data];
                                            [[UserModel sharedUserModel] setIsLogin:YES];
                                            [GOLFUserDefault setObject:data forKey:@"userInfo"];//缓存用户资料
                                            responSuccess(responObject[@"resParam"]);
                                        }else{
                                            responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                        }
                                    } failure:^(NSError *error) {
                                        responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                    }];
}

- (void)postReplacePasswordWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postReplacePasswordWithParameters:parameters
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

- (void)postUserBanlanceScoreWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postUserBanlanceScoreWithParameters:parameters
                                            success:^(id responObject) {
                                                if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                    responSuccess(responObject[@"data"]);
                                                }else{
                                                    responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                                }
 
                                            } failure:^(NSError *error) {
                                                responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                            }];
}

- (void)postWxAccessTokenWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postWxAccessTokenWithParameters:parameters
                                        success:^(id responObject) {
                                            responSuccess(responObject);
                                        } failure:^(NSError *error) {
                                            responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                        }];
}

- (void)postWxUserInfoWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postWxUserInfoWithParameters:parameters
                                     success:^(id responObject) {
                                         responSuccess(responObject);
                                     } failure:^(NSError *error) {
                                         responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                     }];
}

- (void)postWxTokenRefreshWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postWxTokenRefreshWithParameters:parameters
                                         success:^(id responObject) {
                                             responSuccess(responObject);
                                         } failure:^(NSError *error) {
                                             responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                         }];
}
@end
