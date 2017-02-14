//
//  TSOCommentInputView.h
//  GolfIOS
//
//  Created by yangbin on 16/12/16.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YB_UITextField;
@class TSOCommentInputView;

@protocol TSOCommentInputViewDelegate <NSObject>


@optional
- (BOOL)commentInputViewShouldReturn:(TSOCommentInputView *)inputView;
- (void)commentInputViewCommentButtonDidClick:(TSOCommentInputView *)inputView;
- (void)commentInputViewBeginEditing;

@end

@interface TSOCommentInputView : UIView

/**delegate*/
@property (nonatomic, assign) id<TSOCommentInputViewDelegate> delegate;
/**text*/
@property (nonatomic, strong) NSString *text;
/**底部输入框TextField*/
@property (nonatomic, strong) YB_UITextField *inputTF;
@end
