//
//  TSOCommunityBaseViewController.m
//  GolfIOS
//
//  Created by yangbin on 16/11/4.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOCommunityBaseViewController.h"

@interface TSOCommunityBaseViewController ()

/**titleLb*/
@property (nonatomic, strong) UILabel *titleLb;

@end

@implementation TSOCommunityBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    self.view.backgroundColor = BACKGROUNDCOLOR;
}


- (void)setNavTitle:(NSString *)navTitle{
    _navTitle = navTitle;
    _titleLb.text = _navTitle;
}

- (void)setupNav{
    _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 17)];
    _titleLb.font = FONT(17);
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.textColor = BLACKTEXTCOLOR;
    _titleLb.text = @"在线社区";
    [self.navigationItem setTitleView:_titleLb];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"classify36"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button sizeToFit];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    [SVProgressHUD dismiss];
}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
