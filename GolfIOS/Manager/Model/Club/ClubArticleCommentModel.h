//
//  ClubArticleCommentModel.h
//  GolfIOS
//
//  Created by yangbin on 16/12/5.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseObject.h"

@interface ClubArticleCommentModel : BaseObject

/**dataList*/
@property (nonatomic, strong) NSMutableArray *data;

@end



@interface ClubArticleComment : NSObject

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


