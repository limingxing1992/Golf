//
//  MyClubViewCell.h
//  GolfIOS
//
//  Created by mac mini on 16/11/14.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MyClubViewCell;

@protocol MyClubViewCellDelegate <NSObject>
@optional
/**
 关注
 
 @param cell   cell
 @param clubId 当前俱乐部的id
 */
- (void)MyClubViewCell:(MyClubViewCell *)cell btnDidClickWithClubId:(NSString *)clubId btnTag:(NSInteger)btnTag;

@end

@interface MyClubViewCell : UITableViewCell
/** 判断是第几个控制器*/
@property (nonatomic,assign) NSUInteger pageColumn;
/** 数据模型*/
@property (nonatomic,strong) MyClubItemModel *model;
/**delegate*/
@property (nonatomic, assign) id<MyClubViewCellDelegate> delegate;
@end
