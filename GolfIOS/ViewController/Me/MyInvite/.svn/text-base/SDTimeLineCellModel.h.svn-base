//
//  SDTimeLineCellModel.h
//  GSD_WeiXin(wechat)
//
//  Created by gsd on 16/2/25.
//  Copyright © 2016年 GSD. All rights reserved.
//


#import <Foundation/Foundation.h>

@class SDTimeLineCellLikeItemModel, SDTimeLineCellCommentItemModel;

@interface SDTimeLineCellModel : NSObject

@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *msgContent;
@property (nonatomic, strong) NSArray *picNamesArray;

@property (nonatomic, assign, getter = isLiked) BOOL liked;

@property (nonatomic, strong) NSArray<SDTimeLineCellLikeItemModel *> *likeItemsArray;
@property (nonatomic, strong) NSArray<SDTimeLineCellCommentItemModel *> *commentItemsArray;

@property (nonatomic, assign) BOOL isOpening;

@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;

//yb
/**帖子创建时间*/
@property (nonatomic, strong) NSString *createTime;
/**帖子id*/
@property (nonatomic, strong) NSNumber *articleId;
//yb 应邀列表
/**	联系电话	*/
@property (nonatomic, strong) NSString *contactPhone;
/**头像*/
@property (nonatomic, strong) NSURL *headUrl;
/**邀请id*/
@property (nonatomic, strong) NSNumber *ID;

@end


@interface SDTimeLineCellLikeItemModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSAttributedString *attributedContent;

@end


@interface SDTimeLineCellCommentItemModel : NSObject

@property (nonatomic, copy) NSString *commentString;

@property (nonatomic, copy) NSString *firstUserName;
@property (nonatomic, copy) NSString *firstUserId;

@property (nonatomic, copy) NSString *secondUserName;
@property (nonatomic, copy) NSString *secondUserId;

@property (nonatomic, copy) NSAttributedString *attributedContent;

//yb
/**回复类型*/
@property (nonatomic, strong) NSString *type;
/**评论id*/
@property (nonatomic, strong) NSNumber *ID;

@end
