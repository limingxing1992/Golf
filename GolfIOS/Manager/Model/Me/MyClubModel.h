//
//  MyClubModel.h
//  GolfIOS
//
//  Created by 李明星 on 2016/12/12.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClubModel : NSObject
/**
 checkNum	审核人数	number
 clubName	俱乐部名称	string
 id	俱乐部Id	number
 introduction	介绍	string
 logoUrl	图片地址	string
 totalNum	总数	number
 */
@property (nonatomic, copy) NSString *checkNum;
@property (nonatomic, copy) NSString *clubName;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *introduction;
@property (nonatomic, copy) NSString *logoUrl;
@property (nonatomic, copy) NSString *totalNum;



@end


@interface MyClubHistoryArcticleItemModel : NSObject
/**
 
 createTime	创建时间	string
 id	帖子id	number
 logoUrl	图片	string
 title	标题	string
 
 */

@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *logoUrl;
@property (nonatomic, copy) NSString *title;


@end

@interface MyClubItemModel : NSObject
/**
 
 clubId	俱乐部Id	number
 clubName	俱乐部名称	string
 logoUrl	俱乐部图片	string
 
 */
@property (nonatomic, copy) NSString *clubId;
@property (nonatomic, copy) NSString *clubName;
@property (nonatomic, copy) NSString *logoUrl;

@end

/** 我的帖子模型*/
@interface MyArticleItemModel : NSObject
/**
 
 clubName	俱乐部名称	string
 createTime	发帖时间	string
 id	帖子Id	number
 logoUrl	片	string
 title	标题	string
 type	类型	number	10 公告 20 帖子
 */

@property (nonatomic, copy) NSString *clubName;

@property (nonatomic, copy) NSString *commentNum;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *logoUrl;
/**文章图片集合*/
@property (nonatomic, strong) NSArray *imgList;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *type;


@end


/** 新申请成员列表模型*/
@interface MyClubNewJoinListModel : NSObject

/** 等级Id*/
@property (nonatomic, copy) NSString *gradeId;
/** 等级名称*/
@property (nonatomic, copy) NSString *gradeName;
/** 图片地址*/
@property (nonatomic, copy) NSString *headUrl;
/** 成员id*/
@property (nonatomic, copy) NSNumber *ID;
/** 成员昵称*/
@property (nonatomic, copy) NSString *nickname;
/** 成员性别*/
@property (nonatomic, copy) NSString *sex;
/** 成员等级*/
@property (nonatomic, copy) NSString *sort;
/** 成员城市*/
@property (nonatomic, copy) NSString *address;
/** 年龄*/
@property (nonatomic, copy) NSString *age;
/** 申请Id*/
@property (nonatomic, copy) NSNumber *applyId;
/** 差点*/
@property (nonatomic, copy) NSString *handicap;
/** 申请加入俱乐部原因*/
@property (nonatomic, copy) NSString *joinReason;
/** 杆数*/
@property (nonatomic, copy) NSString *toalBar;



@end

@interface MyMessageItemModel : NSObject

/**  articleId	帖子id	number
 content	内容	string	社区内容 公告或帖子内容
 createTime	时间	string
 headUrl	头像	string
 id		number
 nickName	昵称	string
 title	点赞	string	只有公告或帖子有标题
 type	类型	string	10:俱乐部帖子评论 20 社区评论 30 社区点赞 40 关注我
 */

@property (nonatomic, copy) NSString *articleId;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *headUrl;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger type;

@end


@interface MyMessageSysModel : NSObject
/** 内容*/
@property (nonatomic, copy) NSString *content;
/** 消息id*/
@property (nonatomic, copy) NSString *ID;
/** 发送时间*/
@property (nonatomic, copy) NSString *pushTime;
@end

@interface MyMessageSysNumModel : NSObject
/** 动态消息数目*/
@property (nonatomic, copy) NSString *dynamicNum;
/** 系统消息数目*/
@property (nonatomic, copy) NSString *sysMsgNum;

@end

