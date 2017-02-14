//
//  TSOTabBar.m
//  GolfIOS
//
//  Created by yangbin on 16/10/25.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOTabBar.h"
#import "UIImage+Image.h"
#import "TSONavigationController.h"

@interface TSOTabBar ()

/** 发布按钮 */
@property (nonatomic, weak) UIButton *publishButton;

@end

@implementation TSOTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        // 添加发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"classify19"] forState:UIControlStateNormal];
        publishButton.layer.shadowRadius = 2;
        publishButton.layer.shadowOpacity = 0.2;
        publishButton.layer.shadowOffset = CGSizeMake(0, -1);
//        [publishButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        [publishButton sizeToFit];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
        self.layer.shadowRadius = 3;
        self.layer.shadowOpacity = 0.2;
        self.layer.shadowOffset = CGSizeMake(1, 1);
        self.backgroundImage = [UIImage new];
        self.shadowImage = [UIImage new];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
/** 根控制器模态预订界面*/
- (void)publishClick
{
    AppointmentHomeViewController *vc = [[AppointmentHomeViewController alloc] init];
    TSONavigationController *navi = [[TSONavigationController alloc] initWithRootViewController:vc];
    navi.modalPresentationStyle = UIModalPresentationOverCurrentContext;//ios8坑，必须设置，否则会覆盖下面的界面
    [[[[UIApplication sharedApplication].delegate window] rootViewController] presentViewController:navi animated:YES completion:nil];
    
}

/**
 * 布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.3);
    
    int index = 0;
    
    CGFloat tabBarButtonW = width / 5;
    CGFloat tabBarButtonH = height;
    CGFloat tabBarButtonY = 0;
    
    for (UIView *tabBarButton in self.subviews) {
        if (![NSStringFromClass(tabBarButton.class) isEqualToString:@"UITabBarButton"]) continue;
        
        CGFloat tabBarButtonX = index * tabBarButtonW;
        if (index >= 2) { // 给后面2个button增加一个宽度的X值
            tabBarButtonX += tabBarButtonW;
        }
        
        tabBarButton.frame = CGRectMake(tabBarButtonX, tabBarButtonY, tabBarButtonW, tabBarButtonH);
        
        index++;
    }
}


@end
