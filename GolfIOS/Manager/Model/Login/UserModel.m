//
//  UserModel.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/2.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

static dispatch_once_t onceToken;
static UserModel *model;


+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [UserModel sharedUserModel];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _nickName = @"登录/注册";
        _sort = 1;
        _handicap = @"0";
        _polesNumber = @"0";
        _money = @"0.00";
        _score = @"0";
    }
    return self;
}

+ (instancetype)sharedUserModel{
    
    dispatch_once(&onceToken, ^{
        model = [[super allocWithZone:NULL] init];
    });
    return model;
}

- (void)setIsLogin:(BOOL)isLogin{
    _isLogin = isLogin;
    if (_isLogin) {
        [self updateLevelImg];//登录时根据sort排序刷新最新等级图标
    }
}

- (void)setSort:(NSInteger)sort{
    _sort = sort;
    [self updateLevelImg];
}

- (void)updateLevelImg{
    //从1- 5
    NSInteger levelLd = [UserModel sharedUserModel].sort + 147;
    NSString *img = [NSString stringWithFormat:@"classify%ld", levelLd];
    [[UserModel sharedUserModel] setLevelImg:IMAGE(img)];
}

+(void)attempDealloc{
    /** 
     @property (nonatomic, copy) NSString *address;
     @property (nonatomic, copy) NSString *areaId;
     @property (nonatomic, copy) NSString *cellphone;
     @property (nonatomic, copy) NSString *createTime;
     @property (nonatomic, copy) NSString *email;
     @property (nonatomic, copy) NSNumber *gradeId;
     @property (nonatomic, copy) NSString *gradeName;
     @property (nonatomic, copy) NSString *headUrl;
     @property (nonatomic, copy) NSString *ID;
     @property (nonatomic, copy) NSString *money;
     @property (nonatomic, copy) NSString *name;
     @property (nonatomic, copy) NSString *nickName;
     @property (nonatomic, copy) NSString *password;
     @property (nonatomic, copy) NSString *personSign;
     @property (nonatomic, copy) NSString *score;
     @property (nonatomic, assign) NSInteger sex;
     @property (nonatomic, copy) NSString *sexName;
     @property (nonatomic, assign) NSInteger sort;
     @property (nonatomic, copy) NSString *status;
     @property (nonatomic, copy) NSString *statusName;
     @property (nonatomic, copy) NSString *ticket;
     @property (nonatomic, copy) NSString *type;
     @property (nonatomic, copy) NSString *typeName;
     @property (nonatomic, copy) NSString *userFrom;
     @property (nonatomic, copy) NSString *userFromName;
     @property (nonatomic, copy) NSString *userName;
     @property (nonatomic, strong) UIImage *levelImg;    //用户当前等级图标。默认为男爵
     @property (nonatomic, copy) NSString *polesNumber;
     @property (nonatomic, copy) NSString *handicap;

     */
    [[UserModel sharedUserModel] setSort:1];
    [[UserModel sharedUserModel] setNickName:@"登录/注册"];
    [[UserModel sharedUserModel] setSex:1];
    [[UserModel sharedUserModel] setPassword:nil];
    [[UserModel sharedUserModel] setUserName:nil];
    [[UserModel sharedUserModel] setPolesNumber:@"0"];
    [[UserModel sharedUserModel] setHandicap:@"0"];
    [[UserModel sharedUserModel] setMoney:@"0"];
    [[UserModel sharedUserModel] setScore:@"0"];
    [[UserModel sharedUserModel] setHeadUrl:nil];
    [[UserModel sharedUserModel] setIsLogin:NO];
}



@end
