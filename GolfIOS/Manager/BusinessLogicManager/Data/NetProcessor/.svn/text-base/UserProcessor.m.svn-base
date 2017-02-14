//
//  UserProcessor.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/30.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "UserProcessor.h"


#pragma mark ----------------我的好友

#define MyFriendListInterface @"app/userFriend/getAllfriendsByCondition.app"//好友列表
#define MyAddFriendInterface @"app/userFriend/addMyfriends.app"//添加好友
#define MyCreateFriendGroupInterface @"app/userFriend/createFriendsGroup.app"//创建好友分组
#define MyAddFriendToGroupInterface @"app/userFriend/addFriendToGroup.app" //添加好友至分组
#define MyFriendDeleteInterface @"app/userFriend/removeFriends.app" //删除好友
#define MyFriendGropuInterface @"app/userFriend/getAllFriendsGroup.app"//好友分组信息
#define MyFriendGroupDeleteInterface @"app/userFriend/removeFriendsGroup.app"//删除好友分组
#define MyFriendInviteListInterface @"app/userFriend/getValidateFriends.app"    //好友申请列表
#define MyFriendAllowAddInterface @"app/userFriend/agreeBecomeFriend.app"  //同意好友申请
#define MyFriendRefuseAddInterface @"" //拒绝好友申请
#define MyFriendRemoveFriendFromGroup @"app/userFriend/removeFriendsFromGroup.app"//移除分组内某好友
#define MyFriendEditGroupNameInterface @"app/userFriend/editFriendsGroupName.app"//修改分组名称
#define MyFriendEditGroupInfoInterface @"app/userFriend/editFriendsGroup.app"//编辑好友分组信息

#pragma mark ----------------我的关注

#define MyAttentionListInterface @"app/usreFollows/getMyIdos.app"//我的关注列表
#define MyAttentionCountInterface @"app/usreFollows/getIdosCount.app"//关注列表数量
#define MyAttentionAddInterface @"app/usreFollows/addFollow.app"//关注TA
#define MyAttentionRemoveInterface @"app/usreFollows/cancelFollow.app"//取消关注
#define MyFansListInterface @"app/usreFollows/getMyFollows.app"//我的粉丝列表
#define MyFansCountInterface @"app/usreFollows/getFollowsCount.app"//我的粉丝数量

#pragma mark ----------------我的收藏

#define MyFavoritePlaceListInterface @"app/usercollect/getBallPlaceList.app"//我的收藏-球场
#define MyFavoriteClubListInterface @"app/usercollect/getClubArticleList.app"//我的收藏-俱乐部
#define MyFavoriteDeleteInterface @"app/usercollect/deleteCollect.app"//删除收藏
#define MyFavoriteAddInterface @"app/usercollect/addCollect.app"    //添加收藏


#pragma mark ----------------我的俱乐部
#define MyClubHistoryClubArticleListInterface @"app/user/club/findHistoryClubArticleList.app"//我的俱乐部历史消息
#define MyClubAgreeApplyInterface @"app/user/club/agreeApply.app"//我的俱乐部同意申请
#define MyClubSelfDetailInterface @"app/user/club/getClubDeail.app"//我的俱乐部详情
#define MyClubNewApplyUserListInterface @"app/user/club/newJoinCLubUserList.app"//新申请成员
#define MyClubNewApplyUserDetailInterface @"app/user/club/getNewJoinCLubUserDetail.app"//申请成员详情
#define MyClubJoinedListInterface @"app/club/userJoinClubList.app"//我加入俱乐部
#define MyClubCreatedListInterface @"app/club/userCreateClubList.app"//我创建的俱乐部
#define MyClubCreateNewInterface @"app/user/club/createClub.app"//创建俱乐部
#define MyClubDimsmissInterface @"app/user/club/dismissClub.app"//解散俱乐部
#define MyClubExitInterface @"app/user/club/exitClub.app"//退出俱乐部
#define MyClubRefuseInterface @"app/user/club/refuseUser.app"//拒绝加入


#pragma mark ----------------我的钱包
#define MyBirdWalletBalanceRecordInterface @"user/money/getMoneyRecord.app"//余额明细
#define MyBirdWalletFillMoneyInterface @"user/money/charge.app"//充值
#define MyBirdWalletFillRuleInterface @"user/money/gerChargeRuleList.app"//充值规则

#pragma mark ----------------我的荣誉

