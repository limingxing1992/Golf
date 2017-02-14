//
//  AppointmentFriendProcessor.h
//  GolfIOS
//
//  Created by 李明星 on 2016/11/30.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseProcessor.h"

@interface AppointmentFriendProcessor : BaseProcessor

/** 发送邀请*/
- (void)postAppointmentFriendSendMessageWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 应邀列表*/
- (void)postAppointmentFriendInviteListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 单个删除*/
- (void)postAppointmentFriendInviteDeleteWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 清空应邀列表*/
- (void)postAppointmentFriendInviteClearWithParameterss:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 邀请列表*/
- (void)postAppointmentFriendMyInviteListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 清空邀请列表*/
- (void)postAppointmentFriendMyInviteClearWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 添加约球评论*/
- (void)postAppointmentFriendAddCommentWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

@end
