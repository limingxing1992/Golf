//
//  MyClubHeaderView.h
//  GolfIOS
//
//  Created by wyao on 16/12/16.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyClubHeaderView;

@protocol MyClubHeaderViewDelegate <NSObject>
@optional
/**
 关注
 @param MyClubHeaderView   cell
 @param model 当前俱乐部的模型
 */
- (void)MyClubHeaderView:(MyClubHeaderView *)MyClubHeaderView btnDidClickWithClubModel:(MyClubItemModel *)model btnTag:(NSInteger)btnTag;

@end


@interface MyClubHeaderView : UIView
/** 存放已加入和已创建的数据*/
@property (nonatomic, strong) NSMutableArray *DataList;
/**delegate*/
@property (nonatomic, assign) id<MyClubHeaderViewDelegate> delegate;
@end
