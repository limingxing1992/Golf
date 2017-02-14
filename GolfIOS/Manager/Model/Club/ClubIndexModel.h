//
//  ClubIndexModel.h
//  GolfIOS
//
//  Created by yangbin on 16/12/2.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseObject.h"

@class ClubIndex;

@interface ClubIndexModel : BaseObject

/**data*/
@property (nonatomic, strong) ClubIndex *data;

@end


@interface ClubIndex : NSObject

/**俱乐部名称*/
@property (nonatomic, strong) NSString *clubName;
/**俱乐部id*/
@property (nonatomic, strong) NSNumber *ID;
/**是否已经加入*/
@property (nonatomic, strong) NSNumber *isjoin;
/**俱乐部Logo*/
@property (nonatomic, strong) NSURL *logoUrl;
/**总人数*/
@property (nonatomic, strong) NSNumber *totalNum;
/**头像列表*/
@property (nonatomic, strong) NSArray *userHeadUrlList;

@end