#define MyLevelGradeListInterface @"app/member/getMyHonorDatail.app"//我的荣誉主页
#define MyLevelUpInterface @"app/member/upGrade.app"//升级会员等级

#pragma mark ----------------我的帖子

#define MyArticleListInterface @"app/user/article/clubArticleList.app"//我的帖子列表
#define MyArticleDeleteInterface @"app/user/article/deleteClubArticle.app"//删除帖子


#pragma mark ----------------订单中心

#define MyOrderListInterface @"app/order/getOrderList.app" //我的订单列表
#define MyOrderCancelInterface @"app/order/cancelOrder.app"//取消订单
#define MyOrderUseInterface @"app/order/consumeOrder.app"//使用
#define MyOrderPayInterface @"app/order/payOrder.app"//支付
#define MyOrderJugeInterface @"app/order/reviewOrder.app"//评价
#define MyOrderDetailInterface @"app/order/getOrderDetail.app"//订单详情
#define MyOrderReturnRuleInterface @"app/order/preApplyRefund.app"//退款规则
#define MyOrderReturnInterface @"app/order/applyRefund.app"//申请退款
#define MyOrderReturnCancelInterface @"app/order/cancelRefund.app"//取消退款


#pragma mark ----------------我的消息
#define MyMessageListInterface @"app/user/dynamic/myDynamicList.app"//我的动态
#define MySystemMessageListInterface @"app/user/msg/sysMsgList.app"//系统消息
#define MySystemMessageNumInterface @"app/user/dynamic/getUnreadNum.app"//未读数量
#define MyMessageDeleteInterface @"app/user/dynamic/deleteDynamic.app"//删除我的动态
#define MySystemMessageDeleteInterface @"app/user/msg/deleteSysMsg.app"//删除系统消息

#pragma mark ----------------我的积分
#define MyPointsConvertListInterface @"app/member/getScoreExchangeService.app"//兑换列表
#define MyPointsConverServicesInterface @"app/member/exchangeService.app"//兑换服务

#pragma mark ----------------举报
#define ReportArticleInterface @"app/report/reportArticle.app"//帖子举报

@implementation UserProcessor


- (void)postMyFriendListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyFriendListInterface parameter:parameters success:success failure:failure];
}

- (void)postMyFriendAddWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyAddFriendInterface parameter:parameters success:success failure:failure];
}

- (void)postCreateFriendAddWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyCreateFriendGroupInterface parameter:parameters success:success failure:failure];
}

- (void)postAddFriendToGroupWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyAddFriendToGroupInterface parameter:parameters success:success failure:failure];
}
- (void)postDeleteMyFriendWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyFriendDeleteInterface parameter:parameters success:success failure:failure];
}

- (void)postMyFriendGroupWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyFriendGropuInterface parameter:parameters success:success failure:failure];
}

- (void)postMyFriendDeleteGroupWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyFriendGroupDeleteInterface parameter:parameters success:success failure:failure];
}

- (void)postMyFriendDeleteFriendFromGroupWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyFriendRemoveFriendFromGroup parameter:parameters success:success failure:failure];
}

- (void)postMyFriendEditGroupNameWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyFriendEditGroupNameInterface parameter:parameters success:success failure:failure];
}

- (void)postMyFriendInviteListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyFriendInviteListInterface parameter:parameters success:success failure:failure];
}

- (void)postMyFriendAllowAddWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyFriendAllowAddInterface parameter:parameters success:success failure:failure];
}

- (void)postMyFriendEditGroupInfoWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyFriendEditGroupInfoInterface parameter:parameters success:success failure:failure];
}

- (void)postMyAttentionListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyAttentionListInterface parameter:parameters success:success failure:failure];
}

- (void)postMyAttentionCountWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyAttentionCountInterface parameter:parameters success:success failure:failure];
}

- (void)postMyFansListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyFansListInterface parameter:parameters success:success failure:failure];
}

- (void)postMyFansCountWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyFansCountInterface parameter:parameters success:success failure:failure];
}

- (void)postMyAttentionAddWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyAttentionAddInterface parameter:parameters success:success failure:failure];
}

- (void)postMyAttentionRemoveWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyAttentionRemoveInterface parameter:parameters success:success failure:failure];
}

- (void)postMyFavoritePlaceListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyFavoritePlaceListInterface parameter:parameters success:success failure:failure];
}

- (void)postMyFavoriteClubListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyFavoriteClubListInterface parameter:parameters success:success failure:failure];
}

- (void)postMyFavoriteDeleteWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyFavoriteDeleteInterface parameter:parameters success:success failure:failure];
}

- (void)postMyFavoriteAddWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyFavoriteAddInterface parameter:parameters success:success failure:failure];
}

- (void)postMyClubHistoryHistoryClubArticleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyClubHistoryClubArticleListInterface parameter:parameters success:success failure:failure];
}

- (void)postMyClubAgreeApplyWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyClubAgreeApplyInterface parameter:parameters success:success failure:failure];
}

- (void)postMyClubSelfDetailWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyClubSelfDetailInterface parameter:parameters success:success failure:failure];
}

- (void)postMyClubNewApplyUserListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyClubNewApplyUserListInterface parameter:parameters success:success failure:failure];
}

- (void)postMyClubNewApplyUserDetailWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyClubNewApplyUserDetailInterface parameter:parameters success:success failure:failure];
}

- (void)postMyClubJoinedListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyClubJoinedListInterface parameter:parameters success:success failure:failure];
}

- (void)postMyClubCreatedListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyClubCreatedListInterface parameter:parameters success:success failure:failure];
}

- (void)postMyClubCreateNewWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyClubCreateNewInterface parameter:parameters success:success failure:failure];
}

- (void)postMyClubDismissWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyClubDimsmissInterface parameter:parameters success:success failure:failure];
}

- (void)postMyClubExitWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyClubExitInterface parameter:parameters success:success failure:failure];
}

- (void)postMyClubRefuseWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyClubRefuseInterface parameter:parameters success:success failure:failure];
}

- (void)postMyBirdWalletFillRecordWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyBirdWalletBalanceRecordInterface parameter:parameters success:success failure:failure];
}

- (void)postMyBirdWalletFillWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyBirdWalletFillMoneyInterface parameter:parameters success:success failure:failure];
}

- (void)postMyBirdWalletFillRuleWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyBirdWalletFillRuleInterface parameter:parameters success:success failure:failure];
}

- (void)postMyLevelGradeListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyLevelGradeListInterface parameter:parameters success:success failure:failure];
}

- (void)postMyLevelUpWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyLevelUpInterface parameter:parameters success:success failure:failure];
}

- (void)postMyArticleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyArticleListInterface parameter:parameters success:success failure:failure];
}

- (void)postMyArticleDeleteWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyArticleDeleteInterface parameter:parameters success:success failure:failure];
}

- (void)postMyOrderListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyOrderListInterface parameter:parameters success:success failure:failure];
}

- (void)postMyOrderCancelWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyOrderCancelInterface parameter:parameters success:success failure:failure];
}

- (void)postMyOrderUseParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyOrderUseInterface parameter:parameters success:success failure:failure];
}

- (void)postMyOrderJugeWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyOrderJugeInterface parameter:parameters success:success failure:failure];
}

- (void)postMyOrderPayWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyOrderPayInterface parameter:parameters success:success failure:failure];
}

- (void)postMyOrderDetailWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyOrderDetailInterface parameter:parameters success:success failure:failure];
}

- (void)postMyOrderReturnRuleWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyOrderReturnRuleInterface parameter:parameters success:success failure:failure];
}

- (void)postMyOrderApplyReturnWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyOrderReturnInterface parameter:parameters success:success failure:failure];
}

- (void)postMyOrderReturnCancelWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyOrderReturnCancelInterface parameter:parameters success:success failure:failure];
}

- (void)postMyMessageListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyMessageListInterface parameter:parameters success:success failure:failure];
}

- (void)postMyMessageSystemListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MySystemMessageListInterface parameter:parameters success:success failure:failure];
}

- (void)postMyMessageDeleteListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyMessageDeleteInterface parameter:parameters success:success failure:failure];
}

- (void)postMyMessageSystemDeleteListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MySystemMessageDeleteInterface parameter:parameters success:success failure:failure];
}

- (void)postMyMessageSystemNewNumWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MySystemMessageNumInterface parameter:parameters success:success failure:failure];
}

- (void)postMyPointsConvertListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyPointsConvertListInterface parameter:parameters success:success failure:failure];
}

- (void)postMyPointsConverServiceWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:MyPointsConverServicesInterface parameter:parameters success:success failure:failure];
}

- (void)postReportWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:ReportArticleInterface parameter:parameters success:success failure:failure];
}

@end
