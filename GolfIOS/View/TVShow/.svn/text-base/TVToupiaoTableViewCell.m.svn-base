
//
//  TVToupiaoTableViewCell.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/29.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TVToupiaoTableViewCell.h"

@interface TVToupiaoTableViewCell ()
/** 图片*/
@property (nonatomic, strong) UIImageView *headIv;
/** 标题*/
@property (nonatomic, strong) UILabel *titleLb;

/** 时间*/
@property (nonatomic, strong) UILabel *timeLb;

/** 标记*/
@property (nonatomic, strong) UILabel *tagLb;




@end

@implementation TVToupiaoTableViewCell

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
        [self.contentView sd_addSubviews:@[self.headIv, self.titleLb, self.timeLb, self.tagLb]];
        [self autoLayoutSubViews];
    }
    return self;
}

/** 自动布局*/
- (void)autoLayoutSubViews{
    _headIv.sd_layout
    .topSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .bottomSpaceToView(self.contentView, 80);
    
    _titleLb.sd_layout
    .topSpaceToView(_headIv, 16)
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    
    _timeLb.sd_layout
    .topSpaceToView(_titleLb, 10)
    .leftEqualToView(_titleLb)
    .rightEqualToView(_titleLb)
    .autoHeightRatio(0);
    
    _tagLb.sd_layout
    .topSpaceToView(_headIv, 25)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(16)
    .widthIs(47);
    [_tagLb setSd_cornerRadiusFromHeightRatio:@0.5];
}

#pragma mark ----------------界面更新

- (void)setModel:(TvVoteActionModel *)model{
    _model = model;
    [_headIv sd_setImageWithURL:FULLIMGURL(model.imageUrl) placeholderImage:Placeholder_big];
    _titleLb.text = model.name;
    NSString *text = [NSString stringWithFormat:@"投票时间：%@-%@",model.startTime, model.endTime];
    _timeLb.attributedText = [text attributeStrWithAttributes:@{NSForegroundColorAttributeName:RGBColor(242, 147, 48)} range:NSMakeRange(0, 5)];
    _tagLb.text = model.statusName;
    switch (model.status) {
        case 0:
        {
            _tagLb.textColor = LIGHTTEXTCOLOR;
            _tagLb.layer.borderColor = GRAYCOLOR.CGColor;
        }
            break;
        case 1:
        {
            _tagLb.textColor = GLOBALCOLOR;
            _tagLb.layer.borderColor = GLOBALCOLOR.CGColor;

        }
            break;
        case 2:
        {
            _tagLb.textColor = LIGHTTEXTCOLOR;
            _tagLb.layer.borderColor = GRAYCOLOR.CGColor;

        }
            break;
        default:
            break;
    }
}


#pragma mark ----------------实例化

- (UIImageView *)headIv{
    if (!_headIv) {
        _headIv = [[UIImageView alloc] init];
        _headIv.image = Placeholder_big;
    }
    return _headIv;
}

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = FONT(14);
        _titleLb.textColor = BLACKTEXTCOLOR;
        _titleLb.text = @"活动标题";
    }
    return _titleLb;
}

- (UILabel *)timeLb{
    if (!_timeLb) {
        _timeLb = [[UILabel alloc] init];
        _timeLb.font = FONT(12);
        _timeLb.textColor = LIGHTTEXTCOLOR;
        NSString *text = @"投票时间：2000.09.12-2016.09.31";
        _timeLb.attributedText = [text attributeStrWithAttributes:@{NSForegroundColorAttributeName:RGBColor(242, 147, 48)} range:NSMakeRange(0, 5)];
    }
    return _timeLb;
}


- (UILabel *)tagLb{
    if (!_tagLb) {
        _tagLb = [[UILabel alloc] init];
        _tagLb.font = FONT(10);
        _tagLb.layer.borderWidth = 0.5;
        _tagLb.textAlignment = NSTextAlignmentCenter;
    }
    return _tagLb;
}


@end
