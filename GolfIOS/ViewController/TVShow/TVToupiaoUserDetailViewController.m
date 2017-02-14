//
//  TVToupiaoUserDetailViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/22.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TVToupiaoUserDetailViewController.h"

@interface TVToupiaoUserDetailViewController ()<UIWebViewDelegate>
/** 用头像*/
@property (nonatomic, strong) UIImageView *headIv;
/** 昵称*/
@property (nonatomic, strong) UILabel *nameLb;
/** 票数*/
@property (nonatomic, strong) UILabel *scoreLb;
/** 点赞按钮*/
@property (nonatomic, strong) UIButton *bitBtn;
/** 图文详情*/
@property (nonatomic, strong) UIWebView *webView;
/** 候选人详情*/
@property (nonatomic, strong) TvVoteModel *detailModel;
/** 底部视图*/
@property (nonatomic, strong) UIView *bottomView;
/** 电话*/
@property (nonatomic, strong) UIButton *phoneBtn;
/** 微信*/
@property (nonatomic, strong) UIButton *wxBtn;




@end

@implementation TVToupiaoUserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"小鸟投票";
    [self.contentView setBackgroundColor:WHITECOLOR];
    [self.contentView addSubview:self.headIv];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.scoreLb];
    [self.contentView addSubview:self.bitBtn];
    [self.contentView addSubview:self.webView];
    [self.view addSubview:self.bottomView];
    [self loadData];
    [self autoLayoutSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark ----------------数据刷新

- (void)loadData{
    [SVProgressHUD show];
    GOLFWeakObj(self);
    [ShareBusinessManager.tvManager postTvVoteUserDetailInfoWithParameters:@{@"userId":_model.ID}
                                                                   success:^(id responObject) {
                                                                       weakself.detailModel = responObject;
                                                                       [weakself updateInfo];
                                                                       [SVProgressHUD dismiss];
                                                                   } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                       [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                   }];;
}

- (void)updateInfo{
    [_headIv sd_setImageWithURL:FULLIMGURL(_detailModel.headUrl) placeholderImage:Placeholder_middle];
    _nameLb.text = _detailModel.name;
    _scoreLb.text = [NSString stringWithFormat:@"%@票",_detailModel.voteCnt];
    _bitBtn.enabled = !_detailModel.flag;
    [_webView loadHTMLString:_detailModel.article baseURL:nil];
    
    [_phoneBtn setTitle:_detailModel.cellphone forState:UIControlStateNormal];
    [_wxBtn setTitle:_detailModel.contact forState:UIControlStateNormal];
}


#pragma mark ----------------布局界面
/** 自动布局*/
- (void)autoLayoutSubViews{
    _headIv.sd_layout
    .topSpaceToView(self.contentView, 25)
    .leftSpaceToView(self.contentView, 10)
    .widthIs(85)
    .heightEqualToWidth();
    [_headIv setSd_cornerRadius:@5];
    
    _nameLb.sd_layout
    .topSpaceToView(self.contentView, 33)
    .leftSpaceToView(_headIv, 15)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
//
    _scoreLb.sd_layout
    .centerYEqualToView(_headIv)
    .leftEqualToView(_nameLb)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
//
    _bitBtn.sd_layout
    .topSpaceToView(_scoreLb, 13)
    .leftEqualToView(_scoreLb)
    .heightIs(22)
    .widthIs(60);
    [_bitBtn setSd_cornerRadius:@3];
    
    _webView.sd_layout
    .topSpaceToView(_headIv, 37.5)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0);
    
    
    [self.contentView setupAutoContentSizeWithBottomView:_webView  bottomMargin:75];
    
    _bottomView.sd_layout
    .bottomSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(50);
    
    _phoneBtn.sd_layout
    .centerYEqualToView(_bottomView)
    .centerXIs(SCREEN_WIDTH/4)
    .heightIs(17)
    .widthIs(120);
    
    _wxBtn.sd_layout
    .centerYEqualToView(_bottomView)
    .centerXIs(SCREEN_WIDTH/4 * 3)
    .heightIs(17)
    .widthIs(120);

}

#pragma mark ----------------点赞

