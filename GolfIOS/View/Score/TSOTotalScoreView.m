//
//  TSOTotalScoreView.m
//  GolfIOS
//
//  Created by yangbin on 16/12/28.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TSOTotalScoreView.h"

@interface TSOTotalScoreView ()

/**推杆*/
@property (nonatomic, strong) UILabel *tuiGanLb;
/**总杆*/
@property (nonatomic, strong) UILabel *zongGanLb;


/**推杆减号btn*/
@property (nonatomic, strong) UIButton *pushMinusBtn;
/**推杆加号btn*/
@property (nonatomic, strong) UIButton *pushPlusBtn;

/**总杆减号btn*/
@property (nonatomic, strong) UIButton *totalMinusBtn;
/**总分加号btn*/
@property (nonatomic, strong) UIButton *totalPlusBtn;

/**总分Lb*/
@property (nonatomic, strong) UILabel *totalScoreLb;
/**推杆分数Label*/
@property (nonatomic, strong) UILabel *pushScoreLb;




@end

@implementation TSOTotalScoreView





- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    [self sd_addSubviews:@[self.pushMinusBtn,self.tuiGanLb,self.pushPlusBtn,self.totalScoreLb,self.totalMinusBtn,self.zongGanLb,self.totalPlusBtn]];
    [self.totalScoreLb addSubview:self.pushScoreLb];
    
    CGFloat btnW = 30 * KWidth_Scale;
    CGFloat margin = 5;
    
    self.pushMinusBtn.sd_layout
    .leftSpaceToView(self,margin)
    .topSpaceToView(self, margin)
    .widthIs(btnW)
    .heightIs(btnW);
    
    self.tuiGanLb.sd_layout
    .centerXEqualToView(self)
    .centerYEqualToView(self.pushMinusBtn)
    .autoHeightRatio(0)
    .widthIs(30);
    
    self.pushPlusBtn.sd_layout
    .topSpaceToView(self, margin)
    .rightSpaceToView(self, margin)
    .heightIs(btnW)
    .widthIs(btnW);
    
    self.totalMinusBtn.sd_layout
    .leftSpaceToView(self, margin)
    .bottomSpaceToView(self, margin)
    .heightIs(btnW)
    .widthIs(btnW);
    
    self.totalScoreLb.sd_layout
    .centerXEqualToView(self)
    .centerYEqualToView(self)
    .widthIs(100 * KWidth_Scale)
    .heightIs(100 * KWidth_Scale);
    [self.totalScoreLb setSd_cornerRadiusFromHeightRatio:@0.5];

    
    self.zongGanLb.sd_layout
    .centerXEqualToView(self)
    .centerYEqualToView(self.totalMinusBtn)
    .autoHeightRatio(0)
    .widthIs(30);
    
    self.totalPlusBtn.sd_layout
    .rightSpaceToView(self, margin)
    .bottomSpaceToView(self, margin)
    .widthIs(btnW)
    .heightIs(btnW);
    
    self.pushScoreLb.sd_layout
    .topSpaceToView(self.totalScoreLb, 15)
    .rightSpaceToView(self.totalScoreLb, 15)
    .autoHeightRatio(0)
    .widthIs(10);
    
    self.pushNum = @1;
    self.beginTotalNum = @1;
}

- (void)setBeginTotalNum:(NSNumber *)beginTotalNum{
    _beginTotalNum = beginTotalNum;
//    if (beginTotalNum.integerValue == 0) {
//        _beginTotalNum = @1;
//    }
    self.totalScoreLb.text = _beginTotalNum.stringValue;
}


- (void)setPushNum:(NSNumber *)pushNum{
    _pushNum = pushNum;
    self.pushScoreLb.text = _pushNum.stringValue;
}

- (UILabel *)tuiGanLb{
    if (_tuiGanLb == nil) {
        _tuiGanLb = [[UILabel alloc] init];
        _tuiGanLb.font = FONT(14);
        _tuiGanLb.textColor = BLACKTEXTCOLOR;
        _tuiGanLb.text = @"推杆";
    }
    return _tuiGanLb;
}

- (UILabel *)zongGanLb{
    if (_zongGanLb == nil) {
        _zongGanLb = [[UILabel alloc] init];
        _zongGanLb.font = FONT(14);
        _zongGanLb.textColor = BLACKTEXTCOLOR;
        _zongGanLb.text = @"总杆";
    }
    return _zongGanLb;
}

//MARK: - Action

