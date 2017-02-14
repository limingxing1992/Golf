//
//  TVShowViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/15.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TVShowViewController.h"

@interface TVShowViewController ()
/** 投票*/
@property (nonatomic, strong) UIButton *voteBtn;
/** 视频*/
@property (nonatomic, strong) UIButton *tvBtn;
/** 投票图片*/
@property (nonatomic, strong) UIImageView *voteIv;
/** 投票名字*/
@property (nonatomic, strong) UILabel *voteLb;
/** 视频图标*/
@property (nonatomic, strong) UIImageView *tvIv;
/** 视频名字*/
@property (nonatomic, strong) UILabel *tvLb;





@end

@implementation TVShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"影视乐";
    self.isAutoBack = NO;
    [self.view addSubview:self.voteBtn];
    [self.view addSubview:self.tvBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    CGFloat height = (SCREEN_HEIGHT- NaviBar_HEIGHT)/2;
    
    _voteBtn.sd_layout
    .topSpaceToView(self.view, NaviBar_HEIGHT)
    .leftSpaceToView(self.view, 0)
    .heightIs(height)
    .widthIs(SCREEN_WIDTH);
    
    
    _tvBtn.sd_layout
    .topSpaceToView(_voteBtn, 0)
    .rightSpaceToView(self.view, 0)
    .heightRatioToView(_voteBtn, 1)
    .widthIs(SCREEN_WIDTH);
    
    _voteIv.sd_layout
    .centerXEqualToView(_voteBtn)
    .centerYEqualToView(_voteBtn)
    .heightIs(140)
    .widthIs(225);
    
    _voteLb.sd_layout
    .topSpaceToView(_voteIv, 13)
    .centerXEqualToView(_voteIv)
    .autoHeightRatio(0);
    [_voteLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    
    _tvIv.sd_layout
    .centerXEqualToView(_tvBtn)
    .centerYEqualToView(_tvBtn)
    .heightIs(140)
    .widthIs(225);
    
    _tvLb.sd_layout
    .topSpaceToView(_tvIv, 13)
    .centerXEqualToView(_tvIv)
    .autoHeightRatio(0);
    [_tvLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];

}



#pragma mark ----------------界面逻辑
/** 进入投票*/
- (void)castVoteAction{
    if (!IsLogin) {
        [self presentViewController:LoginNavi animated:YES completion:nil];
    }else{
        TVTouPiaoViewController *touVc = [[TVTouPiaoViewController alloc] init];
        [self.navigationController pushViewController:touVc animated:YES];
    }
}
/** 进入小鸟视频*/
- (void)intoTvAction{
    if (!IsLogin) {
        [self presentViewController:LoginNavi animated:YES completion:nil];
    }else{
        
        TvVideoListViewController *listVc = [[TvVideoListViewController alloc] init];
        [self.navigationController pushViewController:listVc animated:YES];
    }

}


#pragma mark ----------------实例

- (UIButton *)voteBtn{
    if (!_voteBtn) {
        _voteBtn = [[UIButton alloc] init];
        [_voteBtn addSubview:self.voteIv];
        [_voteBtn addSubview:self.voteLb];
        [_voteBtn setBackgroundColor:RGBColor(155, 234, 253)];
        [_voteBtn addTarget:self action:@selector(castVoteAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _voteBtn;
}

- (UIButton *)tvBtn{
    if (!_tvBtn) {
        _tvBtn = [[UIButton alloc] init];
        [_tvBtn addSubview:self.tvIv];
        [_tvBtn addSubview:self.tvLb];
        [_tvBtn setBackgroundColor:RGBColor(109, 221, 160)];
        [_tvBtn addTarget:self action:@selector(intoTvAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tvBtn;
}

- (UIImageView *)voteIv{
    if (!_voteIv) {
        _voteIv = [[UIImageView alloc] init];
        _voteIv.image = IMAGE(@"classify232");
    }
    return _voteIv;
}

- (UILabel *)voteLb{
    if (!_voteLb) {
        _voteLb = [[UILabel alloc] init];
        _voteLb.font = FONT(22);
        _voteLb.textColor = SHENTEXTCOLOR;
        _voteLb.text = @"小鸟投票";
    }
    return _voteLb;
}

- (UIImageView *)tvIv{
    if (!_tvIv) {
        _tvIv = [[UIImageView alloc] init];
        _tvIv.image = IMAGE(@"classify233");
    }
    return _tvIv;
}

- (UILabel *)tvLb{
    if (!_tvLb) {
        _tvLb = [[UILabel alloc] init];
        _tvLb.font = FONT(22);
        _tvLb.textColor = SHENTEXTCOLOR;
        _tvLb.text = @"小鸟视频";
    }
    return _tvLb;
}

@end
