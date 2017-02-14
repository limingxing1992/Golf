//
//  MyArticleTableViewCell.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/16.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyArticleTableViewCell.h"

@interface MyArticleTableViewCell ()
/** 头像*/
@property (nonatomic, strong) UIImageView *headIv;
/** 标题*/
@property (nonatomic, strong) UILabel *titleLb;
/** 时间*/
@property (nonatomic, strong) UILabel *timeLb;





@end


@implementation MyArticleTableViewCell

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
        [self.contentView addSubview:self.headIv];
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.timeLb];
        [self autoLayoutSubViews];
    }
    return self;
}
/** 自动布局*/
- (void)autoLayoutSubViews{
    _headIv.sd_layout
    .topSpaceToView(self.contentView, 13)
    .leftSpaceToView(self.contentView, 15)
    .bottomSpaceToView(self.contentView, 13)
    .widthEqualToHeight();
    
    _titleLb.sd_layout
    .topSpaceToView(self.contentView, 17)
    .leftSpaceToView(_headIv, 15)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    
    _timeLb.sd_layout
    .bottomSpaceToView(self.contentView, 18)
    .leftEqualToView(_titleLb)
    .rightEqualToView(_titleLb)
    .autoHeightRatio(0);
}

#pragma mark ----------------数据

- (void)setModel:(MyArticleItemModel *)model{
    _model = model;
    [_headIv sd_setImageWithURL:FULLIMGURL(model.logoUrl) placeholderImage:Placeholder_middle];
    _titleLb.text = model.title;
    _timeLb.text = model.createTime;
}


#pragma mark ----------------实例

- (UIImageView *)headIv{
    if (!_headIv) {
        _headIv = [[UIImageView alloc] init];
        _headIv.image = Placeholder_middle;
    }
    return _headIv;
}

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = FONT(15);
        _titleLb.textColor = BLACKTEXTCOLOR;
        _titleLb.text = @"未知";
    }
    return _titleLb;
}

- (UILabel *)timeLb{
    if (!_timeLb) {
        _timeLb = [[UILabel alloc] init];
        _timeLb.font = FONT(11);
        _timeLb.textColor = LIGHTTEXTCOLOR;
        _timeLb.text = @"------";
    }
    
    return _timeLb;
}


@end