- (void)favoriteActionUserDetail:(UIButton *)btn{
    [SVProgressHUD showWithStatus:@"点赞请求发送中"];
    GOLFWeakObj(self);
    [ShareBusinessManager.tvManager postTvVoteUserWithParameters:@{@"userId":_model.ID}
                                                         success:^(id responObject) {
                                                             [SVProgressHUD showSuccessWithStatus:@"已点赞"];
                                                             weakself.scoreLb.text = [NSString stringWithFormat:@"%ld票",weakself.detailModel.voteCnt.integerValue + 1];
                                                             btn.enabled = NO;
                                                         } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                             [SVProgressHUD showErrorWithStatus:errorMsg];
                                                         }];
}

#pragma mark ----------------webView代理

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    CGRect frame = webView.frame;
    
    frame.size.width = SCREEN_WIDTH;
    
    frame.size.height = 1;
    
    webView.scrollView.scrollEnabled = NO;
    
    webView.frame = frame;
    
    frame.size.height = webView.scrollView.contentSize.height + 20;
    
    
    webView.frame = frame;
    
    [SVProgressHUD dismiss];

}


#pragma mark ----------------实例

- (UIButton *)bitBtn{
    if (!_bitBtn) {
        _bitBtn = [[UIButton alloc] init];
        _bitBtn.backgroundColor = GLOBALCOLOR;
        _bitBtn.titleLabel.font = FONT(13.5);
        [_bitBtn setTitle:@"赞她" forState:UIControlStateNormal];
        [_bitBtn setTitle:@"已赞" forState:UIControlStateDisabled];
        [_bitBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_bitBtn setImage:IMAGE(@"classify192") forState:UIControlStateNormal];
        [_bitBtn setImage:IMAGE(@"classify193") forState:UIControlStateDisabled];
        [_bitBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -3, 0.0, 0.0)];
        [_bitBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, -3)];
        [_bitBtn addTarget:self action:@selector(favoriteActionUserDetail:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bitBtn;
}

- (UIImageView *)headIv{
    if (!_headIv) {
        _headIv = [[UIImageView alloc] init];
        _headIv.image = Placeholder_middle;
    }
    return _headIv;
}

- (UILabel *)nameLb{
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] init];
        _nameLb.font = FONT(12);
        _nameLb.textColor = BLACKTEXTCOLOR;
        _nameLb.text = @"未知用户";
    }
    return _nameLb;
}

- (UILabel *)scoreLb{
    if (!_scoreLb) {
        _scoreLb = [[UILabel alloc] init];
        _scoreLb.font = FONT(14);
        _scoreLb.textColor = GLOBALCOLOR;
        _scoreLb.text = @"0票";
    }
    return _scoreLb;
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        _webView.opaque = NO;
        _webView.scrollView.scrollEnabled = NO;
        _webView.backgroundColor = ClearColor;
    }
    return _webView;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = WHITECOLOR;
        _bottomView.layer.borderWidth = 0.5;
        _bottomView.layer.borderColor= GRAYCOLOR.CGColor;
        [_bottomView addSubview:self.phoneBtn];
        [_bottomView addSubview:self.wxBtn];
        UIView *lineView= [[UIView  alloc] init];
        lineView.backgroundColor= GRAYCOLOR;
        [_bottomView addSubview:lineView];
        lineView.sd_layout
        .centerYEqualToView(_bottomView)
        .centerXEqualToView(_bottomView)
        .widthIs(0.5)
        .heightIs(35);
        
    }
    return _bottomView;
}

- (UIButton *)phoneBtn{
    if (!_phoneBtn) {
        _phoneBtn = [[UIButton alloc] init];
        _phoneBtn.titleLabel.font = FONT(15);
        [_phoneBtn setTitleColor:BLACKTEXTCOLOR forState:UIControlStateNormal];
        [_phoneBtn setImage:IMAGE(@"classify222") forState:UIControlStateNormal];
        [_phoneBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    }
    return _phoneBtn;
}

- (UIButton *)wxBtn{
    if (!_wxBtn) {
        _wxBtn = [[UIButton alloc] init];
        _wxBtn.titleLabel.font = FONT(15);
        [_wxBtn setTitleColor:BLACKTEXTCOLOR forState:UIControlStateNormal];
        [_wxBtn setImage:IMAGE(@"classify223") forState:UIControlStateNormal];
        [_wxBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];

    }
    return _wxBtn;
}

@end
