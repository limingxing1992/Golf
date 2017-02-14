//
//  TSOGroupScoringCell.h
//  GolfIOS
//
//  Created by yangbin on 16/11/16.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSOGroupScoringCell,TSOScroeButton;

@protocol TSOGroupScoringCellDelegate <NSObject>

- (void)tsoGroupScoringCell:(TSOGroupScoringCell *)cell standardBtnDidClick:(TSOScroeButton *)button;

- (void)tsoGroupScoringCell:(TSOGroupScoringCell *)cell scoreBtnDidClick:(TSOScroeButton *)button score:(NSNumber *)score;

@end
@interface TSOGroupScoringCell : UICollectionViewCell



/**dataDict*/
@property (nonatomic, strong) NSMutableArray *dataArray;
/**delegate*/
@property (nonatomic, assign) id<TSOGroupScoringCellDelegate> delegate;

@end
