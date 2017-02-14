//
//  TSOTopicCommentCell.m
//  GolfIOS
//
//  Created by yangbin on 16/11/4.
//  Copyright © 2016年 zzz. All rights reserved.
//帖子详情页 评论

#import "TSOTopicCommentCell.h"
#import "ClubArticleCommentModel.h"
#import "CommunityArticleCommentModel.h"
#import "MyInviteCommentView.h"

@interface TSOTopicCommentCell ()

/**icon*/
@property (nonatomic, strong) UIImageView *icon;
/**名字*/
@property (nonatomic, strong) UILabel *nameLabel;
/**时间L*/
@property (nonatomic, strong) UILabel *timeLabel;
/**内容*/
@property (nonatomic, strong) UILabel *contentLabel;


/**回复view*/
@property (nonatomic, strong) MyInviteCommentView *commentView;


@end

@implementation TSOTopicCommentCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.separatorInset = UIEdgeInsetsMake(0, 58, 0, 0);
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.commentView];
    
    self.icon.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(28)
    .heightIs(28);
    self.icon.sd_cornerRadius = @2;
    
    self.nameLabel.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.icon, 15)
    .autoHeightRatio(0);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    self.timeLabel.sd_layout
    .bottomEqualToView(self.icon)
    .leftSpaceToView(self.icon, 15)
    .autoHeightRatio(0);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    self.contentLabel.sd_layout
    .topSpaceToView(self.icon, 15)
    .leftSpaceToView(self.icon, 15)
    .autoHeightRatio(0);
    [self.contentLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH - 73];

    _commentView.sd_layout
    .leftEqualToView(_contentLabel)
    .rightSpaceToView(self.contentView ,15 )
    .topSpaceToView(_contentLabel, 10);
    
    //yb
    
    weak(self);
    [_commentView setDidClickCommentLabelBlock:^(NSString *commentId, NSString *commentName, CGRect rectInWindow,NSInteger commentRow) {
        if (weakSelf.didClickCommentLabelBlock) {
            
            weakSelf.didClickCommentLabelBlock(commentId,commentName,rectInWindow,weakSelf.indexPath,commentRow);
        }
    }];

}

- (void)setModel:(ClubArticleComment *)model{
    _model = model;
    self.nameLabel.text = _model.nickname;
    self.timeLabel.text = _model.createTime;
    self.contentLabel.text = _model.content;
    [_commentView setupWithLikeItemsArray:@[] commentItemsArray:model.commentItemsArray];
    [self setupAutoHeightWithBottomView:self.commentView bottomMargin:10];
    [self.icon sd_setImageWithURL:FULLIMGURL(_model.headUrl) placeholderImage:Placeholder_small];
}

- (void)setCommunityModel:(CommunityArticleComment *)communityModel{
    _communityModel = communityModel;
    self.nameLabel.text = _communityModel.nickname;
    self.timeLabel.text = _communityModel.createTime;
    self.contentLabel.text = _communityModel.content;
    
    [_commentView setupWithLikeItemsArray:@[] commentItemsArray:_communityModel.commentItemsArray];
    [self setupAutoHeightWithBottomView:self.commentView bottomMargin:10];
    [self.icon sd_setImageWithURL:FULLIMGURL(_communityModel.headUrl) placeholderImage:Placeholder_small];
}


//MARK: - Action

- (void)contentLabelDidClick{
    if (self.didClickContentLabelBlock) {
        self.didClickContentLabelBlock();
    }
}

//MARK: - Setter&Getter

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
        _nameLabel.textColor = SHENTEXTCOLOR;
    }
    return _nameLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = FONT(10);
        _timeLabel.textColor = LIGHTTEXTCOLOR;
    }
    return _timeLabel;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FONT(12);
        _contentLabel.textColor = SHENTEXTCOLOR;
        _contentLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentLabelDidClick)];
        [_contentLabel addGestureRecognizer:tap];
    }
    return _contentLabel;
}

- (MyInviteCommentView *)commentView{
    if (_commentView == nil) {
        _commentView = [[MyInviteCommentView alloc] init];
    }
    return _commentView;
}

@end
