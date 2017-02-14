//
//  YB_SliderBtnView.m
//  GolfIOS
//
//  Created by yangbin on 16/11/2.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "YB_SliderBtnView.h"

@interface YB_SliderBtnView ()

/**滑动条*/
@property (nonatomic, strong) UIView *sliderView;
/**选中的按钮*/
@property (nonatomic, strong) UIButton *selButton;
/**底部分割线*/
@property (nonatomic, strong) UIView *lineView;
/**记录是否是第一次，取消第一次的动画*/
@property (nonatomic, assign) BOOL isFirst;
/**最长文字长度   设置滑动块的长度*/
@property (nonatomic, assign) NSInteger maxLength;
/**所有的按钮*/
@property (nonatomic, strong) NSMutableArray *btnList;

@end

@implementation YB_SliderBtnView

- (UIView *)sliderView{
    if (_sliderView == nil) {
        _sliderView = [[UIView alloc] init];
        _sliderView.backgroundColor = GLOBALCOLOR;
    }
    return _sliderView;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = GRAYCOLOR;
    }
    return _lineView;
}

- (NSMutableArray *)btnList{
    if (_btnList == nil) {
        _btnList = [[NSMutableArray alloc] init];
    }
    return _btnList;
}


#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.sliderView];
    [self addSubview:self.lineView];
    
    self.lineView.sd_layout
    .bottomSpaceToView(self, 0)
    .leftEqualToView(self)
    .rightEqualToView(self)
    .heightIs(0.5);
}

- (void)setButtonTitleArray:(NSArray *)array{
    
    if (array) {
        for (NSString *string in array) {
            if (self.maxLength < string.length) {
                self.maxLength = string.length;
            }
        }
        for (NSInteger i = 0; i< array.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.titleLabel.font = FONT(14);
            [button setTitle:array[i] forState:UIControlStateNormal];
            [button setTitleColor:GLOBALCOLOR forState:UIControlStateSelected];
            [button setTitleColor:SHENTEXTCOLOR forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
            CGFloat width = self.frame.size.width / array.count;
            button.tag = i;
            CGFloat height = self.frame.size.height - 2.5;
            button.frame = CGRectMake(i * width, 0, width, height);
            //分割竖线
            if (array.count > 1) {
                UIView *sepView = [[UIView alloc] init];
                sepView.backgroundColor = BACKGROUNDCOLOR;
                sepView.frame = CGRectMake((i+1) * width, self.frame.size.height * 0.25, 1, height * 0.5);
                [self addSubview:sepView];
            }
    
            [self addSubview:button];
            [self.btnList addObject:button];
            if (i == 0) {
                _isFirst = YES;
                [self buttonDidClick:button];
            }
            _isFirst = NO;
        }

    }
    
}

- (void)refreshButtonTitleWithArray:(NSArray *)array{
    weak(self)
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *title = obj;
        UIButton *button = weakSelf.btnList[idx];
        [button setTitle:title forState:UIControlStateNormal];
    }];
}

#pragma mark - Action

- (void)buttonDidClick:(UIButton *)button{
    self.selButton.selected = NO;
    self.selButton = button;
    self.selButton.selected = YES;
    
//    NSString *str = button.currentTitle;
    CGFloat sliderWidth = self.maxLength * 15;
    if (_isFirst) {
        self.sliderView.sd_resetLayout
        .bottomSpaceToView(self, 0)
        .centerXEqualToView(button)
        .widthIs(sliderWidth)
        .heightIs(2);
        [self.sliderView updateLayout];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            self.sliderView.sd_resetLayout
            .bottomSpaceToView(self, 0)
            .centerXEqualToView(button)
            .widthIs(sliderWidth)
            .heightIs(2);
            [self.sliderView updateLayout];
        }];
    }
    
    if ([self.delegate respondsToSelector:@selector(yb_SliderBtnView:buttonDidClicked:)]) {
        [self.delegate yb_SliderBtnView:self buttonDidClicked:button];
    }
}




@end
