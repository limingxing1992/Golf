//
//  MyInviteCommentView.m
//  GolfIOS
//
//  Created by yangbin on 16/11/24.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyInviteCommentView.h"
#import "SDTimeLineCellModel.h"
#import "MLLinkLabel.h"

@interface MyInviteCommentView ()
<
MLLinkLabelDelegate
>

@property (nonatomic, strong) NSArray *likeItemsArray;
@property (nonatomic, strong) NSArray *commentItemsArray;

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) MLLinkLabel *likeLabel;
@property (nonatomic, strong) UIView *likeLableBottomLine;

@property (nonatomic, strong) NSMutableArray *commentLabelsArray;

@end

@implementation MyInviteCommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupViews];
        
        //设置主题
//        [self configTheme];
        
    }
    return self;
}

- (void)setupViews
{
    _bgImageView = [UIImageView new];
    UIImage *bgImage = [UIImage imageNamed:@"classify186"];
//    UIImage *bgImage = [[[UIImage imageNamed:@"classify186"] stretchableImageWithLeftCapWidth:self.frame.size.width *0.5 topCapHeight:40] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    _bgImageView.image = bgImage;
    _bgImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_bgImageView];
    
    _likeLabel = [MLLinkLabel new];
    _likeLabel.font = [UIFont systemFontOfSize:12];
    _likeLabel.linkTextAttributes = @{NSForegroundColorAttributeName : SHENTEXTCOLOR};
    _likeLabel.isAttributedContent = YES;
    [self addSubview:_likeLabel];
    
    _likeLableBottomLine = [UIView new];
    [self addSubview:_likeLableBottomLine];
    
    _bgImageView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

- (void)setupWithLikeItemsArray:(NSArray *)likeItemsArray commentItemsArray:(NSArray *)commentItemsArray
{
    
    self.likeItemsArray = likeItemsArray;
    self.commentItemsArray = commentItemsArray;
    
    if (self.commentLabelsArray.count) {
        [self.commentLabelsArray enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop) {
            [label sd_clearAutoLayoutSettings];
            label.hidden = YES; //重用时先隐藏所以评论label，然后根据评论个数显示label
        }];
    }
    
    if (!commentItemsArray.count && !likeItemsArray.count) {
        self.fixedWidth = @(0); // 如果没有评论或者点赞，设置commentview的固定宽度为0（设置了fixedWith的控件将不再在自动布局过程中调整宽度）
        self.fixedHeight = @(0); // 如果没有评论或者点赞，设置commentview的固定高度为0（设置了fixedHeight的控件将不再在自动布局过程中调整高度）
        return;
    } else {
        self.fixedHeight = nil; // 取消固定宽度约束
        self.fixedWidth = nil; // 取消固定高度约束
    }
    
    CGFloat margin = 5;
    
    UIView *lastTopView = nil;
    
    if (likeItemsArray.count) {
        _likeLabel.sd_resetLayout
        .leftSpaceToView(self, margin)
        .rightSpaceToView(self, margin)
        .topSpaceToView(lastTopView, 10)
        .autoHeightRatio(0);
        
        lastTopView = _likeLabel;
    } else {
        _likeLabel.attributedText = nil;
        _likeLabel.sd_resetLayout
        .heightIs(0);
    }
    
    
    if (self.commentItemsArray.count && self.likeItemsArray.count) {
        _likeLableBottomLine.sd_resetLayout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .heightIs(1)
        .topSpaceToView(lastTopView, 3);
        
        lastTopView = _likeLableBottomLine;
    } else {
        _likeLableBottomLine.sd_resetLayout.heightIs(0);
    }
    
    for (int i = 0; i < self.commentItemsArray.count; i++) {
        UILabel *label = (UILabel *)self.commentLabelsArray[i];
        label.hidden = NO;
        CGFloat topMargin = (i == 0 && likeItemsArray.count == 0) ? 10 : 5;
        label.sd_layout
        .leftSpaceToView(self, 8)
        .rightSpaceToView(self, 5)
        .topSpaceToView(lastTopView, topMargin)
        .autoHeightRatio(0);
        label.font = FONT(12);
        label.isAttributedContent = YES;
        lastTopView = label;
    }
    
    [self setupAutoHeightWithBottomView:lastTopView bottomMargin:6];
}

