//
//  LoginProcessor.h
//  GolfIOS
//
//  Created by 李明星 on 2016/11/30.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseProcessor.h"

@interface LoginProcessor : BaseProcessor
/** 登录*/
- (void)postLoginWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 注册*/
- (void)postRegisterWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 获取短信验证码*/
- (void)postRegCodeWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 修改用户信息*/
- (void)postEditUserInfoWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 第三方绑定*/
- (void)postTieUserInfoWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 第三方登录*/
- (void)postLoginElseWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 重置密码*/
- (void)postReplacePasswordWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 获取用户余额和积分接口*/
- (void)postUserBanlanceScoreWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

/** 获取微信access*/
- (void)postWxAccessTokenWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 获取微信登录登录*/
- (void)postWxUserInfoWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 刷新微信token*/
- (void)postWxTokenRefreshWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

@end
