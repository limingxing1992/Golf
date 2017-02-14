//
//  LoginManager.h
//  GolfIOS
//
//  Created by 李明星 on 2016/11/30.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseManager.h"

@interface LoginManager : BaseManager
/** 登录*/
- (void)postLoginWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;
/** 注册*/
- (void)postRegisterWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;
/** 获取短信验证码*/
- (void)postRegCodeWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;
/** 修改用户信息*/
- (void)postEditUserInfoWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;
/** 第三方绑定*/
- (void)postTieUserInfoWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;
/** 第三方登录*/
- (void)postLoginElseWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;
/** 重置密码*/
- (void)postReplacePasswordWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;
/** 获取用户余额和积分接口*/
- (void)postUserBanlanceScoreWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;
/** 获取微信*/
- (void)postWxAccessTokenWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;
/** 获取微信登录登录*/
- (void)postWxUserInfoWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;
/** 刷新微信token*/
- (void)postWxTokenRefreshWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

@end
