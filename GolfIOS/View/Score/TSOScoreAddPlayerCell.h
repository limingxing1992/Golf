//
//  TSOScoreAddPlayerCell.h
//  GolfIOS
//
//  Created by yangbin on 16/12/26.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSOScoreAddPlayerCell : UITableViewCell

/**players*/
@property (nonatomic, strong) NSArray *players;

/**按钮点击回调*/
@property (nonatomic, copy) OBJBlock playBtnDidClick;

/**增加玩家*/
@property (nonatomic, copy) NILBlock addPlayer;

@end
