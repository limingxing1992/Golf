//
//  PlaceSubmitApointViewController.h
//  GolfIOS
//
//  Created by 李明星 on 2016/11/4.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "STL_BaseViewController.h"

@interface PlaceSubmitApointViewController : STL_BaseViewController
//提交预约订单界面
@property (nonatomic, strong) PlaceComboItemModel *model;//套餐模型
@property (nonatomic, copy) NSString *openTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *placeName;



@end
