//
//  STL_AlertCustomView.h
//  GolfIOS
//
//  Created by 李明星 on 2016/12/16.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STL_PickerView.h"
#import "STL_TimePickerView.h"
#import "STL_NumPickerView.h"

@interface STL_AlertCustomView : UIView<STL_PickerViewDelegate, STL_TimePickerViewDelegate, STL_NumPickerViewDelegate>

@property (nonatomic, strong) UIColor *backContentColor;


- (instancetype)initWithFrame:(CGRect)frame customView:(UIView *)customView;

- (void)show;

- (void)dismiss;

@end
