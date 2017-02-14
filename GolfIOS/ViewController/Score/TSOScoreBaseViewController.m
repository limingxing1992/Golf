//
//  TSOScoreBaseViewController.m
//  GolfIOS
//
//  Created by yangbin on 16/11/11.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOScoreBaseViewController.h"


@interface TSOScoreBaseViewController ()


@property (nonatomic, strong) UILabel *titleLb;
/**leftBtn*/
@property (nonatomic, strong) UIButton *leftBtn;

@end

@implementation TSOScoreBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.navigationController.navigationBar.hidden = NO;
}




- (void)setNavTitle:(NSString *)navTitle{
    _navTitle = navTitle;
    _titleLb.text = _navTitle;
}

- (void)setLeftImg:(UIImage *)LeftImg{
    _LeftImg = LeftImg;
    [self.leftBtn setBackgroundImage:_LeftImg forState:UIControlStateNormal];
}

- (void)setupNav{
    _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 17)];
    _titleLb.font = FONT(17);
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.textColor = BLACKTEXTCOLOR;
    _titleLb.text = @"计分";
    [self.navigationItem setTitleView:_titleLb];
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"classify36"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftBtn];
    [self.leftBtn sizeToFit];
    [self.leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
