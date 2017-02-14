//
//  TSOClubBaseViewController.m
//  GolfIOS
//
//  Created by yangbin on 16/11/7.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOClubBaseViewController.h"
#import "UIImage+Image.h"

@interface TSOClubBaseViewController ()

/**titleLb*/
@property (nonatomic, strong) UILabel *titleLb;
/**leftBtn*/
@property (nonatomic, strong) UIButton *leftBtn;

@end

@implementation TSOClubBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BACKGROUNDCOLOR;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupNav];
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
    _titleLb.text = @"俱乐部";
    
    UIView *title_ve = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    //设置titleview，不过这个view并不是我们需要的居中的view；
    self.navigationItem.titleView = title_ve;
    
    __weak typeof(self) weakSelf = self;
    //主线程列队一个block， 这样做 可以获取到autolayout布局后的frame，也就是titleview的frame。在viewDidLayoutSubviews中同样可以获取到布局后的坐标
    dispatch_async(dispatch_get_main_queue(), ^{
        //要居中view的宽度
        CGFloat width = 120;
        //实际居中的view
//        UIView *center_ve = [[UIView alloc]init];
//        center_ve.backgroundColor = [UIColor greenColor];
        //设置一个基于window居中的坐标
        _titleLb.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-width)/2, 20, width, 44);
        //坐标系转换到titleview
        _titleLb.frame = [weakSelf.view.window convertRect:_titleLb.frame toView:weakSelf.navigationItem.titleView];
        //centerview添加到titleview
        [weakSelf.navigationItem.titleView addSubview:_titleLb];
    });
    

    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"classify36"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftBtn];
    [self.leftBtn sizeToFit];
    [self.leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
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
