//
//  HomeInfoModel.h
//  GolfIOS
//
//  Created by yangbin on 16/12/20.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseObject.h"
@class HomeInfo;
@interface HomeInfoModel : BaseObject

/**data*/
@property (nonatomic, strong) HomeInfo *data;

@end


@interface HomeInfo : NSObject

/**广告列表*/
@property (nonatomic, strong) NSArray *adListInfo;
/**订单列表*/
@property (nonatomic, strong) NSArray *indexOrderListInfo;
/**邀请我的*/
@property (nonatomic, strong) HomeInviteMeCellModel *userInviteBall;
/**投票列表*/
@property (nonatomic, strong) NSArray *voteActivityListInfo;
/**社区帖子列表*/
@property (nonatomic, strong) NSArray *communityArticleList;


@end


//MARK: - 广告

@interface AdModel : NSObject

/**id*/
@property (nonatomic, strong) NSNumber *ID;
/**img*/
@property (nonatomic, strong) NSString *img;
/**linkId*/
@property (nonatomic, strong) NSNumber *linkId;
/**lineType*/
@property (nonatomic, strong) NSNumber *linkType;
/**linkTypeName*/
@property (nonatomic, strong) NSString *linkTypeName;
/**title*/
@property (nonatomic, strong) NSString *title;

@end


//MARK: - 滚动订单信息
@interface HomeOrderModel : NSObject

/**handleMessage*/
@property (nonatomic, strong) NSString *handleMessage;
/**orderNo*/
@property (nonatomic, strong) NSString *orderNo;

@end


//MARK: - 邀请我的
@interface HomeInviteMeCellModel : NSObject

/** 内容*/
@property (nonatomic, strong) NSString *content;
/**头像*/
@property (nonatomic, strong) NSURL *headUrl;
/**id*/
@property (nonatomic, strong) NSNumber *ID;
/**球场名称*/
@property (nonatomic, strong) NSString *name;
/**昵称*/
@property (nonatomic, strong) NSString *nickname;


@end
