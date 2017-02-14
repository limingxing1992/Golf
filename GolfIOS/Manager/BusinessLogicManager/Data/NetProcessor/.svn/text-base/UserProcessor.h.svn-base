//
//  UserProcessor.h
//  GolfIOS
//
//  Created by 李明星 on 2016/11/30.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseProcessor.h"

@interface UserProcessor : BaseProcessor


#pragma mark ----------------我的好友

/** 我的好友列表*/
- (void)postMyFriendListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 添加好友发送申请*/
- (void)postMyFriendAddWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 创建好友分组(只有创建名称)*/
- (void)postCreateFriendAddWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 添加好友至分组*/
- (void)postAddFriendToGroupWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 删除好友*/
- (void)postDeleteMyFriendWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 好友分组列表*/
- (void)postMyFriendGroupWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 删除好友分组*/
- (void)postMyFriendDeleteGroupWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 从分组内移除某好友*/
- (void)postMyFriendDeleteFriendFromGroupWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 修改分组名称*/
- (void)postMyFriendEditGroupNameWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 好友申请列表*/
- (void)postMyFriendInviteListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 同意申请（拒绝申请同一个接口）*/
- (void)postMyFriendAllowAddWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 编辑好友分组（包括创建好友分组）*/
- (void)postMyFriendEditGroupInfoWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

#pragma mark ----------------我的关注

/** 我的关注列表*/
- (void)postMyAttentionListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 我的关注数量*/
- (void)postMyAttentionCountWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 我的粉丝列表*/
- (void)postMyFansListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 我的粉丝数量*/
- (void)postMyFansCountWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 关注*/
- (void)postMyAttentionAddWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 取关*/
- (void)postMyAttentionRemoveWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;


#pragma mark ----------------我的收藏

/** 球场收藏列表*/
- (void)postMyFavoritePlaceListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 俱乐部收藏列表*/
- (void)postMyFavoriteClubListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 删除收藏*/
- (void)postMyFavoriteDeleteWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 添加收藏*/
- (void)postMyFavoriteAddWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;


#pragma mark ----------------我的俱乐部
/** 俱乐部过往消息*/
- (void)postMyClubHistoryHistoryClubArticleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 同意申请加入*/
- (void)postMyClubAgreeApplyWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 我的俱乐部详情*/
- (void)postMyClubSelfDetailWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 新申请成员*/
- (void)postMyClubNewApplyUserListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 申请成员详情*/
- (void)postMyClubNewApplyUserDetailWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 我的俱乐部-已加入*/
- (void)postMyClubJoinedListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 我的俱乐部-已创建*/
- (void)postMyClubCreatedListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 我的俱乐部-创建*/
- (void)postMyClubCreateNewWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 我的俱乐部-解散*/
- (void)postMyClubDismissWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 我的俱乐部-退出*/
- (void)postMyClubExitWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 我的俱乐部-拒绝申请*/
- (void)postMyClubRefuseWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;


#pragma mark ----------------我的钱包

/** 余额记录*/
- (void)postMyBirdWalletFillRecordWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 充值*/
- (void)postMyBirdWalletFillWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 获取充值规则*/
- (void)postMyBirdWalletFillRuleWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;


#pragma mark ----------------我的荣誉

/** 我的荣誉主页*/
- (void)postMyLevelGradeListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 我的荣誉升级*/
- (void)postMyLevelUpWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;


#pragma mark ----------------我的帖子

/** 我的帖子列表*/
- (void)postMyArticleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 删除帖子*/
- (void)postMyArticleDeleteWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

#pragma mark ----------------我的订单

/** 订单列表*/
- (void)postMyOrderListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 取消订单*/
- (void)postMyOrderCancelWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 使用*/
- (void)postMyOrderUseParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 评价订单*/
- (void)postMyOrderJugeWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 支付订单*/
- (void)postMyOrderPayWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 订单详情*/
- (void)postMyOrderDetailWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 获取退款规则*/
- (void)postMyOrderReturnRuleWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 申请退款*/
- (void)postMyOrderApplyReturnWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 取消退款*/
- (void)postMyOrderReturnCancelWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

#pragma mark ----------------我的消息

/** 我的动态*/
- (void)postMyMessageListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 系统消息*/
- (void)postMyMessageSystemListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 删除动态*/
- (void)postMyMessageDeleteListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 删除系统消息*/
- (void)postMyMessageSystemDeleteListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 系统消息消息数量*/
- (void)postMyMessageSystemNewNumWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

#pragma mark ----------------我的积分
/** 获取积分兑换列表*/
- (void)postMyPointsConvertListWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;
/** 兑换积分*/
- (void)postMyPointsConverServiceWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

#pragma mark ----------------帖子举报
- (void)postReportWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

@end
