//
//  AppoinmentPlaceDetailViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/22.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "AppoinmentPlaceDetailViewController.h"

@interface AppoinmentPlaceDetailViewController ()
/** 创建时间*/
@property (nonatomic, strong) UILabel *timeLb;
/** web*/
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation AppoinmentPlaceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"球场详情";
    self.isAutoBack = NO;
    [self.view sd_addSubviews:@[self.timeLb, self.webView]];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self autoLayoutSubViews];
}

/** 自动布局*/
- (void)autoLayoutSubViews{
    _timeLb.sd_layout
    .topSpaceToView(self.view, 20 + NaviBar_HEIGHT)
    .leftSpaceToView(self.view, 15)
    .rightSpaceToView(self.view, 15)
    .autoHeightRatio(0);
    
    _webView.sd_layout
    .topSpaceToView(_timeLb, 20)
    .leftSpaceToView(self.view, 15)
    .rightSpaceToView(self.view, 15)
    .bottomSpaceToView(self.view, 0);
    
}

#pragma mark ----------------数据

- (void)loadData{
    if (!_ballPlaceId) {
        [SVProgressHUD showErrorWithStatus:@"参数错误"];
        return;
    }
    GOLFWeakObj(self);
    [SVProgressHUD showWithStatus:@"努力加载中"];
    
    [ShareBusinessManager.appointmentPlaceManager postAppointmentPlaceIntroduceWithParameter:@{@"ballPlaceId":_ballPlaceId}
                                                                                     success:^(id responObject) {
                                                                                         [weakself updateUIWithDictonary:responObject];
                                                                                         [SVProgressHUD dismiss];
                                                                                     }
                                                                                     failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                                         [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                                         //返回上级页面
                                                                                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                                                             [weakself.navigationController popViewControllerAnimated:YES];
                                                                                         });
                                                                                     }];
}

- (void)updateUIWithDictonary:(NSDictionary *)dict{
    _timeLb.text = [NSString stringWithFormat:@"创建于%@",dict[@"createDate"]];
    
    NSString *str = dict[@"detail"];
    if ([str isEqual:[NSNull null]] || !str) {
        [SVProgressHUD showErrorWithStatus:@"暂无详情"];
        return;
    }
    [_webView loadHTMLString:str baseURL:nil];
}


#pragma mark ----------------实例

- (UILabel *)timeLb{
    if (!_timeLb) {
        _timeLb = [[UILabel alloc] init];
        _timeLb.font = FONT(14);
        _timeLb.textColor = LIGHTTEXTCOLOR;
        _timeLb.text = @"创建于2016-09-01";
    }
    return _timeLb;
}


- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.opaque = NO;
        _webView.backgroundColor = WHITECOLOR;
    }
    return _webView;
}

@end
