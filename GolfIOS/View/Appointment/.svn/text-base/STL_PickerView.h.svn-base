//
//  STL_PickerView.h
//  GolfIOS
//
//  Created by 李明星 on 2016/12/16.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STL_PickerViewDelegate <NSObject>

- (void)sureWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day week:(NSString *)week;

- (void)cancel;


@end

@interface STL_PickerView : UIView

@property (nonatomic, assign) id<STL_PickerViewDelegate> delegate;
@property (nonatomic, assign) id<STL_PickerViewDelegate> delegate_1;


- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title ary:(NSArray *)ary;


@end
