//
//  STL_AlertCustomView.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/16.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "STL_AlertCustomView.h"


static CGFloat const kAnimationDutation = 0.25;
static CGFloat const kCornerRadius = 10;

@interface STL_AlertCustomView ()

@property(nonatomic,weak) UIButton *bgButton;

@property(nonatomic,weak) UIView *contentView;

@property (nonatomic, strong) UILabel *titleLb;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UILabel *contentLb;

@property (nonatomic, copy) NSString *message;

@end

@implementation STL_AlertCustomView

- (instancetype)initWithFrame:(CGRect)frame customView:(UIView *)customView{
    self = [super initWithFrame:frame];
    if (self) {
        _contentView = customView;
        [self.bgButton addSubview:_contentView];
        _backContentColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupFrame
{
    //bgBtn
    self.bgButton.frame = self.bounds;
    
    //contentView
    _contentView.center = CGPointMake(SCREEN_WIDTH/2 , SCREEN_HEIGHT /2 + 10);
    _contentView.layer.cornerRadius = kCornerRadius;
    _contentView.clipsToBounds = YES;
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
    self.contentView.backgroundColor = _backContentColor;
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

#pragma mark ----------------代理

- (void)sureWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day week:(NSString *)week{
    [self dismiss];
}

- (void)sureWithTime:(NSString *)time{
    [self dismiss];
}

- (void)sureWithCount:(NSInteger)count{
    [self dismiss];
}

- (void)cancel{
    [self dismiss];
}


//- (UIView *)contentView
//{
//    if (!_contentView) {
//        UIView *contentView = [[UIView alloc] init];
//        contentView.backgroundColor = [UIColor whiteColor];
//        contentView.layer.cornerRadius = kCornerRadius;
//        contentView.layer.masksToBounds = YES;
//        
//        contentView.autoresizingMask = (UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin |
//                                        UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin);
//        [self.bgButton addSubview:contentView];
//        [contentView addSubview:self.contentLb];
//        [contentView addSubview:self.titleLb];
//        [contentView addSubview:self.cancelBtn];
//        _contentView = contentView;
//    }
//    return _contentView;
//}
//
//- (UILabel *)titleLb{
//    if (!_titleLb) {
//        _titleLb = [[UILabel alloc] init];
//        _titleLb.backgroundColor = GLOBALCOLOR;
//        _titleLb.font = FONT(14);
//        _titleLb.textColor = WHITECOLOR;
//        _titleLb.text = @"服务条例";
//        _titleLb.textAlignment = NSTextAlignmentCenter;
//        _titleLb.userInteractionEnabled = YES;
//    }
//    return _titleLb;
//}
//
//- (UIButton *)cancelBtn{
//    if (!_cancelBtn) {
//        _cancelBtn = [[UIButton alloc] init];
//        _cancelBtn.backgroundColor = [UIColor redColor];
//        [_cancelBtn addTarget:self action:@selector(bgButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _cancelBtn;
//}
//
//- (UILabel *)contentLb{
//    if (!_contentLb) {
//        _contentLb = [[UILabel alloc] init];
//        _contentLb.font = FONT(12);
//        _contentLb.textColor = BLACKTEXTCOLOR;
//    }
//    return _contentLb;
//}

@end
