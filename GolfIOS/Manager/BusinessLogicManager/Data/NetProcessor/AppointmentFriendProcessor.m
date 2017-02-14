//
//  AppointmentFriendProcessor.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/30.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "AppointmentFriendProcessor.h"
#define AppointmentFriendSendMessage @"app/inviteball/addInviteBall.app"//发送约球邀请
#define AppointmentFriendInviteListInterface @"app/inviteball/inviteBallList.app"//应邀列表
#define AppointmentFriendInviteAddCommentInterface @"app/inviteball/addComment.app" //添加约球评论
#define AppointmentFriendInviteDeleteInterface @"app/inviteball/deleteInviteBall.app" //单个删除邀请
#define AppointmentFriendInviteClearInterface @"app/inviteball/clearInviteBall.app" //清空邀约
#define AppointmentFriendMyInviteListInterface @"app/user/inviteball/myInviteBallList.app"//我的邀请列表
#define AppointmentFriendMyInviteClearInterface @"app/user/inviteball/clearMyInviteBall.app"//清空我的邀请

@implementation AppointmentFriendProcessor

- (void)postAppointmentFriendSendMessageWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:AppointmentFriendSendMessage parameter:parameters success:success failure:failure];
}

- (void)postAppointmentFriendInviteListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:AppointmentFriendInviteListInterface parameter:parameters success:success failure:failure];
}

- (void)postAppointmentFriendInviteDeleteWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:AppointmentFriendInviteDeleteInterface parameter:parameters success:success failure:failure];
}

- (void)postAppointmentFriendInviteClearWithParameterss:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:AppointmentFriendInviteClearInterface parameter:parameters success:success failure:failure];
}

- (void)postAppointmentFriendMyInviteListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:AppointmentFriendMyInviteListInterface parameter:parameters success:success failure:failure];
}

- (void)postAppointmentFriendMyInviteClearWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:AppointmentFriendMyInviteClearInterface parameter:parameters success:success failure:failure];
}

- (void)postAppointmentFriendAddCommentWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:AppointmentFriendInviteAddCommentInterface parameter:parameters success:success failure:failure];
}
@end
