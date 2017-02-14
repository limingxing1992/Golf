//
//  MyInviteCommentView.h
//  GolfIOS
//
//  Created by yangbin on 16/11/24.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInviteCommentView : UIView

- (void)setupWithLikeItemsArray:(NSArray *)likeItemsArray commentItemsArray:(NSArray *)commentItemsArray;

@property (nonatomic, copy) void (^didClickCommentLabelBlock)(NSString *commentId,NSString *commentName ,CGRect rectInWindow,NSInteger commentRow);

@end
