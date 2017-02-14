//
//  TSOClubHeadView.h
//  GolfIOS
//
//  Created by yangbin on 16/11/9.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ClubIndexModel;
@interface TSOClubHeadView : UIView

- (void)applyBtnAddTarget:(id)target action:(SEL)action;

- (void)nameLabelAddTarget:(id)target action:(SEL)action;

/**model*/
@property (nonatomic, strong) ClubIndexModel *model;

@end
