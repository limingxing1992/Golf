//
//  TvVideoTableViewCell.m
//  GolfIOS
//
//  Created by 李明星 on 2017/1/5.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import "TvVideoTableViewCell.h"

@interface TvVideoTableViewCell ()

/** 详情视图*/
@property (nonatomic, strong) UIView *infoView;
/** 标题*/
@property (nonatomic, strong) UILabel *titleLb;
/** 播放图*/
@property (nonatomic, strong) UIImageView *playIv;

/** 小鸟icon*/
@property (nonatomic, strong) UIImageView *iconIv;
///** 小鸟娱乐*/
//@property (nonatomic, strong) UILabel *iconLb;

///** 投票数*/
//@property (nonatomic, strong) UILabel *countLb;

/** 向右箭头*/
@property (nonatomic, strong) UIImageView *rightIv;








@end

@implementation TvVideoTableViewCell

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
        [self.contentView setBackgroundColor:BACKGROUNDCOLOR];
        [self.contentView sd_addSubviews:@[self.videoImageView, self.infoView]];
        [self autoLayoutSubViews];
    }
    return self;
}

/** 布局*/
- (void)autoLayoutSubViews{
    _videoImageView.sd_layout
    .topSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .bottomSpaceToView(self.contentView, 60);
    
//    _titleLb.sd_layout
//    .topSpaceToView(_videoImageView, 18)
//    .leftSpaceToView(_videoImageView, 15)
//    .rightSpaceToView(_videoImageView, 15)
//    .autoHeightRatio(0);
    
    _infoView.sd_layout
    .topSpaceToView(_videoImageView, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .bottomSpaceToView(self.contentView, 10);
    
    _iconIv.sd_layout
    .leftSpaceToView(_infoView, 15)
    .topSpaceToView(_infoView, 7.5)
    .bottomSpaceToView(_infoView, 7.5)
    .widthEqualToHeight();
    [_iconIv setSd_cornerRadiusFromHeightRatio:@0.5];
    
    _titleLb.sd_layout
    .centerYEqualToView(_iconIv)
    .leftSpaceToView(_iconIv, 5)
    .rightSpaceToView(_infoView, 25)
    .heightIs(15);
    
    _rightIv.sd_layout
    .centerYEqualToView(_iconIv)
    .rightSpaceToView(_infoView, 15)
    .widthIs(7)
    .heightIs(12.5);
    
//    _countLb.sd_layout
//    .centerYEqualToView(_rightIv)
//    .rightSpaceToView(_rightIv, 10)
//    .autoHeightRatio(0);
//    [_countLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    
    _playIv.sd_layout
    .centerXEqualToView(_videoImageView)
    .centerYEqualToView(_videoImageView)
    .heightIs(60)
    .widthEqualToHeight();
    
}


- (void)setModel:(TvVideoModel *)model{
    _model = model;

    [_videoImageView sd_setImageWithURL:FULLIMGURL(model.pictureUrl) placeholderImage:Placeholder_big];
    _titleLb.text = model.name;
//    _countLb.text = [NSString stringWithFormat:@"当前票数：%ld", model.voteCnt];
    
}

#pragma mark ----------------实例

- (UIImageView *)videoImageView{
    if (!_videoImageView) {
        _videoImageView = [[UIImageView alloc] init];
        _videoImageView.userInteractionEnabled = YES;
//        [_videoImageView addSubview:self.titleLb];
        [_videoImageView addSubview:self.playIv];
    }
    return _videoImageView;
}

- (UIView *)infoView{
    if (!_infoView) {
        _infoView = [[UIImageView alloc] init];
        _infoView.backgroundColor = WHITECOLOR;
        [_infoView sd_addSubviews:@[self.iconIv, self.titleLb,
                                    self.rightIv]];
    }
    return _infoView;
}

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = FONT(15);
//        _titleLb.textColor = BLACKTEXTCOLOR;
    }
    return _titleLb;
}

- (UIImageView *)iconIv{
    if (!_iconIv) {
        _iconIv = [[UIImageView alloc] init];
        _iconIv.image = IMAGE(@"icon-small");
    }
    
    return _iconIv;
}


//- (UILabel *)iconLb{
//    if (!_iconLb) {
//        _iconLb = [[UILabel alloc] init];
//        _iconLb.font = FONT(15);
//        _iconLb.text = @"小鸟娱动";
//    }
//    return _iconLb;
//}

//- (UILabel *)countLb{
//    if (!_countLb) {
//        _countLb = [[UILabel alloc] init];
//        _countLb.font = FONT(14);
//        _countLb.textColor = SHENTEXTCOLOR;
//    }
//    return _countLb;
//}

- (UIImageView *)rightIv{
    if (!_rightIv) {
        _rightIv = [[UIImageView alloc] init];
        _rightIv.image = IMAGE(@"classify8");
    }
    return _rightIv;
}

- (UIImageView *)playIv{
    if (!_playIv) {
        _playIv = [[UIImageView alloc] init];
        _playIv.image = IMAGE(@"play");
    }
    return _playIv;
}

@end
