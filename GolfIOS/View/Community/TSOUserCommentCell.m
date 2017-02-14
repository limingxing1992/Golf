//
//  TSOUserCommentCell.m
//  GolfIOS
//
//  Created by yangbin on 16/11/7.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOUserCommentCell.h"
#import "YB_ToolBtn.h"
#import "CommunityMyCommentModel.h"

@interface TSOUserCommentCell ()

/**icon*/
@property (nonatomic, strong) UIImageView *icon;
/**用户名*/
@property (nonatomic, strong) UILabel *nameLabel;
/**发表了评论*/
@property (nonatomic, strong) UILabel *fabiaoLabel;
/**时间*/
@property (nonatomic, strong) UILabel *timeLabel;
///**@某人的姓名*/
//@property (nonatomic, strong) UILabel *atNameLabel;
/**评论的内容*/
@property (nonatomic, strong) UILabel *contentLabel;
/**被评价的球场视图*/
@property (nonatomic, strong) UIView *courseView;
/**球场图标*/
@property (nonatomic, strong) UIImageView *courseIcon;
/**球场名称*/
@property (nonatomic, strong) UILabel *courseNameLabel;
/**球场创建人*/
@property (nonatomic, strong) UILabel *courseCreatorLabel;
/**球场点赞*/
@property (nonatomic, strong) YB_ToolBtn *courseLoveBtn;
/**球场评论*/
@property (nonatomic, strong) YB_ToolBtn *courseCommentBtn;
/**lineView*/
@property (nonatomic, strong) UIView  *lineView;

@end

@implementation TSOUserCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        
    }
    return self;
}

- (void)setModel:(CommunityMyComment *)model{
    _model = model;
    [self.icon sd_setImageWithURL:_model.headUrl placeholderImage:Placeholder_middle];
    self.nameLabel.text = [UserModel sharedUserModel].nickName;
    self.timeLabel.text = _model.createTime;
//    self.atNameLabel.text = _model.nickname;
    self.contentLabel.text = _model.commentContent;
    
    self.courseNameLabel.text = _model.articleContent;
    self.courseCreatorLabel.text = _model.nickname;
    
    [self.courseIcon sd_setImageWithURL:FULLIMGURL(_model.image) placeholderImage:Placeholder_small];
}



- (void)setupUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.fabiaoLabel];
    [self.contentView addSubview:self.timeLabel];
//    [self.contentView addSubview:self.atNameLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.lineView];
    
    self.icon.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(27)
    .heightIs(27);
    
    self.nameLabel.sd_layout
    .topSpaceToView(self.contentView,17)
    .leftSpaceToView(self.icon, 10)
    .autoHeightRatio(0);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.fabiaoLabel.sd_layout
    .topEqualToView(self.nameLabel)
    .leftSpaceToView(self.nameLabel, 10)
    .autoHeightRatio(0);
    [self.fabiaoLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.timeLabel.sd_layout
    .leftSpaceToView(self.icon, 10)
    .bottomEqualToView(self.icon)
    .autoHeightRatio(0);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:200];
    
//    self.atNameLabel.sd_layout
//    .topSpaceToView(self.icon, 15)
//    .leftSpaceToView(self.contentView, 15)
//    .autoHeightRatio(0);
//    [self.atNameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    
    //test 如果名字很长 应该如何布局没有考虑
    self.contentLabel.sd_layout
    .topSpaceToView(self.icon, 15)
    .leftSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    [self.contentLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH - 45 - self.contentLabel.sd_maxWidth.floatValue];
    
    self.lineView.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightIs(0.5);
    
    [self setupCourseView];
    [self setupAutoHeightWithBottomView:self.courseView bottomMargin:15];
}

