//
//  MyInviteMeTableViewCell.m
//  GolfIOS
//
//  Created by yangbin on 16/12/13.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyInviteMeTableViewCell.h"
#import "MyInviteMeCellOperationMenu.h"
#import "MyInviteCommentView.h"
#import "SDTimeLineCellModel.h"



//const CGFloat contentLabelFontSize = 15;
//CGFloat maxContentLabelHeight = 0; // 根据具体font而定
NSString *const kMyInviteMeCellOperationButtonClickedNotification = @"kMyInviteMeCellOperationButtonClickedNotification";

@implementation MyInviteMeTableViewCell
{
    UIImageView *_iconView;
    UILabel *_nameLable;
    UILabel *_contentLabel;
    UILabel *_timeLabel;
    UIButton *_operationButton;
    MyInviteCommentView *_commentView;
    MyInviteMeCellOperationMenu *_operationMenu;
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        
        UILongPressGestureRecognizer *pressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressGesture)];
        [self.contentView addGestureRecognizer:pressGesture];
    }
    return self;
}

- (void)pressGesture{
    if (_pressBlock) {
        _pressBlock();
    }
}

- (void)setupUI{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveOperationButtonClickedNotification:) name:kMyInviteMeCellOperationButtonClickedNotification object:nil];
    
    _iconView = [UIImageView new];
    
    _nameLable = [UILabel new];
    _nameLable.font = FONT(16);
    _nameLable.textColor = GLOBALCOLOR;
    
    _timeLabel = [UILabel new];
    _timeLabel.font = FONT(14);
    _timeLabel.textColor = LIGHTTEXTCOLOR;
    
    _contentLabel = [UILabel new];
    _contentLabel.font = FONT(14);
    _contentLabel.textColor = SHENTEXTCOLOR;
    
    _operationButton = [UIButton new];
    [_operationButton setImage:[UIImage imageNamed:@"classify74"] forState:UIControlStateNormal];
    [_operationButton addTarget:self action:@selector(operationButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _commentView = [MyInviteCommentView new];
    
    _operationMenu = [MyInviteMeCellOperationMenu new];
    __weak typeof(self) weakSelf = self;
    
    [_operationMenu setCommentButtonClickedOperation:^{
        if ([weakSelf.delegate respondsToSelector:@selector(didClickcCommentButtonInCell:)]) {
            [weakSelf.delegate didClickcCommentButtonInCell:weakSelf];
        }
    }];
    
    NSArray *views = @[_iconView, _nameLable, _contentLabel, _timeLabel, _operationButton,_operationMenu,  _commentView];
    
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    
    _iconView.sd_layout
    .leftSpaceToView(contentView, margin + 5)
    .topSpaceToView(contentView, margin + 5)
    .widthIs(48)
    .heightIs(48);
    _iconView.sd_cornerRadius = @24;
    
    _nameLable.sd_layout
    .leftSpaceToView(_iconView, margin)
    .topEqualToView(_iconView)
    .autoHeightRatio(0);
    [_nameLable setSingleLineAutoResizeWithMaxWidth:200];
    
    _contentLabel.sd_layout
    .leftSpaceToView(_iconView, margin)
    .bottomEqualToView(_iconView)
    .autoHeightRatio(0);
    [_contentLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _timeLabel.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_contentLabel, margin)
    .autoHeightRatio(0);
    [_timeLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _operationButton.sd_layout
    .rightSpaceToView(contentView, margin + 5)
    .centerYEqualToView(_timeLabel)
    .heightIs(15)
    .widthIs(20);
    
    _commentView.sd_layout
    .leftEqualToView(_nameLable)
    .rightSpaceToView(_operationButton,margin )
    .topSpaceToView(_timeLabel, margin);
    
    //yb
    
    
    [_commentView setDidClickCommentLabelBlock:^(NSString *commentId, NSString *commentName, CGRect rectInWindow,NSInteger commentRow) {
        if (weakSelf.didClickCommentLabelBlock) {
            
            weakSelf.didClickCommentLabelBlock(commentId,commentName,rectInWindow,weakSelf.indexPath,commentRow);
        }
    }];
    //    [_commentView setDidClickCommentLabelBlock:^(NSString *commentId, CGRect rectInWindow) {
    //        if (weakSelf.didClickCommentLabelBlock) {
    //
    //            weakSelf.didClickCommentLabelBlock(commentId,rectInWindow,weakSelf.indexPath);
    //        }
    //    }];
    
    _operationMenu.sd_layout
    .rightSpaceToView(_operationButton, 0)
    .heightIs(36)
    .centerYEqualToView(_operationButton)
    .widthIs(0);
    
    _iconView.image = Placeholder_small;
    
    
}

- (void)setModel:(SDTimeLineCellModel *)model
{
    _model = model;
    
    [_commentView setupWithLikeItemsArray:model.likeItemsArray commentItemsArray:model.commentItemsArray];
    
    //yb邀请的内容
    _nameLable.text = model.name;
    _contentLabel.text = model.msgContent;
    [_iconView sd_setImageWithURL:FULLIMGURL(model.headUrl) placeholderImage:Placeholder_small];
    UIView *bottomView;
    
    
    if (!model.commentItemsArray.count && !model.likeItemsArray.count) {
        bottomView = _timeLabel;
    } else {
        bottomView = _commentView;
    }
    
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:15];
    
    _timeLabel.text = [NSDate timeLineStringWithString:_model.createTime];
}


- (void)setFrame:(CGRect)frame
{
    CGFloat height = frame.size.height - 5;
    CGFloat width = frame.size.width;
    CGFloat x = frame.origin.x;
    CGFloat y = frame.origin.y;
    frame = CGRectMake(x, y, width, height);
    [super setFrame:frame];
    if (_operationMenu.isShowing) {
        _operationMenu.show = NO;
    }
}

#pragma mark - Action
- (void)operationButtonClicked{
    
    [self postOperationButtonClickedNotification];
    _operationMenu.show = !_operationMenu.isShowing;
}

- (void)receiveOperationButtonClickedNotification:(NSNotification *)notification
{
    UIButton *btn = [notification object];
    
    if (btn != _operationButton && _operationMenu.isShowing) {
        _operationMenu.show = NO;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self postOperationButtonClickedNotification];
    if (_operationMenu.isShowing) {
        _operationMenu.show = NO;
    }
}

- (void)postOperationButtonClickedNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kMyInviteMeCellOperationButtonClickedNotification object:_operationButton];
}



@end
