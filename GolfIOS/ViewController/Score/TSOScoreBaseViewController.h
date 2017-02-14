//
//  TSOScoreBaseViewController.h
//  GolfIOS
//
//  Created by yangbin on 16/11/11.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSOScoreBaseViewController : UIViewController

- (void)setupNav;
/**自定义Title*/
@property (nonatomic, strong) NSString *navTitle;

/**左侧按钮图标*/
@property (nonatomic, strong) UIImage *LeftImg;

- (void)back;

@end
