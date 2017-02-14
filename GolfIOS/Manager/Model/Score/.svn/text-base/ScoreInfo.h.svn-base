//
//  ScoreInfo.h
//  GolfIOS
//
//  Created by yangbin on 16/12/28.
//  Copyright © 2016年 TSou. All rights reserved.
//  比赛开始时候返回的信息

#import "BaseObject.h"
@class ScoreInfoData,GroupInfo;
@interface ScoreInfo : BaseObject

/**data*/
@property (nonatomic, strong) ScoreInfoData *data;

@end

@interface ScoreInfoData : NSObject
/**分组ID*/
@property (nonatomic, strong) NSString *groupId;

/**参加比赛的用户*/
@property (nonatomic, strong) NSArray *groupUserList;

/**scoreList*/
@property (nonatomic, strong) NSArray *scoreList;

/**组信息  用于再次进入比赛*/
@property (nonatomic, strong) GroupInfo *groupInfo;



@end

@interface GroupInfo : NSObject;

/**后半场名称*/
@property (nonatomic, strong) NSString *afterField;
/**前半场名称*/
@property (nonatomic, strong) NSString *beforeField;
/**球场名称*/
@property (nonatomic, strong) NSString *ballPlaceName;
/**创建时间*/
@property (nonatomic, strong) NSString *createTime;

@end