//帖子框
- (void)setupCourseView{
    [self.contentView addSubview:self.courseView];
    [self.courseView addSubview:self.courseIcon];
    [self.courseView addSubview:self.courseNameLabel];
    [self.courseView addSubview:self.courseCreatorLabel];
    [self.courseView addSubview:self.courseLoveBtn];
    [self.courseView addSubview:self.courseCommentBtn];
    
    self.courseView.sd_layout
    .topSpaceToView(self.contentLabel, 10)
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(70);
    
    self.courseIcon.sd_layout
    .centerYEqualToView(self.courseView)
    .leftSpaceToView(self.courseView, 15)
    .widthIs(50)
    .heightIs(50);
    
    self.courseNameLabel.sd_layout
    .topEqualToView(self.courseIcon)
    .leftSpaceToView(self.courseIcon, 10)
    .autoHeightRatio(0);
    [self.courseNameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.courseCreatorLabel.sd_layout
    .leftSpaceToView(self.courseIcon, 10)
    .bottomEqualToView(self.courseIcon)
    .autoHeightRatio(0);
    [self.courseCreatorLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.courseLoveBtn.sd_layout
    .leftSpaceToView(self.courseCreatorLabel, 30)
    .bottomEqualToView(self.courseIcon)
    .widthIs(30)
    .heightIs(22);
    
    self.courseCommentBtn.sd_layout
    .leftSpaceToView(self.courseLoveBtn, 10)
    .bottomEqualToView(self.courseIcon)
    .widthIs(30)
    .heightIs(22);
    
    
}

- (UIImageView *)icon{
    if (_icon == nil) {
        _icon = [[UIImageView alloc] init];
        _icon.backgroundColor = [UIColor orangeColor];
    }
    return _icon;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = FONT(12);
        _nameLabel.textColor = GLOBALCOLOR;
    }
    return _nameLabel;
}

- (UILabel *)fabiaoLabel{
    if (_fabiaoLabel == nil) {
        _fabiaoLabel = [[UILabel alloc] init];
        _fabiaoLabel.font = FONT(12);
        _fabiaoLabel.textColor = LIGHTTEXTCOLOR;
        _fabiaoLabel.text = @"发表了评论";
    }
    
    return _fabiaoLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = FONT(10);
        _timeLabel.textColor = LIGHTTEXTCOLOR;
    }
    return _timeLabel;
}

//- (UILabel *)atNameLabel{
//    if (_atNameLabel == nil) {
//        _atNameLabel = [[UILabel alloc] init];
//        _atNameLabel.font = FONT(14);
//        _atNameLabel.textColor = GLOBALCOLOR;
//    }
//    return _atNameLabel;
//}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FONT(14);
        _contentLabel.textColor = LIGHTTEXTCOLOR;
    }
    return _contentLabel;
}

- (UIView *)courseView{
    if (_courseView == nil) {
        _courseView = [[UIView alloc] init];
        _courseView.layer.cornerRadius = 4;
        _courseView.layer.borderWidth = 0.5;
        _courseView.layer.borderColor = BACKGROUNDCOLOR.CGColor;

    }
    return _courseView;
}

- (UIImageView *)courseIcon{
    if (_courseIcon == nil) {
        _courseIcon = [[UIImageView alloc] init];
        _courseIcon.backgroundColor = [UIColor orangeColor];
    }
    return _courseIcon;
}

- (UILabel *)courseNameLabel{
    if (_courseNameLabel == nil) {
        _courseNameLabel = [[UILabel alloc] init];
        _courseNameLabel.font = FONT(14);
        _courseNameLabel.textColor = SHENTEXTCOLOR;
    }
    return _courseNameLabel;
}

- (UILabel *)courseCreatorLabel{
    if (_courseCreatorLabel == nil) {
        _courseCreatorLabel = [[UILabel alloc] init];
        _courseCreatorLabel.font = FONT(12);
        _courseCreatorLabel.textColor = GLOBALCOLOR;
    }
    return _courseCreatorLabel;
}

- (YB_ToolBtn *)courseLoveBtn{
    if (_courseLoveBtn == nil) {
        _courseLoveBtn = [YB_ToolBtn loveButton];
        
    }
    return _courseLoveBtn;
}

- (YB_ToolBtn *)courseCommentBtn{
    if (_courseCommentBtn == nil){
        _courseCommentBtn = [YB_ToolBtn commentButton];
    }
    return _courseCommentBtn;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = BACKGROUNDCOLOR;
    }
    return _lineView;
}

@end
