//
//  ScoreRecordModel.h
//  GolfIOS
//
//  Created by yangbin on 16/12/29.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseObject.h"
@class ScoreRecordData;
@interface ScoreRecordModel : BaseObject


/**data*/
@property (nonatomic, strong) ScoreRecordData *data;


@end

@interface ScoreRecordData : NSObject

/**记录列表*/
@property (nonatomic, strong) NSArray *scoreRecordList;
/**杆数*/
@property (nonatomic, strong) NSString *userMaxBar;

@end

@interface ScoreRecord : NSObject;

/**球场名称*/
@property (nonatomic, strong) NSString *ballPlaceName;
/**创建时间*/
@property (nonatomic, strong) NSString *createTime;
/**组id*/
@property (nonatomic, strong) NSString *groupId;
/**场次id*/
@property (nonatomic, strong) NSString *ID;
/**状态*/
@property (nonatomic, strong) NSNumber *status;
/**状态名称	*/
@property (nonatomic, strong) NSString *statusName;
/**总杆数*/
@property (nonatomic, strong) NSString *totalBar;
/**是否记录创建者*/
@property (nonatomic, assign) BOOL createor;

@end
