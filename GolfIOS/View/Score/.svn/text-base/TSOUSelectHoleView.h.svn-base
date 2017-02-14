//
//  TSOUSelectHoleView.h
//  GolfIOS
//
//  Created by yangbin on 16/11/21.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TSOUSelectHoleView,GroupInfo;

@protocol TSOUSelectHoleViewDelegate <NSObject>

- (void)TSOUSelectHoleView:(TSOUSelectHoleView *)view holeButtonDidClick:(UIButton *)button;

@end

@interface TSOUSelectHoleView : UIView


///**index*/
//@property (nonatomic, assign) int index;
/**delegate*/
@property (nonatomic, assign) id<TSOUSelectHoleViewDelegate> delegate;

- (instancetype)initWithGroupInfo:(GroupInfo *)groupInfo;

- (void)clickBtnAtIndex:(NSInteger)index;
@end
