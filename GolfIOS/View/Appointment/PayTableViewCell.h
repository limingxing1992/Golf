//
//  PayTableViewCell.h
//  GolfIOS
//
//  Created by 李明星 on 2016/11/4.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayTableViewCell : UITableViewCell

@property (nonatomic, copy) OBJBlock block;

- (void)setInfoWith:(NSString *)style;

@end
