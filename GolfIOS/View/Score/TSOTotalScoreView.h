//
//  TSOTotalScoreView.h
//  GolfIOS
//
//  Created by yangbin on 16/12/28.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol TSOTotalScoreViewDelegate <NSObject>
//
//- (void)totalScoreViewChangeTotalNum:(NSNumber *)totalNum pushNum:(NSNumber *)pushNum;
//
//@end

typedef void(^ScoreBlock)(NSNumber *totalNum,NSNumber *pushNum);

@interface TSOTotalScoreView : UIView

/**初始分数*/
@property (nonatomic, strong) NSNumber *beginTotalNum;
/**推杆分数*/
@property (nonatomic, strong) NSNumber *pushNum;

/**数值改变回调block*/
@property (nonatomic, copy) ScoreBlock callBack;
/**分数改变回调*/
- (void)scoreChanged:(ScoreBlock)scoreChange;

@end
