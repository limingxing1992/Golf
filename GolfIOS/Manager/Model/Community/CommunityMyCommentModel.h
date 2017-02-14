//
//  CommunityMyCommentModel.h
//  GolfIOS
//
//  Created by yangbin on 16/12/8.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseObject.h"
@class CommunityMyCommentDataModel;
@interface CommunityMyCommentModel : BaseObject


/**data*/
@property (nonatomic, strong) CommunityMyCommentDataModel *data;

@end

@interface CommunityMyCommentDataModel : NSObject

/**dataList*/
@property (nonatomic, strong) NSArray *dataList;
/**评价总数*/
@property (nonatomic, strong) NSNumber *totalCommentNum;

@end


@interface CommunityMyComment : NSObject

/**帖子内容*/
@property (nonatomic, strong) NSString *articleContent;
/**帖子id*/
@property (nonatomic, strong) NSString *articleId;
/**评论内容*/
@property (nonatomic, strong) NSString *commentContent;
/**评论数*/
@property (nonatomic, strong) NSNumber *commentNum;
/**创建时间*/
@property (nonatomic, strong) NSString *createTime;
/**评论用户头像*/
@property (nonatomic, strong) NSURL *headUrl;
/**评论id*/
@property (nonatomic, strong) NSNumber *ID;
/**帖子图片*/
@property (nonatomic, strong) NSURL *image;
/**点赞数*/
@property (nonatomic, strong) NSNumber *likedNum;
/**昵称*/
@property (nonatomic, strong) NSString *nickname;
/**帖子类型*/
@property (nonatomic, strong) NSNumber *type;
/**视频地址*/
@property (nonatomic, strong) NSURL *videoUrl;
@end
