//
//  PlaceSumbitModel.h
//  GolfIOS
//
//  Created by 李明星 on 2016/12/9.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaceSumbitModel : NSObject
/** 打球年*/
@property (nonatomic, assign) NSUInteger playDateYear;
/** 打球日期*/
@property (nonatomic, assign) NSUInteger playDateMonth;
/** 打球日*/
@property (nonatomic, assign) NSUInteger playDateDay;
/** 打球周几*/
@property (nonatomic, copy) NSString *playWeek;
/** 打球开始*/
@property (nonatomic, copy) NSString *starTime;
/** 套餐类型*/
@property (nonatomic, copy) NSString *typeName;
/** 打球人数*/
@property (nonatomic, assign) NSInteger count;
/** 联系人*/
@property (nonatomic, copy) NSString *connectName;
/** 联系电话*/
@property (nonatomic, copy) NSString *connectPhone;
/** 打球备注*/
@property (nonatomic, copy) NSString *connectNotice;
/** 套餐id*/
@property (nonatomic, copy) NSNumber *comboId;
/** 套餐单价*/
@property (nonatomic, copy) NSString *price;


/** 判断当前预订信息是否完善，可以进行预订请求*/
- (BOOL)isCanSubit;

@end
