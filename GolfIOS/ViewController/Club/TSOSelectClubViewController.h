//
//  TSOSelectClubViewController.h
//  GolfIOS
//
//  Created by yangbin on 16/11/9.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOClubBaseViewController.h"

@protocol TSOSelectClubViewControllerDelegate <NSObject>

- (void)selectClubViewControllerSelectedClubs:(NSArray *)clubIds;

@end

@interface TSOSelectClubViewController : TSOClubBaseViewController

/**delegate*/
@property (nonatomic, assign) id<TSOSelectClubViewControllerDelegate> delegate;

@end
