//
//  STL_TimePickerView.h
//  GolfIOS
//
//  Created by 李明星 on 2016/12/16.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STL_TimePickerViewDelegate <NSObject>


- (void)sureWithTime:(NSString *)time;

- (void)cancel;


@end

@interface STL_TimePickerView : UIView

@property (nonatomic, assign) id<STL_TimePickerViewDelegate> delegate;
@property (nonatomic, assign) id<STL_TimePickerViewDelegate> delegate_1;


- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title ary:(NSArray *)ary;

@end
