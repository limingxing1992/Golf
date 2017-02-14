//
//  MyInviteCommentCell.m
//  GolfIOS
//
//  Created by yangbin on 16/11/24.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyInviteCommentCell.h"
#import "MyInviteCommentCellOperationMenu.h"
#import "MyInviteCommentView.h"
#import "SDTimeLineCellModel.h"

const CGFloat contentLabelFontSize = 15;
CGFloat maxContentLabelHeight = 0; // 根据具体font而定
NSString *const kSDTimeLineCellOperationButtonClickedNotification = @"SDTimeLineCellOperationButtonClickedNotification";

@implementation MyInviteCommentCell

{
    UIImageView *_iconView;
    UILabel *_nameLable;
    UILabel *_timeLabel;
    UIButton *_operationButton;
    MyInviteCommentView *_commentView;
    MyInviteCommentCellOperationMenu *_operationMenu;

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveOperationButtonClickedNotification:) name:kSDTimeLineCellOperationButtonClickedNotification object:nil];
    
    _iconView = [UIImageView new];
    
    _nameLable = [UILabel new];
    _nameLable.font = FONT(14);
    _nameLable.textColor = SHENTEXTCOLOR;
    
    _timeLabel = [UILabel new];
    _timeLabel.font = FONT(14);
    _timeLabel.textColor = LIGHTTEXTCOLOR;
    
    _operationButton = [UIButton new];
    [_operationButton setImage:[UIImage imageNamed:@"classify74"] forState:UIControlStateNormal];
    [_operationButton addTarget:self action:@selector(operationButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _commentView = [MyInviteCommentView new];
    
    _operationMenu = [MyInviteCommentCellOperationMenu new];
    __weak typeof(self) weakSelf = self;
    [_operationMenu setLikeButtonClickedOperation:^{
        if ([weakSelf.delegate respondsToSelector:@selector(didClickLikeButtonInCell:)]) {
            [weakSelf.delegate didClickLikeButtonInCell:weakSelf];
        }
    }];
    [_operationMenu setCommentButtonClickedOperation:^{
        if ([weakSelf.delegate respondsToSelector:@selector(didClickcCommentButtonInCell:)]) {
            [weakSelf.delegate didClickcCommentButtonInCell:weakSelf];
        }
    }];
    
    NSArray *views = @[_iconView, _nameLable, _timeLabel, _operationButton,_operationMenu,  _commentView];
    
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    
    _iconView.sd_layout
    .leftSpaceToView(contentView, margin + 5)
    .topSpaceToView(contentView, margin + 5)
    .widthIs(15)
    .heightIs(15);
    
    _nameLable.sd_layout
    .leftSpaceToView(_iconView, margin)
    .topEqualToView(_iconView)
    .autoHeightRatio(0);
    [_nameLable setSingleLineAutoResizeWithMaxWidth:200];
    
    _timeLabel.sd_layout
    .leftEqualToView(_nameLable)
    .topSpaceToView(_nameLable, margin)
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
            
            weakSelf.didClickCommentLabelBlock(commentId,commentName,rectInWindow,weakSelf.indexPath);
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
    
    _iconView.image = IMAGE(@"classify63");
}


- (void)setModel:(SDTimeLineCellModel *)model
{
    _model = model;
    
    [_commentView setupWithLikeItemsArray:model.likeItemsArray commentItemsArray:model.commentItemsArray];
    
   
    
  
    //yb邀请的内容
    _nameLable.text = model.msgContent;
//    _contentLabel.text = model.msgContent;
//    _picContainerView.picPathStringsArray = model.picNamesArray;
    
//    if (model.shouldShowMoreButton) { // 如果文字高度超过60
//        _moreButton.sd_layout.heightIs(20);
//        _moreButton.hidden = NO;
//        if (model.isOpening) { // 如果需要展开
//            _contentLabel.sd_layout.maxHeightIs(MAXFLOAT);
//            [_moreButton setTitle:@"收起" forState:UIControlStateNormal];
//        } else {
//            _contentLabel.sd_layout.maxHeightIs(maxContentLabelHeight);
//            [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
//        }
//    } else {
//        _moreButton.sd_layout.heightIs(0);
//        _moreButton.hidden = YES;
//    }
    
//    CGFloat picContainerTopMargin = 0;
//    if (model.picNamesArray.count) {
//        picContainerTopMargin = 10;
//    }
//    _picContainerView.sd_layout.topSpaceToView(_moreButton, picContainerTopMargin);
    
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
    [[NSNotificationCenter defaultCenter] postNotificationName:kSDTimeLineCellOperationButtonClickedNotification object:_operationButton];
}

@end
