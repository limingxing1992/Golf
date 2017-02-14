//
//  AppointmentPlaceManager.h
//  GolfIOS
//
//  Created by 李明星 on 2016/11/30.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseManager.h"

@interface AppointmentPlaceManager : BaseManager

/** 球场列表*/
- (void)postAppointmentPlaceListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;
/** 球场信息和套餐*/
- (void)postAppointmentPlaceDetailWithParameter:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;
/** 球场图文详情*/
- (void)postAppointmentPlaceIntroduceWithParameter:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;
/** 提交订单*/
- (void)postAppointmentPlaceSubmitWithParameter:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;

/** 评论列表*/
- (void)postAppointmentPlaceCommentListWithParameter:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;
@end
