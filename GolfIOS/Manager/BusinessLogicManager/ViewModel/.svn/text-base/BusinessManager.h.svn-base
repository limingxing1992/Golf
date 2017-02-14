//
//  BusinessManager.h
//  GolfIOS
//
//  Created by 张永亮 on 2016/10/24.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AppointmentPlaceManager;//预订球场
@class LoginManager;            //登录
@class AppointmentFriendManager;//一键约球
@class TvManager;               //影视娱乐
@class ChartsManager;           //排行榜
@class UserManager;             //个人
@class HomeManager;             //首页

@interface BusinessManager : NSObject
/** 预订球场*/
@property (nonatomic, strong) AppointmentPlaceManager *appointmentPlaceManager;
/** 一键约球*/
@property (nonatomic, strong) AppointmentFriendManager *appointmentFriendManager;
/** 登录*/
@property (nonatomic, strong) LoginManager *loginManager;
/** 个人*/
@property (nonatomic, strong) UserManager *userManager;
/** 排行榜*/
@property (nonatomic, strong) ChartsManager *chartsManager;
/** 影视娱乐*/
@property (nonatomic, strong) TvManager *tvManager;
/**俱乐部*/
@property (nonatomic, strong) ClubManager *clubManager;
/**社区*/
@property (nonatomic, strong) CommunityManager *communityManager;
/**计分*/
@property (nonatomic, strong) ScoreManager *scoreManager;
/**首页*/
@property (nonatomic, strong) HomeManager *homeManager;



/*********************************************************************
 函数名称 : shareBusinessManager:
 函数描述 : 共享默认实例` BusinessManager `。
 输入参数 :
 输出参数 :
 返回值 :
 作者   : 张永亮
 *********************************************************************/
+ (instancetype)shareBusinessManager;

@end
