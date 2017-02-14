//
//  MyMessageCommentCell.h
//  GolfIOS
//
//  Created by wyao on 16/11/18.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyMessageCommentCellModel;
@interface MyMessageCommentCell : UITableViewCell
//数据模型
@property (nonatomic,strong) MyMessageCommentCellModel *cellModel;

/**
 * 判断是否是发出的评论还是受到你的评论
 flag : 0 / 收到的评论 ，1/发出的评论
 */
@property (nonatomic, assign)   BOOL flag;

@end
