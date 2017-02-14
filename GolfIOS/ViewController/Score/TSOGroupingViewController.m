//
//  TSOGroupingViewController.m
//  GolfIOS
//
//  Created by yangbin on 16/12/31.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TSOGroupingViewController.h"
#import "TSOAddPlayerButton.h"
#import "ScoreUserModel.h"
#import "ScoreUser.h"

@interface TSOGroupingViewController ()

/**HeadView*/
@property (nonatomic, strong) TSOAddPlayerButton *headView;
/**lineVIew*/
@property (nonatomic, strong) UIView *lineView;
/**zhandui*/
@property (nonatomic, strong) UILabel *zhanduiLb;
/**userModel*/
@property (nonatomic, strong) ScoreUserModel *model;

@end

@implementation TSOGroupingViewController


- (instancetype)initWithUser:(ScoreUserModel *)userModel{
    if (self = [super init]) {
        self.model = userModel;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITECOLOR;
    [self.view addSubview:self.headView];
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.zhanduiLb];
    self.headView.sd_layout
    .topSpaceToView(self.view, 30 + 64)
    .centerXEqualToView(self.view)
    .widthIs(100 *KHeight_Scale)
    .heightIs(100 *KHeight_Scale);
    
    
    
    self.lineView.sd_layout
    .topSpaceToView(self.headView, 70)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(0.5);
    
    self.zhanduiLb.sd_layout
    .topSpaceToView(self.lineView, 15)
    .leftSpaceToView(self.view, 15)
    .autoHeightRatio(0);
    [self.zhanduiLb setSingleLineAutoResizeWithMaxWidth:100];
    
    NSInteger i = 0;
    for (ScoreUser *user in self.model.data) {
        
        if (i == 0) {
            
            [self.headView sd_setImageWithURL:[YB_Tools fullIconUrl:user.headUrl] forState:UIControlStateNormal];
            
            [self.headView setTitle:user.nickName forState:UIControlStateNormal];
        }else{
            TSOAddPlayerButton *playerBtn = [[TSOAddPlayerButton alloc] init];
            [playerBtn sd_setImageWithURL:[YB_Tools fullIconUrl:user.headUrl] forState:UIControlStateNormal];
            
            [playerBtn setTitle:user.nickName forState:UIControlStateNormal];
            [playerBtn setTitleColor:BLACKTEXTCOLOR forState:UIControlStateNormal];
            [self.view addSubview:playerBtn];
//            playerBtn.size = CGSizeMake(90, 44);
//            playerBtn.center = CGPointMake(self.view.center.x, CGRectGetMaxX(self.lineView.frame) + (i-1) *44 + 20);
            playerBtn.sd_layout
            .centerXIs(self.view.centerX - 30)
            .topSpaceToView(self.lineView, (i-1) *44 + 50)
            .widthIs(44)
            .heightIs(65);
            
            UILabel *label = [[UILabel alloc] init];
            label.text = @"已加入";
            label.font = FONT(12);
            label.textColor = SHENTEXTCOLOR;
            [self.view addSubview:label];
            label.sd_layout
            .leftSpaceToView(playerBtn, 30)
            .centerYEqualToView(playerBtn)
            .autoHeightRatio(0)
            .widthIs(50);
            
        }
        
        i++;
    }
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    
    
}

- (void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (TSOAddPlayerButton *)headView{
    if (_headView == nil) {
        _headView = [[TSOAddPlayerButton alloc] init];
    }
    return _headView;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = GRAYCOLOR;
    }
    return _lineView;
}

- (UILabel *)zhanduiLb{
    if (_zhanduiLb == nil) {
        _zhanduiLb = [[UILabel alloc] init];
        _zhanduiLb.font = FONT(18);
        _zhanduiLb.text = @"战队";
        _zhanduiLb.textColor = BLACKTEXTCOLOR;
    }
    return _zhanduiLb;
}

@end
