//
//  YB_SliderBtnView.h
//  GolfIOS
//
//  Created by yangbin on 16/11/2.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YB_SliderBtnView;
@protocol YB_SliderBtnViewDelegate <NSObject>

- (void)yb_SliderBtnView:(YB_SliderBtnView *)view buttonDidClicked:(UIButton *)button;

@end

@interface YB_SliderBtnView : UIView

///因为这个方法中使用到了自动布局，所以这个方法要在尺寸都确定后再调用
- (void)setButtonTitleArray:(NSArray *)array;
/**delegate*/
@property (nonatomic, assign) id<YB_SliderBtnViewDelegate> delegate;


/**
 刷新标题

 @param array 标题数组
 */
- (void)refreshButtonTitleWithArray:(NSArray *)array;

@end
