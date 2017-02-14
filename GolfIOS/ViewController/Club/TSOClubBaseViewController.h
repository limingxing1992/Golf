//
//  TSOClubBaseViewController.h
//  GolfIOS
//
//  Created by yangbin on 16/11/7.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSOClubBaseViewController : UIViewController

- (void)setupNav;
/**自定义Title*/
@property (nonatomic, strong) NSString *navTitle;

/**左侧按钮图标*/
@property (nonatomic, strong) UIImage *LeftImg;

@end
