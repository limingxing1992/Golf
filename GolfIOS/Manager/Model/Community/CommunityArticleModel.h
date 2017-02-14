//
//  CommunityArticleModel.h
//  GolfIOS
//
//  Created by Rock on 2016/12/4.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseObject.h"
@class PagerModel,CommunityArticleDataModel;
@interface CommunityArticleModel : BaseObject

/**data*/
@property (nonatomic, strong) CommunityArticleDataModel *data;
@end


@interface CommunityArticleDataModel : NSObject

/**dataList*/
@property (nonatomic, strong) NSArray *dataList;
/**pager*/
@property (nonatomic, strong) PagerModel *pager;

@end

@interface CommunityArticle : NSObject

/**评论数*/
@property (nonatomic, strong) NSNumber *commentNum;
/**内容*/
@property (nonatomic, strong) NSString *content;
/**创建名称*/
@property (nonatomic, strong) NSString *createTime;
/**用户等级*/
@property (nonatomic, strong) NSString *gradeName;
/**头像*/
@property (nonatomic, strong) NSURL *headUrl;
/**文章id*/
@property (nonatomic, strong) NSNumber *ID;
/**文章图片集合*/
@property (nonatomic, strong) NSArray *imgList;
/**是否关注*/
@property (nonatomic, assign) BOOL isfollow;
/**是否喜欢*/
@property (nonatomic, assign) BOOL islike;
/**是否评论过*/
@property (nonatomic, assign) BOOL iscomment;
/**点赞数*/
@property (nonatomic, strong) NSString *likedNum;
/**mdf*/
@property (nonatomic, strong) NSString *mdf;
/**昵称*/
@property (nonatomic, strong) NSString *nickname;
/**类型*/
@property (nonatomic, strong) NSNumber *type;
/**用户id*/
@property (nonatomic, strong) NSNumber *userId;
/**视频地址*/
@property (nonatomic, strong) NSURL *videoUrl;
/**等级*/
@property (nonatomic, strong) NSNumber *sort;

/**内容详情--俱乐部详情页*/
@property (nonatomic, strong) NSString *contentDetail;

@end
