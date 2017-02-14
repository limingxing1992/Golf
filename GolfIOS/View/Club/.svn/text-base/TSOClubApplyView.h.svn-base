//
//  TSOClubApplyView.h
//  GolfIOS
//
//  Created by yangbin on 16/11/10.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TSOClubApplyView;

@protocol TSOClubApplyViewDelegate <NSObject>

- (void)clubApplyViewCancelButtonDidClick;

- (void)clubApplyView:(TSOClubApplyView *)view applyButtonDidClick:(NSString *)reasonStr;

@end

@interface TSOClubApplyView : UIView

/**delegate*/
@property (nonatomic, assign) id<TSOClubApplyViewDelegate> delegate;

@end
