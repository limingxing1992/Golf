//
//  BirdWalletViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/8.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "BirdWalletViewController.h"

@interface BirdWalletViewController ()
/** 鸟币背景图*/
@property (nonatomic, strong) UIImageView *birdBackView;
/** 标题*/
@property (nonatomic, strong) UILabel *titleLb;
/** 金额*/
@property (nonatomic, strong) UILabel *balanceLb;
/** 提示语*/
@property (nonatomic, strong) UILabel *noticeLb;
/** 充值*/
@property (nonatomic, strong) UIButton *top_upBtn;
/** 余额明细*/
@property (nonatomic, strong) UIButton *detailBtn;

@end

@implementation BirdWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"我的钱包";
    self.contentView.backgroundColor = WHITECOLOR;
    [self.contentView addSubview:self.birdBackView];
    [self.contentView addSubview:self.noticeLb];
    [self.contentView addSubview:self.top_upBtn];
    [self.contentView addSubview:self.detailBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self autuLayoutSubViews];
    _balanceLb.text = [UserModel sharedUserModel].money;

}

/** 初始化数据*/
- (void)initData{
    
}
/** 自动布局*/
- (void)autuLayoutSubViews{
    _birdBackView.sd_layout
    .topSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .heightIs(158);
    
    _noticeLb.sd_layout
    .topSpaceToView(_birdBackView, 20)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .autoHeightRatio(0);
    
    _top_upBtn.sd_layout
    .topSpaceToView(_noticeLb, 20)
    .centerXEqualToView(self.contentView)
    .heightIs(45)
    .widthIs(220);
    [_top_upBtn setSd_cornerRadius:@5];
    
    _detailBtn.sd_layout
    .topSpaceToView(_top_upBtn, 20)
    .leftEqualToView(_top_upBtn)
    .rightEqualToView(_top_upBtn)
    .heightRatioToView(_top_upBtn, 1);
    [_detailBtn setSd_cornerRadius:@5];
    
    //布局bird
    
    _titleLb.sd_layout
    .centerXEqualToView(_birdBackView)
    .topSpaceToView(_birdBackView, 50)
    .autoHeightRatio(0);
    [_titleLb setSingleLineAutoResizeWithMaxWidth:300];
    
    _balanceLb.sd_layout
    .topSpaceToView(_titleLb, 20)
    .centerXEqualToView(_birdBackView)
    .widthRatioToView(_birdBackView, 1)
    .autoHeightRatio(0);
}


#pragma mark ----------------界面逻辑
/** 跳转充值界面*/
- (void)top_upAction{
    BirdWalletFillViewController *fillVc = [[BirdWalletFillViewController alloc] init];
    [self.navigationController pushViewController:fillVc animated:YES];
}
/** 查看余额明细*/
- (void)balanceDetailInfoAction{
    BirdWalletFillDetailViewController *detailVc = [[BirdWalletFillDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark ----------------实例化

- (UIImageView *)birdBackView{
    if (!_birdBackView) {
        _birdBackView = [[UIImageView alloc] init];
        _birdBackView.image = IMAGE(@"classify111");
        [_birdBackView addSubview:self.titleLb];
        [_birdBackView addSubview:self.balanceLb];
    }
    return _birdBackView;
}

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = FONT(16);
        _titleLb.textColor = WHITECOLOR;
        _titleLb.text = @"鸟币";
    }
    return _titleLb;
}

- (UILabel *)balanceLb{
    if (!_balanceLb) {
        _balanceLb = [[UILabel alloc] init];
        _balanceLb.font = FONT(26);
        _balanceLb.textColor = WHITECOLOR;
        _balanceLb.textAlignment = NSTextAlignmentCenter;
        _balanceLb.text = [UserModel sharedUserModel].money;
    }
    return _balanceLb;
}

- (UILabel *)noticeLb{
    if (!_noticeLb) {
        _noticeLb = [[UILabel alloc] init];
        _noticeLb.font = FONT(16);
        _noticeLb.textColor = SHENTEXTCOLOR;
        _noticeLb.textAlignment = NSTextAlignmentCenter;
        NSInteger sort = [UserModel sharedUserModel].sort + 1;
        NSString *text;
        switch (sort) {
            case 2:
                text = @"子爵";
                break;
            case 3:
                text = @"伯爵";
                break;
            case 4:
                text = @"侯爵";
                break;
            case 5:
                text = @"公爵";
                break;
            case 6:
                text = @"公爵";
                break;
            default:
                break;
        }
        _noticeLb.text = [NSString stringWithFormat:@"升级到%@享受更高的荣誉，积分不够啦，快去充值吧！", text];
        
        if (sort == 6) {
            _noticeLb.text = @"恭喜您已升级成最高级别的会员，可以享受所有的服务内容，会员到期前，请尽快充值，保持最高等级";
        }
    }
    return _noticeLb;
}

- (UIButton *)top_upBtn{
    if (!_top_upBtn) {
        _top_upBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _top_upBtn.backgroundColor = GLOBALCOLOR;
        _top_upBtn.titleLabel.font = FONT(14);
        [_top_upBtn setTitle:@"去充值" forState:UIControlStateNormal];
        [_top_upBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_top_upBtn addTarget:self action:@selector(top_upAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _top_upBtn;
}

- (UIButton *)detailBtn{
    if (!_detailBtn) {
        _detailBtn = [[UIButton alloc] init];
        _detailBtn.backgroundColor = WHITECOLOR;
        _detailBtn.layer.borderColor = GLOBALCOLOR.CGColor;
        _detailBtn.layer.borderWidth = 1;
        _detailBtn.titleLabel.font = FONT(14);
        [_detailBtn setTitle:@"余额明细" forState:UIControlStateNormal];
        [_detailBtn setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
        [_detailBtn addTarget:self action:@selector(balanceDetailInfoAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _detailBtn;
}


@end
