//
//  TSOSingleScoringCell.h
//  GolfIOS
//
//  Created by yangbin on 16/11/11.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSOSingleScoringCell,Hole;
@protocol TSOSingleScoringCellDelegate <NSObject>

- (void)tsoSingleScoringCell:(TSOSingleScoringCell *)cell standardNumChanged:(NSNumber *)standardNum;

- (void)tsoSingleScoringCell:(TSOSingleScoringCell *)cell scoreChanged:(NSNumber *)score pushNumChanged:(NSNumber *)pushNum;

@end

@interface TSOSingleScoringCell : UICollectionViewCell

/**delegate*/
@property (nonatomic, assign) id<TSOSingleScoringCellDelegate> delegate;

/**row,当前cell是第几行*/
@property (nonatomic, assign) NSInteger row;

/**标准杆数*/
@property (nonatomic, strong) NSNumber *standardNum;
/**model*/
@property (nonatomic, strong) Hole *model;

@end
