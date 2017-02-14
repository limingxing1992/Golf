//
//  TSOHomeCommunityTableViewCell.h
//  GolfIOS
//
//  Created by yangbin on 16/11/2.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSOHomeCommunityTableViewCell,CommunityArticle;

@protocol TSOHomeCommunityTableViewCellDelegate <NSObject>
@optional
- (void)tSOHomeCommunityTableViewCell:(TSOHomeCommunityTableViewCell *)cell nameLabelDidClick:(NSString *)name;


/**
 关注

 @param cell cell
 @param userId 关注用户的id
 */
- (void)tSOHomeCommunityTableViewCell:(TSOHomeCommunityTableViewCell *)cell focusBtnDidClick:(NSString *)userId;

@end


@interface TSOHomeCommunityTableViewCell : UITableViewCell

/**model*/
@property (nonatomic, strong) CommunityArticle *model;

/**delegate*/
@property (nonatomic, assign) id<TSOHomeCommunityTableViewCellDelegate> delegate;

/**点赞*/
@property (nonatomic, copy) OBJBlock likeCallBack;

- (void)hideFocusBtn;

@end
