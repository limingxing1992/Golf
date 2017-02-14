//
//  MyClubArticleTableViewCell.h
//  GolfIOS
//
//  Created by wyao on 16/12/21.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyClubArticleTableViewCell,MyArticleItemModel;

@protocol MyClubArticleTableViewCellDelegate <NSObject>
@optional

- (void)MyClubArticleTableViewCell:(MyClubArticleTableViewCell *)cell nameLabelDidClick:(NSString *)name;
@end


@interface MyClubArticleTableViewCell : UITableViewCell

/**model*/
@property (nonatomic, strong) MyArticleItemModel *model;

/**delegate*/
@property (nonatomic, assign) id<MyClubArticleTableViewCellDelegate> delegate;

@end
