//
//  MyInviteCommentCell.h
//  GolfIOS
//
//  Created by yangbin on 16/11/24.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SDTimeLineCellModel;

@protocol MyInviteCommentCellDelegate <NSObject>

- (void)didClickLikeButtonInCell:(UITableViewCell *)cell;
- (void)didClickcCommentButtonInCell:(UITableViewCell *)cell;

@end

@class MyInviteCommentCell;

@interface MyInviteCommentCell : UITableViewCell

@property (nonatomic, weak) id<MyInviteCommentCellDelegate> delegate;

@property (nonatomic, strong) SDTimeLineCellModel *model;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) void (^moreButtonClickedBlock)(NSIndexPath *indexPath);

@property (nonatomic, copy) void (^didClickCommentLabelBlock)(NSString *commentId,NSString *commentName, CGRect rectInWindow, NSIndexPath *indexPath);

/**长按回调*/
@property (nonatomic, copy) NILBlock pressBlock;

@end
