//
//  TSOTabBarController.m
//  GolfIOS
//
//  Created by yangbin on 16/10/25.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOTabBarController.h"
#import "TSOTabBar.h"
#import "TSONavigationController.h"

#import "TSOHomeViewController.h"
//#import "TSOScoreViewController.h"
#import "TSOCommunityViewController.h"
#import "TSOMeViewController.h"
#import "TSOScoreHomePageVC.h"

@interface TSOTabBarController ()

@end

@implementation TSOTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabBar];
    [self setupChildVcs];
    [self setupItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 处理TabBar
 */
- (void)setupTabBar
{
    [self setValue:[[TSOTabBar alloc] init] forKeyPath:@"tabBar"];
}

/**
 * 添加所有的子控制器
 */
- (void)setupChildVcs
{
    [self setupChildVc:[[TSOHomeViewController alloc] init] title:@"首页" image:@"classify24" selectedImage:@"classify20"];
    [self setupChildVc:[[TSOScoreHomePageVC alloc] init] title:@"计分" image:@"classify25" selectedImage:@"classify21"];
    [self setupChildVc:[[TSOCommunityViewController alloc] init] title:@"社区" image:@"classify26" selectedImage:@"classify22"];
    [self setupChildVc:[[TSOMeViewController alloc] init] title:@"我的" image:@"classify27" selectedImage:@"classify23"];
    
}

/**
 * 添加一个子控制器
 * @param title 文字
 * @param image 图片
 * @param selectedImage 选中时的图片
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    TSONavigationController *nav = [[TSONavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
    
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:image];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
}

/**
 * 设置item属性
 */
- (void)setupItem
{

    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = SHENTEXTCOLOR;
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    
    selectedAttrs[NSForegroundColorAttributeName] = GLOBALCOLOR;
   
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}


@end
