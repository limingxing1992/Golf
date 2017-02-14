//
//  UserModel.h
//  GolfIOS
//
//  Created by 李明星 on 2016/12/2.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserModel : NSObject
/**
 address	地址	string
 areaId	地区Id	number
 cellphone	用户手机号	string
 createTime	注册时间	string
 email	邮箱	string
 gradeId	等级Id
 gradeName	用户等级名称	string
 handicap	差点	number
 headUrl	头像	string
 id	用户id	number
 money	用户小鸟币	number
 name	用户姓名	string
 nickName	用户昵称	string
 password	密码	string
 personSign	个性签名	string
 polesNumber	杆数	number
 score	用户拥有的积分	number
 sex	性别	number	性别：0-保密，1-男，2-女
 sexName	性别备注	string
 sort	等级标识	number
 status	用户状态	number
 statusName	用户状态值	string
 ticket	ticket	string
 type	用户类型	number
 typeName	用户类型备注	string
 userFrom	用户来源	number
 userFromName	用户来源备注	string
 userName	账号	string
 polesNumber	杆数	number
    handicap	差点	number
 */
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








//当前登录状态
@property (nonatomic, assign) BOOL isLogin;

/** 获取用户模型*/
+ (instancetype)sharedUserModel;
//退出登录。清空数据
+(void)attempDealloc;

@end
