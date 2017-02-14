//
//  LoginProcessor.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/30.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "LoginProcessor.h"

#define LoginInterFace @"app/user/login.do"//登录
#define RegisterInterFace @"app/user/regist.do"//注册
#define RegCodeInterFace @"app/user/getPhoneCode.do"//获取短信验证
#define EditUserInfoInterface @"app/user/editUserInfo.app"//编辑用户信息
#define TieUserInfoInterface @"app/user/boundPhone.do"//绑定第三方账号
#define LoginElseInterface @"app/user/thirdLogin.do"    //第三方登录
#define ReplacePasswordInterface @"app/user/resetPassword.do"//重置密码
#define GETUserMoneyPointsInterface @"app/user/getUserAcountInfo.app"//获取用户余额和积分接口
#define WXAccessTokenInterface @"https://api.weixin.qq.com/sns/oauth2/access_token"//微信开放
#define WXUserInfoInterface @"https://api.weixin.qq.com/sns/userinfo"//微信登录
#define WXAccessTokenRefreshInterface @"https://api.weixin.qq.com/sns/oauth2/refresh_token"//刷新微信token

@implementation LoginProcessor

- (void)postLoginWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:LoginInterFace parameter:parameters success:success failure:failure];
}

- (void)postRegisterWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:RegisterInterFace parameter:parameters success:success failure:failure];
}

- (void)postRegCodeWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:RegCodeInterFace parameter:parameters success:success failure:failure];
}

- (void)postEditUserInfoWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:EditUserInfoInterface parameter:parameters success:success failure:failure];
}

- (void)postTieUserInfoWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:TieUserInfoInterface parameter:parameters success:success failure:failure];
}

- (void)postLoginElseWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:LoginElseInterface parameter:parameters success:success failure:failure];
}

- (void)postReplacePasswordWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:ReplacePasswordInterface parameter:parameters success:success failure:failure];
}

- (void)postUserBanlanceScoreWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:GETUserMoneyPointsInterface parameter:parameters success:success failure:failure];
}

- (void)postWxAccessTokenWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
//    [self afHTTPSessionManagerToServerInteractionWithInterface:WXAccessTokenInterface parameter:parameters success:success failure:failure];
    [self afHTTPSessionManagerToServerInteractionWithUrlString:WXAccessTokenInterface parameter:parameters success:success failure:failure];
}

- (void)postWxUserInfoWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithUrlString:WXUserInfoInterface parameter:parameters success:success failure:failure];
}

- (void)postWxTokenRefreshWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithUrlString:WXAccessTokenRefreshInterface parameter:parameters success:success failure:failure];
}
@end