- (void)setCommentItemsArray:(NSArray *)commentItemsArray
{
    _commentItemsArray = commentItemsArray;
    
    long originalLabelsCount = self.commentLabelsArray.count;
    long needsToAddCount = commentItemsArray.count > originalLabelsCount ? (commentItemsArray.count - originalLabelsCount) : 0;
    for (int i = 0; i < needsToAddCount; i++) {
        MLLinkLabel *label = [MLLinkLabel new];
        
       
//        UIColor *highLightColor = TimeLineCellHighlightedColor;
        label.linkTextAttributes = @{NSForegroundColorAttributeName : GLOBALCOLOR};
        
//        label.lee_theme
//        .LeeAddTextColor(DAY , [UIColor blackColor])
//        .LeeAddTextColor(NIGHT , [UIColor grayColor]);
        label.textColor = SHENTEXTCOLOR;
        label.font = [UIFont systemFontOfSize:12];
        label.delegate = self;
        [self addSubview:label];
        [self.commentLabelsArray addObject:label];
    }
    
    for (int i = 0; i < commentItemsArray.count; i++) {
        
        //设置label内容yb
        
        SDTimeLineCellCommentItemModel *model = commentItemsArray[i];
        MLLinkLabel *label = self.commentLabelsArray[i];
        if (!model.attributedContent) {
            model.attributedContent = [self generateAttributedStringWithCommentItemModel:model];
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentLabeleDidClick:)];
        label.tag = i;//test
        label.attributedText = model.attributedContent;
        [label addGestureRecognizer:tap];
    }
}

- (void)commentLabeleDidClick:(UITapGestureRecognizer *)tap{

    MLLinkLabel *label = (MLLinkLabel *)tap.view;
    SDTimeLineCellCommentItemModel *model = self.commentItemsArray[label.tag];
    NSString *commentId = model.ID.stringValue;
    if (self.didClickCommentLabelBlock) {
        self.didClickCommentLabelBlock(commentId ,model.firstUserName, label.frame,label.tag);
    }
}

- (NSMutableArray *)commentLabelsArray
{
    if (!_commentLabelsArray) {
        _commentLabelsArray = [NSMutableArray new];
    }
    return _commentLabelsArray;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}


#pragma mark - private actions

- (NSMutableAttributedString *)generateAttributedStringWithCommentItemModel:(SDTimeLineCellCommentItemModel *)model
{
    NSString *text = model.firstUserName;
    if (model.secondUserName.length) {
        text = [text stringByAppendingString:[NSString stringWithFormat:@"回复%@", model.secondUserName]];
    }
    text = [text stringByAppendingString:[NSString stringWithFormat:@"：%@", model.commentString]];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    
    [attString setAttributes:@{NSLinkAttributeName : @"12"} range:[text rangeOfString:model.firstUserName]];
//    [attString setAttributes:@{NSLinkAttributeName : model.firstUserId} range:[text rangeOfString:model.firstUserName]];//yb
    if (model.secondUserName.length) {
//        [attString setAttributes:@{NSLinkAttributeName : model.secondUserId} range:[text rangeOfString:model.secondUserName]];
        [attString setAttributes:@{NSLinkAttributeName : @"34"} range:[text rangeOfString:model.secondUserName]];
        
    }
   
//    NSLog(@"----------------------------%@",attString);
    return attString;
}


#pragma mark - MLLinkLabelDelegate

- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel
{
//    NSLog(@"%@", link.linkValue);
//    NSString *commentId = [NSString stringWithFormat:@"%ld",(long)linkLabel.tag];
//    if (self.didClickCommentLabelBlock) {
//        self.didClickCommentLabelBlock(commentId ,linkText, linkLabel.frame);
//    }
}
@end
