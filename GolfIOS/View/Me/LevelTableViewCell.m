//
//  LevelTableViewCell.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/11.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "LevelTableViewCell.h"

@interface LevelTableViewCell ()
/** 等级图标*/
@property (nonatomic, strong) UIImageView *indicatorIv;
/** 等级*/
@property (nonatomic, strong) UILabel *levelLb;
/** 升级*/
@property (nonatomic, strong) UIButton *levelBtn;




@end

@implementation LevelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = WHITECOLOR;
        [self.contentView addSubview:self.indicatorIv];
        [self.contentView addSubview:self.levelLb];
        [self.contentView addSubview:self.levelBtn];
        
        _indicatorIv.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 15)
        .heightIs(14)
        .widthEqualToHeight();
        
        _levelLb.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(_indicatorIv, 8)
        .autoHeightRatio(0);
        [_levelLb setSingleLineAutoResizeWithMaxWidth:300];
        
        _levelBtn.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(self.contentView, 15)
        .heightIs(30)
        .widthIs(90);
        [_levelBtn setSd_cornerRadius:@5];
    }
    return self;
}

#pragma mark ----------------我要升级

- (void)upMyLevelAction{
    //传入当前cell等级
    if (_block) {
        _block(_model);
    }
}

- (void)setModel:(MyLevelUpItemModel *)model{
    _model = model;
    _levelLb.text = model.name;
    if (model.sort == [UserModel sharedUserModel].sort) {
        _levelBtn.layer.borderWidth = 0;
        _levelBtn.enabled = NO;
    }else{
        _levelBtn.layer.borderWidth = 0.5;
        _levelBtn.enabled = YES;
    }
    _indicatorIv.image = model.indicatorIv;
}


#pragma mark ----------------实例化

- (UIImageView *)indicatorIv{
    if (!_indicatorIv) {
        _indicatorIv = [[UIImageView alloc] init];
        _indicatorIv.image = IMAGE(@"classify119");
    }
    return _indicatorIv;
}

- (UILabel *)levelLb{
    if (!_levelLb) {
        _levelLb = [[UILabel alloc] init];
        _levelLb.font = FONT(14);
        _levelLb.textColor = BLACKTEXTCOLOR;
        _levelLb.text = @"男爵";
    }
    return _levelLb;
}

- (UIButton *)levelBtn{
    if (!_levelBtn) {
        _levelBtn = [[UIButton alloc] init];
        _levelBtn.titleLabel.font = FONT(14);
        _levelBtn.backgroundColor = WHITECOLOR;
        [_levelBtn setTitle:@"我要升级" forState:UIControlStateNormal];
        [_levelBtn setTitle:@"当前等级" forState:UIControlStateDisabled];
        [_levelBtn setTitleColor:BLACKTEXTCOLOR forState:UIControlStateDisabled];
        [_levelBtn setTitleColor:RGBColor(242, 115, 94) forState:UIControlStateNormal];
        _levelBtn.layer.borderWidth = 0.5;
        _levelBtn.layer.borderColor = RGBColor(242, 115, 94).CGColor;
        [_levelBtn addTarget:self action:@selector(upMyLevelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _levelBtn;
}


@end
