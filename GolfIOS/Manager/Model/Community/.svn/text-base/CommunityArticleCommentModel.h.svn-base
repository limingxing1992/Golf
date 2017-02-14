//
//  CommunityArticleCommentModel.h
//  GolfIOS
//
//  Created by Rock on 2016/12/4.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseObject.h"

@class PagerModel,CommunityArticleCommentDataModel;

@interface CommunityArticleCommentModel : BaseObject
/**data*/
@property (nonatomic, strong) CommunityArticleCommentDataModel *data;
@end


@interface CommunityArticleCommentDataModel : NSObject

/**dataList*/
@property (nonatomic, strong) NSArray *dataList;
/**pager*/
@property (nonatomic, strong) PagerModel *pager;

@end

@interface CommunityArticleComment : NSObject


/**评论集合*/
@property (nonatomic, strong) NSMutableArray *commentItemsArray;
/**内容*/
@property (nonatomic, strong) NSString *content;
/**创建时间*/
@property (nonatomic, strong) NSString *createTime;
/**头像*/
@property (nonatomic, strong) NSURL *headUrl;
/**评论id*/
@property (nonatomic, strong) NSNumber *ID;
/**昵称*/
@property (nonatomic, strong) NSString *nickname;

@end
