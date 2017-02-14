//
//  TVShowVoteTableViewCell.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/15.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TVShowVoteTableViewCell.h"

@interface TVShowVoteTableViewCell ()
/** 画板*/
@property (nonatomic, strong) UIView *backView;
/** 头像*/
@property (nonatomic, strong) UIImageView *headIv;
/** 名字*/
@property (nonatomic, strong) UILabel *nameLb;
/** 标志*/
@property (nonatomic, strong) UIImageView *indicatorIv;
/** 口号*/
@property (nonatomic, strong) UILabel *noticeLb;
/** 投票按钮*/
@property (nonatomic, strong) UIButton *voteBtn;





@end


@implementation TVShowVoteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = BACKGROUNDCOLOR;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.backView];
        _backView.sd_layout
        .topSpaceToView(self.contentView, 0)
        .leftSpaceToView(self.contentView, 10)
        .rightSpaceToView(self.contentView, 10)
        .bottomSpaceToView(self.contentView, 5);
        [self autoLayoutBackSubViews];
    }
    return self;
}

/** 布局*/
- (void)autoLayoutBackSubViews{
    _headIv.sd_layout
    .topSpaceToView(_backView, 5)
    .leftSpaceToView(_backView, 5)
    .heightIs(60)
    .widthEqualToHeight();
    [_headIv setSd_cornerRadiusFromWidthRatio:@0.5];
    
    _nameLb.sd_layout
    .centerYIs(20)
    .leftSpaceToView(_headIv, 5)
    .autoHeightRatio(0);
    [_nameLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _indicatorIv.sd_layout
    .centerYIs(50)
    .leftSpaceToView(_headIv, 5)
    .widthIs(29)
    .heightIs(15);
    
    _noticeLb.sd_layout
    .centerYEqualToView(_indicatorIv)
    .leftSpaceToView(_indicatorIv, 3)
    .autoHeightRatio(0);
    [_noticeLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _voteBtn.sd_layout
    .centerYEqualToView(_headIv)
    .rightSpaceToView(_backView, 5)
    .heightIs(22)
    .widthIs(60);
    [_voteBtn setSd_cornerRadius:@3];
}

#pragma mark ----------------投票

- (void)voteAction:(UIButton *)btn{
    [SVProgressHUD showWithStatus:@"点赞请求发送中"];
    [ShareBusinessManager.tvManager postTvVoteUserWithParameters:@{@"userId":_model.ID}
                                                         success:^(id responObject) {
                                                             [SVProgressHUD showSuccessWithStatus:@"已点赞"];
                                                             btn.enabled = NO;
                                                         } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                             [SVProgressHUD showErrorWithStatus:errorMsg];
                                                         }];
}

- (void)setModel:(TvVoteModel *)model{
    _model = model;
    _nameLb.text = model.name;
    [_headIv sd_setImageWithURL:FULLIMGURL(model.headUrl) placeholderImage:Placeholder_middle];
    _noticeLb.text = model.article;
    _voteBtn.enabled = !model.flag;
}


#pragma mark ----------------实例化

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = WHITECOLOR;
        [_backView addSubview:self.headIv];
        [_backView addSubview:self.nameLb];
        [_backView addSubview:self.indicatorIv];
        [_backView addSubview:self.noticeLb];
        [_backView addSubview:self.voteBtn];
    }
    return _backView;
}

- (UIImageView *)headIv{
    if (!_headIv) {
        _headIv = [[UIImageView alloc] init];
        _headIv.backgroundColor = [UIColor redColor];
    }
    return _headIv;
}

- (UILabel *)nameLb{
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] init];
        _nameLb.font = FONT(16);
        _nameLb.textColor = BLACKTEXTCOLOR;
        _nameLb.text = @"未知用户";
    }
    return _nameLb;
}

- (UILabel *)noticeLb{
    if (!_noticeLb) {
        _noticeLb = [[UILabel alloc] init];
        _noticeLb.font = FONT(15);
        _noticeLb.textColor = BLACKTEXTCOLOR;
        _noticeLb.text = @"--------";
    }
    return _noticeLb;
}

- (UIImageView *)indicatorIv{
    if (!_indicatorIv) {
        _indicatorIv = [[UIImageView alloc] init];
        _indicatorIv.image = IMAGE(@"classify-2");
    }
    return _indicatorIv;
}

- (UIButton *)voteBtn{
    if (!_voteBtn) {
        _voteBtn = [[UIButton alloc] init];
        _voteBtn.backgroundColor = GLOBALCOLOR;
        _voteBtn.titleLabel.font = FONT(13.5);
        [_voteBtn setTitle:@"赞她" forState:UIControlStateNormal];
        [_voteBtn setTitle:@"已赞" forState:UIControlStateDisabled];
        [_voteBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_voteBtn setImage:IMAGE(@"classify192") forState:UIControlStateNormal];
        [_voteBtn setImage:IMAGE(@"classify193") forState:UIControlStateDisabled];
        [_voteBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -3, 0.0, 0.0)];
        [_voteBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, -3)];

        [_voteBtn addTarget:self action:@selector(voteAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _voteBtn;
}

@end
