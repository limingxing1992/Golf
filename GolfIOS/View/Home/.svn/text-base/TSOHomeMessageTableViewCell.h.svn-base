//
//  TSOHomeMessageTableViewCell.h
//  GolfIOS
//
//  Created by yangbin on 16/11/1.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeInfoModel;

@protocol TSOHomeMessageTableViewCellDelegate <NSObject>

- (void)homeMessageTableViewCellMessageDidClick:(NSString *)orderNo;

@end
@interface TSOHomeMessageTableViewCell : UITableViewCell

/**model*/
@property (nonatomic, strong) HomeInfoModel *model;

/**delegate*/
@property (nonatomic, assign) id<TSOHomeMessageTableViewCellDelegate> delegate;
@end
