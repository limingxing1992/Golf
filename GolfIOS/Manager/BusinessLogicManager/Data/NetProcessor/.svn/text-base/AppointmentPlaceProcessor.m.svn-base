//
//  AppointmentPlaceProcessor.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/30.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "AppointmentPlaceProcessor.h"

#define AppointmentPlaceListInterface @"app/ball/ballPlaceList.do"            //球场列表
#define AppointmentPlaceIntroduceInterface @"app/ball/getBallPlaceDeail.do"   //球场图文详情
#define AppointmentPlaceDetailInterface @"app/ball/getBallPlaceDeailAndCombo.do" //球场信息和套餐
#define AppointmentPlaceSubmitInterface @"app/order/takeOrder.app"//提交订单
#define AppointmentPlaceCommentInterface @"app/ball/ballPlaceCommnetList.do"//球场评论列表


@implementation AppointmentPlaceProcessor

- (void)postAppointmentPlaceListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:AppointmentPlaceListInterface parameter:parameters success:success failure:failure];
}

- (void)postAppointmentPlaceIntroduceWithParameter:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:AppointmentPlaceIntroduceInterface parameter:parameters success:success failure:failure];
}

- (void)postAppointmentPlaceDetailWithParameter:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    
    [self afHTTPSessionManagerToServerInteractionWithInterface:AppointmentPlaceDetailInterface parameter:parameters success:success failure:failure];
    
}

- (void)postAppointmentPlaceSubmitWithParameter:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:AppointmentPlaceSubmitInterface parameter:parameters success:success failure:failure];
}

- (void)postAppointmentPlaceCommentListWithParameter:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:AppointmentPlaceCommentInterface parameter:parameters success:success failure:failure];
}

@end

