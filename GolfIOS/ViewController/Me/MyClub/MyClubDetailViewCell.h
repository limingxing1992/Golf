//
//  ClubDetailViewCell.h
//  GolfIOS
//
//  Created by mac mini on 16/11/15.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyClubDetailViewCell : UITableViewCell
/** 组信息*/
@property (nonatomic,assign) NSInteger  flag;
/** 数据模型*/
@property (nonatomic,strong) MyClubHistoryArcticleItemModel *historyModel;
/** 介绍*/
@property(nonatomic,strong) NSString *introduction;
@end
