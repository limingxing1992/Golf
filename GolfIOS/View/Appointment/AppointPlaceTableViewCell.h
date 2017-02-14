//
//  AppointPlaceTableViewCell.h
//  GolfIOS
//
//  Created by 李明星 on 2016/11/2.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointPlaceTableViewCell : UITableViewCell

@property (nonatomic, strong) PlaceItemModel *model;

/** 隐藏价格标签 */
- (void)hidePriceLabel;

@end
