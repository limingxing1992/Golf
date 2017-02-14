//
//  AppointmentPlaceProcessor.h
//  GolfIOS
//
//  Created by 李明星 on 2016/11/30.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseProcessor.h"

@interface AppointmentPlaceProcessor : BaseProcessor


/** 球场列表*/
- (void)postAppointmentPlaceListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 球场信息和套餐*/
- (void)postAppointmentPlaceDetailWithParameter:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 球场图文详情*/
- (void)postAppointmentPlaceIntroduceWithParameter:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 提交订单*/
- (void)postAppointmentPlaceSubmitWithParameter:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 评论列表*/
- (void)postAppointmentPlaceCommentListWithParameter:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

@end
