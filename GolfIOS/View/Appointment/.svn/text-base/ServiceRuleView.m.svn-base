//
//  ServiceRuleView.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/16.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "ServiceRuleView.h"



static CGFloat const kAnimationDutation = 0.25;
static CGFloat const kCornerRadius = 10;

@interface ServiceRuleView ()

@property(nonatomic,weak) UIButton *bgButton;

@property(nonatomic,weak) UIView *contentView;

@property (nonatomic, strong) UILabel *titleLb;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UILabel *contentLb;

@property (nonatomic, copy) NSString *message;


@end

@implementation ServiceRuleView

- (instancetype)initWithFrame:(CGRect)frame message:(NSString *)message{
    self = [super initWithFrame:frame];
    if (self) {
        _message = message;
    }
    return self;
}

- (void)setupFrame
{
    
    //bgBtn
    self.bgButton.frame = self.bounds;
    self.contentView.sd_layout
    .centerYEqualToView(self.bgButton)
    .centerXEqualToView(self.bgButton)
    .widthIs(SCREEN_WIDTH  -30)
    .heightIs(160);
    
    self.titleLb.sd_layout
    .topSpaceToView(_contentView, 0)
    .leftSpaceToView(_contentView, 0)
    .rightSpaceToView(_contentView, 0)
    .heightIs(27);
    
    self.cancelBtn.sd_layout
    .centerYEqualToView(_titleLb)
    .rightSpaceToView(_contentView, 5)
    .heightIs(27)
    .widthIs(27);
    
    self.contentLb.sd_layout
    .topSpaceToView(_titleLb, 0)
    .leftSpaceToView(_contentView, 15)
    .rightSpaceToView(_contentView, 15)
    .autoHeightRatio(0);
    
    _contentLb.text = _message;
    
    //contentView
//    CGFloat contentViewWidth = SCREEN_WIDTH - 30;
//    CGFloat contentViewX = (self.frame.size.width-contentViewWidth)/2;
//    CGFloat contentViewY = (self.frame.size.height-contentViewHeight)/2;
//    self.contentView.frame = CGRectMake(contentViewX, contentViewY, contentViewWidth, contentViewHeight);
}
- (void)show
{
    [self setupFrame];

    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    [window.layer removeAllAnimations];
    [window addSubview:self];
    [self showBackground];
    [self showAlertAnimation];
}
- (void)lightColor
{
    self.bgButton.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
    self.contentView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.1];
}

- (void)darkColor
{
    self.bgButton.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)showBackground
{
    [self lightColor];
    [UIView animateWithDuration:kAnimationDutation animations:^{
        [self darkColor];
    }];
}

-(void)showAlertAnimation
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = kAnimationDutation;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.contentView.layer addAnimation:animation forKey:nil];
}

- (void)dismiss
{
    [UIView animateWithDuration:kAnimationDutation animations:^{
        [self lightColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)bgButtonClicked
{
    [self dismiss];
}

- (UIButton *)bgButton
{
    if (!_bgButton) {
        UIButton *bgButton = [[UIButton alloc] init];
        bgButton.backgroundColor = [UIColor blackColor];
        [bgButton addTarget:self action:@selector(bgButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bgButton];
        _bgButton = bgButton;
    }
    return _bgButton;
}

- (UIView *)contentView
{
    if (!_contentView) {
        UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.cornerRadius = kCornerRadius;
        contentView.layer.masksToBounds = YES;
        
        contentView.autoresizingMask = (UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin |
                                        UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin);
        [self.bgButton addSubview:contentView];
        [contentView addSubview:self.contentLb];
        [contentView addSubview:self.titleLb];
        [contentView addSubview:self.cancelBtn];
        _contentView = contentView;
    }
    return _contentView;
}

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.backgroundColor = GLOBALCOLOR;
        _titleLb.font = FONT(14);
        _titleLb.textColor = WHITECOLOR;
        _titleLb.text = @"服务条例";
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.userInteractionEnabled = YES;
    }
    return _titleLb;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setImage:IMAGE(@"classify218") forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(bgButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UILabel *)contentLb{
    if (!_contentLb) {
        _contentLb = [[UILabel alloc] init];
        _contentLb.font = FONT(12);
        _contentLb.textColor = BLACKTEXTCOLOR;
    }
    return _contentLb;
}

@end
