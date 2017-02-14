//
//  TSOTopicCommentCell.h
//  GolfIOS
//
//  Created by yangbin on 16/11/4.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ClubArticleComment,CommunityArticleComment;
@interface TSOTopicCommentCell : UITableViewCell

//这两个模型内部是一样的

/**俱乐部模型model 视频评论也用这个模型 */
@property (nonatomic, strong) ClubArticleComment *model;
/**社区Model*/
@property (nonatomic, strong) CommunityArticleComment *communityModel;



@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) void (^didClickCommentLabelBlock)(NSString *commentId,NSString *commentName, CGRect rectInWindow, NSIndexPath *indexPath,NSInteger commentRow);

@property (nonatomic, copy) void (^didClickContentLabelBlock)();

@end
