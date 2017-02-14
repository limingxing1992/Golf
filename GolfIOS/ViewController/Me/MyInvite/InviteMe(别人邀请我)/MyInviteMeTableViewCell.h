//
//  MyInviteMeTableViewCell.h
//  GolfIOS
//
//  Created by yangbin on 16/12/13.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDTimeLineCellModel;

@protocol MyInviteMeTableViewCellDelegate <NSObject>
@optional
- (void)didClickLikeButtonInCell:(UITableViewCell *)cell;
- (void)didClickcCommentButtonInCell:(UITableViewCell *)cell;

@end

@interface MyInviteMeTableViewCell : UITableViewCell

@property (nonatomic, weak) id<MyInviteMeTableViewCellDelegate> delegate;

@property (nonatomic, strong) SDTimeLineCellModel *model;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) void (^moreButtonClickedBlock)(NSIndexPath *indexPath);

@property (nonatomic, copy) void (^didClickCommentLabelBlock)(NSString *commentId,NSString *commentName, CGRect rectInWindow, NSIndexPath *indexPath,NSInteger commentRow);

/**长按回调*/
@property (nonatomic, copy) NILBlock pressBlock;

@end
