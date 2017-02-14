//
//  OrderDetailViewController.h
//  GolfIOS
//
//  Created by 李明星 on 2016/11/3.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "STL_BaseViewController.h"

@interface OrderDetailViewController : STL_BaseViewController

/** 订单状态*/
@property (nonatomic, assign) OrderStyle orderStyle;

@property (nonatomic, strong) MyOrderListItemModel *model;

/** 首页传入订单号*/
@property (nonatomic, copy) NSString *orderNo;

@end
