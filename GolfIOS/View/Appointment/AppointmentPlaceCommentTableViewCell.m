//
//  AppointmenPlaceCommentTableViewCell.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/20.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "AppointmentPlaceCommentTableViewCell.h"
#import "STL_CommentStarView.h"//评论星级


@interface AppointmentPlaceCommentTableViewCell ()

/** 头像*/
@property (nonatomic, strong) UIImageView *headIv;
/** 昵称*/
@property (nonatomic, strong) UILabel *nameLb;
/** 内容*/
@property (nonatomic, strong) UILabel *contentLb;
/** 时间*/
@property (nonatomic, strong) UILabel *timeLb;
/** 星级图*/
@property (nonatomic, strong) STL_CommentStarView *starView;


@end

@implementation AppointmentPlaceCommentTableViewCell

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
        [self.contentView sd_addSubviews:@[self.headIv, self.nameLb, self.contentLb, self.timeLb, self.starView]];
        [self autoLayoutSubViews];
    }
    return self;
}

#pragma mark ----------------布局

- (void)autoLayoutSubViews{
    _headIv.sd_layout
    .topSpaceToView(self.contentView, 16)
    .leftSpaceToView(self.contentView, 15)
    .heightIs(40)
    .widthEqualToHeight();
    [_headIv setSd_cornerRadius:@3];
    
    _nameLb.sd_layout
    .topEqualToView(_headIv)
    .leftSpaceToView(_headIv, 15)
    .heightIs(11);
    [_nameLb setSingleLineAutoResizeWithMaxWidth:300];
    
    
    _timeLb.sd_layout
    .topEqualToView(_headIv)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(11);
    [_timeLb setSingleLineAutoResizeWithMaxWidth:300];
    
    
    _contentLb.sd_layout
    .leftEqualToView(_headIv)
    .topSpaceToView(_headIv, 10)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    
    _starView.sd_layout
    .bottomEqualToView(_headIv)
    .leftEqualToView(_nameLb)
    .heightIs(12)
    .widthIs(70);
    
    [self setupAutoHeightWithBottomView:_contentLb bottomMargin:10];
}

#pragma mark ----------------刷新数据

- (void)setModel:(PlaceCommentItemModel *)model{
    _model = model;
    [_headIv sd_setImageWithURL:FULLIMGURL(model.headUrl) placeholderImage:Placeholder_middle];
    _nameLb.text = model.nickName;
    _contentLb.text = model.commentText;
    _timeLb.text = model.createTime;
    [_starView setStarWithInterger:model.score + 1];
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
        _nameLb.font = FONT(11);
        _nameLb.textColor = LIGHTTEXTCOLOR;
    }
    return _nameLb;
}

- (UILabel *)contentLb{
    if (!_contentLb) {
        _contentLb = [[UILabel alloc] init];
        _contentLb.font = FONT(14);
        _contentLb.textColor = BLACKTEXTCOLOR;
    }
    return _contentLb;
}

- (UILabel *)timeLb{
    if (!_timeLb) {
        _timeLb = [[UILabel alloc] init];
        _timeLb.font = FONT(11);
        _timeLb.textColor = LIGHTTEXTCOLOR;
    }
    return _timeLb;
}

- (STL_CommentStarView *)starView{
    if (!_starView) {
        _starView = [[STL_CommentStarView alloc] init];
        _starView.backgroundColor = WHITECOLOR;
    }
    return _starView;
}


@end
