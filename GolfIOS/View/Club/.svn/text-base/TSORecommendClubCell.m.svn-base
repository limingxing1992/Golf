//
//  TSORecommendClubCell.m
//  GolfIOS
//
//  Created by yangbin on 16/11/10.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSORecommendClubCell.h"
#import "ClubSysRecommendModel.h"

@interface TSORecommendClubCell ()

/**icon*/
@property (nonatomic, strong) UIImageView *icon;
/**name*/
@property (nonatomic, strong) UILabel *nameLb;
/**申请button*/
@property (nonatomic, strong) YB_FocusButton *applyBtn;
/**已加入标签*/
@property (nonatomic, strong) UILabel *alreadyLb;

@end

@implementation TSORecommendClubCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.applyBtn];
    [self.contentView addSubview:self.alreadyLb];
    
    self.icon.sd_layout
    .leftSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .widthIs(41)
    .heightIs(41);
    
    self.nameLb.sd_layout
    .leftSpaceToView(self.icon, 15)
    .centerYEqualToView(self.contentView)
    .autoHeightRatio(0);
    [self.nameLb setSingleLineAutoResizeWithMaxWidth:200];
    
    self.applyBtn.sd_layout
    .rightSpaceToView(self.contentView, 15)
    .centerYEqualToView(self.contentView)
    .widthIs(54)
    .heightIs(24);
    
    self.alreadyLb.sd_layout
    .rightSpaceToView(self.contentView, 15)
    .centerYEqualToView(self.contentView)
    .autoHeightRatio(0);
    [self.alreadyLb setSingleLineAutoResizeWithMaxWidth:100];
    
    
    self.nameLb.text = @"Doctor to my俱乐部";
    self.alreadyLb.hidden = YES;
}

- (void)setModel:(ClubSysRecommend *)model{
    _model = model;
    self.nameLb.text = _model.clubName;
    
//    self.alreadyLb.hidden = !_model.isjoin;
    if (_model.isjoin.integerValue == 2 ||_model.isjoin.integerValue == 3) {
        self.applyBtn.hidden = NO;
        self.alreadyLb.hidden = YES;
    }else{
        self.applyBtn.hidden = YES;
        self.alreadyLb.hidden = NO;
        if (_model.isjoin.integerValue == 0) {
            self.alreadyLb.text = @"已申请";
        }else{
            self.alreadyLb.text = @"已加入";
        }
    }
    
    [self.icon sd_setImageWithURL:FULLIMGURL(_model.logoUrl) placeholderImage:Placeholder_small];
}

- (void)applyBtnClicked{
    if (_callBack) {
        _callBack();
    }
    
}

- (void)setHandler:(NILBlock)callBack{
    _callBack = callBack;
}

- (UIImageView *)icon{
    if (_icon == nil) {
        _icon = [[UIImageView alloc] init];
        _icon.backgroundColor = [UIColor orangeColor];
    }
    return _icon;
}

- (UILabel *)nameLb{
    if (_nameLb == nil) {
        _nameLb = [[UILabel alloc] init];
        _nameLb.font = FONT(14);
        _nameLb.textColor = BLACKCOLOR;
    }
    return _nameLb;
    
}

- (UILabel *)alreadyLb{
    if (_alreadyLb == nil) {
        _alreadyLb = [[UILabel alloc] init];
        _alreadyLb.font = FONT(14);
        _alreadyLb.textColor = BLACKCOLOR;
        _alreadyLb.text = @"已加入";
        
    }
    return _alreadyLb;
}

- (YB_FocusButton *)applyBtn{
    if (_applyBtn == nil) {
        _applyBtn = [[YB_FocusButton alloc] init];
        [_applyBtn setTitle:@"申请" forState:UIControlStateNormal];
        [_applyBtn addTarget:self action:@selector(applyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _applyBtn;
}

@end
