//
//  TSOScoringViewController.h
//  GolfIOS
//
//  Created by yangbin on 16/11/11.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOScoreBaseViewController.h"

@class StandardHoleListModel,ScoreInfo;

@interface TSOScoringViewController : TSOScoreBaseViewController
//当创建比赛的时候，来自接口18个洞标准杆。当第二次进入比赛的时候标准杆有可能会被改变，所以给cell赋值的时候先判断scoreInfo模型中的标准杆是否有数据。这个问题是因为接口的不标准。
/**标准杆模型 */
@property (nonatomic, strong) StandardHoleListModel *standHolesModel;

- (instancetype)initWithScoreInfo:(ScoreInfo *)scoreInfo;

@end