//推杆+
- (void)pushPlusBtnClick{
    
    
    //推杆加 总杆也加
    NSInteger standard = self.beginTotalNum.integerValue;
    
    NSInteger push = self.pushNum.integerValue;
    
    
    if (push < 9) {
        push ++;
    }
    
    
    //总杆数大于0 并
    if (push >= standard && standard < 9 && standard > 0) {
       standard ++;
    }
    
//    if (standard > 9) {
//        standard = 1;
//    }
    self.beginTotalNum = [NSNumber numberWithInteger:standard];
    
    self.pushNum = [NSNumber numberWithInteger:push];
    self.callBack(_beginTotalNum,_pushNum);
}
//推杆-
- (void)pushMinusBtnClick{
    NSInteger push = self.pushNum.integerValue;
    push --;
    if (push < 0) {
        push = 0;
    }
    self.pushNum = [NSNumber numberWithInteger:push];
    self.callBack(_beginTotalNum,_pushNum);
}
//总杆+
- (void)totalPlusBtnClick{
    NSInteger standard = self.beginTotalNum.integerValue;

    
    if (standard < 9) {
        standard ++;
    }
    
    
   
    self.beginTotalNum = [NSNumber numberWithInteger:standard];
    self.callBack(_beginTotalNum,_pushNum);
}
//总杆-
- (void)totalMinusBtnClick{
    NSInteger standard = self.beginTotalNum.integerValue;
    NSInteger push = self.pushNum.integerValue;
    standard --;
    if (standard < 1) {
        standard = 1;
    }
    
    
    if (push >= standard && standard > 0) {
        push --;
    }
     self.pushNum = [NSNumber numberWithInteger:push];
    
    self.beginTotalNum = [NSNumber numberWithInteger:standard];
    
    self.callBack(_beginTotalNum,_pushNum);
}

- (void)scoreChanged:(ScoreBlock)scoreChange{
    if (scoreChange) {
        _callBack = scoreChange;
    }
}

//MARK: - Setter&Getter
- (UIButton *)pushPlusBtn{
    
    if (_pushPlusBtn == nil) {
        _pushPlusBtn = [[UIButton alloc] init];
        [_pushPlusBtn setImage:IMAGE(@"yb_add_normal") forState:UIControlStateNormal];
        [_pushPlusBtn setImage:IMAGE(@"yb_add_disable") forState:UIControlStateDisabled];
        [_pushPlusBtn addTarget:self action:@selector(pushPlusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pushPlusBtn;
}

- (UIButton *)pushMinusBtn{
    if (_pushMinusBtn == nil) {
        _pushMinusBtn = [[UIButton alloc] init];
        [_pushMinusBtn setImage:IMAGE(@"yb_subtract_normal") forState:UIControlStateNormal];
        [_pushMinusBtn setImage:IMAGE(@"yb_subtract_disable") forState:UIControlStateDisabled];
        [_pushMinusBtn addTarget:self action:@selector(pushMinusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _pushMinusBtn.imageEdgeInsets = UIEdgeInsetsMake(13 *KHeight_Scale, 0, 13 *KHeight_Scale, 0);
    }
    return _pushMinusBtn;
}

- (UIButton *)totalPlusBtn{
    if (_totalPlusBtn == nil) {
        _totalPlusBtn = [[UIButton alloc] init];
        [_totalPlusBtn setImage:IMAGE(@"yb_add_normal") forState:UIControlStateNormal];
        [_totalPlusBtn setImage:IMAGE(@"yb_add_disable") forState:UIControlStateDisabled];
        [_totalPlusBtn addTarget:self action:@selector(totalPlusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _totalPlusBtn;
}

- (UIButton *)totalMinusBtn{
    if (_totalMinusBtn == nil) {
        _totalMinusBtn = [[UIButton alloc] init];
        [_totalMinusBtn setImage:IMAGE(@"yb_subtract_normal") forState:UIControlStateNormal];
        [_totalMinusBtn setImage:IMAGE(@"yb_subtract_disable") forState:UIControlStateDisabled];
        [_totalMinusBtn addTarget:self action:@selector(totalMinusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _totalMinusBtn.imageEdgeInsets = UIEdgeInsetsMake(13 *KHeight_Scale, 0, 13 *KHeight_Scale, 0);

    }
    return _totalMinusBtn;
}

- (UILabel *)totalScoreLb{
    if (_totalScoreLb == nil) {
        
        _totalScoreLb =[[UILabel alloc] init];
        _totalScoreLb.font = FONT(70);
        _totalScoreLb.backgroundColor = GLOBALCOLOR;
        _totalScoreLb.textColor = WHITECOLOR;
        _totalScoreLb.textAlignment = NSTextAlignmentCenter;
        _totalScoreLb.text = @"1";
        
    }
    return _totalScoreLb;
}


- (UILabel *)pushScoreLb{
    if (_pushScoreLb == nil) {
        _pushScoreLb = [[UILabel alloc] init];
        _pushScoreLb.textColor = WHITECOLOR;
        _pushScoreLb.text = @"0";
    }
    return _pushScoreLb;
}

@end
