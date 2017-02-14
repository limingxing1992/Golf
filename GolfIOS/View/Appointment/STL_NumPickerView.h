//
//  STL_NumPickerView.h
//  GolfIOS
//
//  Created by 李明星 on 2016/12/16.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STL_NumPickerViewDelegate <NSObject>

@optional

- (void)sureWithCount:(NSInteger)count;

- (void)cancel;


-(void)sureWithCount:(id)count andSelectedTag:(NSInteger)tag;


@end

@interface STL_NumPickerView : UIView

@property (nonatomic, assign) id<STL_NumPickerViewDelegate> delegate;
@property (nonatomic, assign) id<STL_NumPickerViewDelegate> delegate_1;
@property (nonatomic, assign) id<STL_NumPickerViewDelegate> delegate_2;


- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title ary:(NSArray *)ary;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title ary:(NSArray *)ary tag:(NSInteger)tag;

@end
