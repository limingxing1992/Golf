//
//  BusinessManager.m
//  GolfIOS
//
//  Created by 张永亮 on 2016/10/24.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "BusinessManager.h"

@implementation BusinessManager

static BusinessManager *shareBusinessManager = nil;
+ (instancetype)shareBusinessManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareBusinessManager = [[self alloc] init];
    });
    return shareBusinessManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [shareBusinessManager initBusiness];
        shareBusinessManager = [super allocWithZone:zone];
    });
    return shareBusinessManager;
}

- (instancetype)init
{
    if (self = [super init]) {
        [shareBusinessManager initBusiness];
    }
    return self;
}

- (void)initBusiness {
    @autoreleasepool {
        BusinessFactory *factory = [[BusinessFactory alloc] init];
        _appointmentPlaceManager = [factory createAppointmentPlaceManager];
        _appointmentFriendManager = [factory createAppointmentFriendManager];
        _loginManager = [factory createLoginManager];
        _userManager = [factory createUserManager];
        _chartsManager = [factory createChartsManager];
        _tvManager = [factory createTvManager];
        _clubManager = [factory createClubManager];
        _communityManager = [factory createCommunityManager];
        _scoreManager = [factory createScoreManager];
        _homeManager = [factory createHomeManager];
    }
}
@end
