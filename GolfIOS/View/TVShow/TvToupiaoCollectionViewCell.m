//
//  TvToupiaoCollectionViewCell.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/29.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TvToupiaoCollectionViewCell.h"


@interface TvToupiaoCollectionViewCell ()
/** 头像*/
@property (nonatomic, strong) UIImageView *headIv;
/** 名字*/
@property (nonatomic, strong) UILabel *nameLb;
/** 票数*/
@property (nonatomic, strong) UILabel *scoreLb;
/** 按钮*/
@property (nonatomic, strong) UIButton *bitBtn;





@end

@implementation TvToupiaoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = WHITECOLOR;
        [self.contentView sd_addSubviews:@[self.headIv,
                                           self.nameLb,
                                           self.scoreLb,
                                           self.bitBtn]];
        [self autoLayoutSubViews];
    }
    return self;
}

- (void)autoLayoutSubViews{
    _headIv.sd_layout
    .topSpaceToView(self.contentView, 4)
    .leftSpaceToView(self.contentView, 4)
    .rightSpaceToView(self.contentView, 4)
    .heightIs(188);
    
    _nameLb.sd_layout
    .topSpaceToView(_headIv, 10)
    .leftSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .autoHeightRatio(0);
    
    _scoreLb.sd_layout
    .topSpaceToView(_nameLb, 10)
    .leftEqualToView(_nameLb)
    .autoHeightRatio(0);
    [_scoreLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _bitBtn.sd_layout
    .bottomSpaceToView(self.contentView, 4)
    .rightSpaceToView(self.contentView, 7.5)
    .heightIs(22)
    .widthIs(60);
    [_bitBtn setSd_cornerRadius:@3];
    
}


#pragma mark ----------------数据

- (void)setModel:(TvVoteModel *)model{
    _model = model;
    [_headIv sd_setImageWithURL:FULLIMGURL(model.headUrl) placeholderImage:Placeholder_middle];
    _nameLb.text = model.name;
    _scoreLb.text = [NSString stringWithFormat:@"%@票",model.voteCnt];
    _bitBtn.enabled = !model.flag;
}


#pragma mark ----------------界面逻辑

- (void)favoriteAction:(UIButton *)btn{
    [SVProgressHUD showWithStatus:@"点赞请求发送中"];
    GOLFWeakObj(self);
    [ShareBusinessManager.tvManager postTvVoteUserWithParameters:@{@"userId":_model.ID}
                                                         success:^(id responObject) {
                                                             [SVProgressHUD showSuccessWithStatus:@"已点赞"];
                                                             NSInteger coun = _model.voteCnt.integerValue + 1;
                                                             weakself.scoreLb.text = [NSString stringWithFormat:@"%ld票",coun];
                                                             btn.enabled = NO;
                                                         } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                             [SVProgressHUD showErrorWithStatus:errorMsg];
                                                         }];
}


#pragma mark ----------------实例

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
        _nameLb.text = @"美女";
    }
    return _nameLb;
}

- (UILabel *)scoreLb{
    if (!_scoreLb) {
        _scoreLb = [[UILabel alloc] init];
        _scoreLb.font = FONT(14);
        _scoreLb.textColor = GLOBALCOLOR;
        _scoreLb.text = @"1111票";
    }
    return _scoreLb;
}

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
        [_bitBtn addTarget:self action:@selector(favoriteAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bitBtn;
}


@end
