//
//  MylevelUpSuccessViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2017/1/4.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import "MylevelUpSuccessViewController.h"

@interface MylevelUpSuccessViewController ()

@property (nonatomic, strong) UIImageView *successIv;

/** 升级*/
@property (nonatomic, strong) UILabel *successLb;

/** 提示语*/
@property (nonatomic, strong) UILabel *noticeLb;


/** 返回升级页面*/
@property (nonatomic, strong) UIButton *upLevelBtn;

/** 数据源*/
@property (nonatomic, strong) MyLevelModel *model;



@end

@implementation MylevelUpSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"荣誉升级";
    [self.contentView setBackgroundColor:WHITECOLOR];
    [self.contentView sd_addSubviews:@[self.successIv, self.successLb, self.noticeLb, self.upLevelBtn]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self autoLayoutSubViews];
}


- (void)autoLayoutSubViews{
    
    _successIv.sd_layout
    .topSpaceToView(self.contentView, 90)
    .centerXEqualToView(self.contentView)
    .heightIs(105)
    .widthIs(165);
    
    _successLb.sd_layout
    .topSpaceToView(_successIv, 25)
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    [_successLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _noticeLb.sd_layout
    .topSpaceToView(_successLb, 15)
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    [_noticeLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _upLevelBtn.sd_layout
    .topSpaceToView(_noticeLb, 25)
    .centerXEqualToView(self.contentView)
    .heightIs(44)
    .widthIs(220);
    [_upLevelBtn setSd_cornerRadius:@5];
    
    if (_sort == 5) {
        //已升级到顶级了
        [_upLevelBtn setTitle:@"返回首页" forState:UIControlStateNormal];
    }
}

#pragma mark ----------------界面逻辑
/** 继续升级*/
- (void)againUpLevel{
    if (_sort == 5) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];

    }
}

- (void)loadData{
}

#pragma mark ----------------实例化

- (UIImageView *)successIv{
    if (!_successIv) {
        _successIv = [[UIImageView alloc] initWithImage:IMAGE(@"classify128")];
    }
    return _successIv;
}

- (UILabel *)successLb{
    if (!_successLb) {
        _successLb = [[UILabel alloc] init];
        _successLb.font = FONT(18);
        _successLb.textColor = BLACKTEXTCOLOR;
        NSString *str;
        switch (_sort) {
            case 2:
            {
                str = @"子爵";
            }
                break;
            case 3:
            {
                str = @"伯爵";
            }
                break;
            case 4:
            {
                str = @"侯爵";
            }
                break;
            case 5:
            {
                str = @"公爵";
            }
                break;
            default:
                break;
        }
        _successLb.text = [NSString stringWithFormat:@"您已成功升级为%@！",str];
    }
    return _successLb;
}


- (UILabel *)noticeLb{
    if (!_noticeLb) {
        _noticeLb = [[UILabel alloc] init];
        _noticeLb.font = FONT(15);
        _noticeLb.textColor = BLACKTEXTCOLOR;
        _noticeLb.text = @"赶快去预订球场、一键约球，享受更高的荣誉吧";
    }
    return _noticeLb;
}

- (UIButton *)upLevelBtn{
    if (!_upLevelBtn) {
        _upLevelBtn = [[UIButton alloc] init];
        _upLevelBtn.titleLabel.font = FONT(14);
        _upLevelBtn.backgroundColor = GLOBALCOLOR;
        [_upLevelBtn setTitle:@"继续升级" forState:UIControlStateNormal];
        [_upLevelBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_upLevelBtn addTarget:self action:@selector(againUpLevel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _upLevelBtn;
}

@end
