//
//  ScoreList.h
//  GolfIOS
//
//  Created by yangbin on 16/12/28.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoreList : NSObject

/**头像地址*/
@property (nonatomic, strong) NSURL *headUrl;
/**后半场杆数*/
@property (nonatomic, strong) NSNumber *inBar;
/**昵称*/
@property (nonatomic, strong) NSString *nickName;
/**前半场杆数*/
@property (nonatomic, strong) NSNumber *outBar;
/**总杆数*/
@property (nonatomic, strong) NSNumber *totalBar;
/**总推杆数*/
@property (nonatomic, strong) NSNumber *totalPushPar;
/**用户ID*/
@property (nonatomic, strong) NSNumber *userId;
/**每个洞分数*/
@property (nonatomic, strong) NSArray *holeScore;


@end


@interface Hole : NSObject;

/**实际杆数*/
@property (nonatomic, strong) NSNumber *actualBar;
/**洞编号*/
@property (nonatomic, strong) NSString *hoelNumber;
/**洞Id*/
@property (nonatomic, strong) NSNumber *ID;
/**标准杆*/
@property (nonatomic, strong) NSNumber *par;
/**推杆*/
@property (nonatomic, strong) NSNumber *pushBar;
/**标准杆数*/
@property (nonatomic, strong) NSNumber *standardBar;

@end
