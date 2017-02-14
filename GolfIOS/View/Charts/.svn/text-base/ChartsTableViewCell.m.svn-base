//
//  ChartsTableViewCell.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/3.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "ChartsTableViewCell.h"

@interface ChartsTableViewCell ()
/** 名次*/
@property (nonatomic, strong) UILabel *placeLb;
/** 头像*/
@property (nonatomic, strong) UIImageView *headIv;
/** 姓名*/
@property (nonatomic, strong) UILabel *nameLb;
/** 分数*/
@property (nonatomic, strong) UILabel *scoreLb;
/** 分数类别*/
@property (nonatomic, strong) UILabel *styleLb;
/** 三甲图*/
@property (nonatomic, strong) UIImageView *topIv;

@end

@implementation ChartsTableViewCell

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
        self.contentView.backgroundColor  = WHITECOLOR;
        [self.contentView sd_addSubviews:@[self.placeLb, self.topIv, self.nameLb, self.headIv, self.styleLb, self.scoreLb]];
        [self autoLayoutSubViews];//自动布局
    }
    return self;
}

- (void)autoLayoutSubViews{
    
    _placeLb.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(34)
    .autoHeightRatio(0);
    
    _topIv.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.contentView, 10)
    .heightIs(34)
    .widthIs(24);
    
    _headIv.sd_layout
    .centerYEqualToView(_placeLb)
    .leftSpaceToView(_placeLb, 0)
    .heightIs(40)
    .widthEqualToHeight();
    [_headIv setSd_cornerRadiusFromWidthRatio:@0.5];

    _scoreLb.sd_layout
    .centerYEqualToView(_headIv)
    .rightSpaceToView(self.contentView, 10)
    .widthIs(35)
    .autoHeightRatio(0);
    
    
    _styleLb.sd_layout
    .centerYEqualToView(_scoreLb)
    .rightSpaceToView(_scoreLb, 5)
    .autoHeightRatio(0);
    [_styleLb setSingleLineAutoResizeWithMaxWidth:200];
    
    _nameLb.sd_layout
    .centerYEqualToView(_headIv)
    .leftSpaceToView(_headIv, 5)
    .rightSpaceToView(_styleLb,5)
    .autoHeightRatio(0);
}

#pragma mark ----------------数据

- (void)setModel:(ChartsItemModel *)model{
    _model = model;
    _placeLb.text = model.no;
    [_headIv sd_setImageWithURL:FULLIMGURL(model.headUrl) placeholderImage:Placeholder_middle];
    _nameLb.text = model.name;
    
    if (model.no.integerValue <=3) {
        NSString *text = [NSString stringWithFormat:@"classify%ld",model.no.integerValue + 37];
        _topIv.image = IMAGE(text);
        _placeLb.text = nil;
    }else{
        _topIv.image = nil;
    }
    if (model.ranKStatus == 1) {
        //
        _scoreLb.text = model.score;
        _styleLb.text = @"最高成绩";
    }else if (model.ranKStatus == 2){
        _styleLb.text = nil;
        _scoreLb.text = model.score;
    }else{
        _styleLb.text = @"热度";
        _scoreLb.text = model.hot;
    }
}

- (void)setTvModel:(TvVoteModel *)tvModel{
    _tvModel = tvModel;
    _placeLb.text = tvModel.no;
    [_headIv sd_setImageWithURL:FULLIMGURL(tvModel.headUrl) placeholderImage:Placeholder_middle];
    _nameLb.text = tvModel.name;
    if (tvModel.no.integerValue <=3) {
        NSString *text = [NSString stringWithFormat:@"classify%ld",tvModel.no.integerValue + 37];
        _topIv.image = IMAGE(text);
        _placeLb.text = nil;
    }else{
        _topIv.image = nil;
    }
    _scoreLb.text = [tvModel.voteCnt stringValue];
    _styleLb.text   = @"票数";
}


#pragma mark ----------------实例

- (UILabel *)placeLb{
    if (!_placeLb) {
        _placeLb = [[UILabel alloc] init];
        _placeLb.font = FONT(18);
        _placeLb.textColor = SHENTEXTCOLOR;
        _placeLb.text = @"4";
    }
    return _placeLb;
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
        _nameLb.font = FONT(14);
        _nameLb.textColor = SHENTEXTCOLOR;
        _nameLb.text = @"未知用户";
    }
    return _nameLb;
}

- (UILabel *)styleLb{
    if (!_styleLb) {
        _styleLb = [[UILabel alloc] init];
        _styleLb.font = FONT(14);
        _styleLb.textColor = SHENTEXTCOLOR;
        _styleLb.text = @"最高成绩";
    }
    return _styleLb;
}

- (UILabel *)scoreLb{
    if (!_scoreLb) {
        _scoreLb = [[UILabel alloc] init];
        _scoreLb.font = FONT(14);
        _scoreLb.textColor = GLOBALCOLOR;
        _scoreLb.text = @"21";
    }
    return _scoreLb;
}

- (UIImageView *)topIv{
    if (!_topIv) {
        _topIv = [[UIImageView alloc] init];
    }
    return _topIv;
}
@end
