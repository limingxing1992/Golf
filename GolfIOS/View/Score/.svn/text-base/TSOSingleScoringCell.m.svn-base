//
//  TSOSingleScoringCell.m
//  GolfIOS
//
//  Created by yangbin on 16/11/11.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOSingleScoringCell.h"
#import "TSOScroeButton.h"
#import "TSOTotalScoreView.h"
#import "ScoreList.h"

@interface TSOSingleScoringCell ()



/**标准杆按钮*/
@property (nonatomic, strong) TSOScroeButton *standardBtn;
/**标准杆标签*/
@property (nonatomic, strong) UILabel *standardTitleLb;

/**计分视图*/
@property (nonatomic, strong) TSOTotalScoreView *scoreView;




@end

#define kMinStandardCount @3
#define kMinScore @0

@implementation TSOSingleScoringCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{

    [self.contentView addSubview:self.standardBtn];
    [self.contentView addSubview:self.standardTitleLb];
    [self.contentView addSubview:self.scoreView];

    self.standardBtn.sd_layout
    .topSpaceToView(self.contentView, 10)
    .centerXEqualToView(self.contentView)
    .heightIs(100 *KHeight_Scale)
    .widthIs(100 * KHeight_Scale);
    self.standardBtn.sd_cornerRadiusFromWidthRatio = @0.5;
    
    self.standardTitleLb.sd_layout
    .topSpaceToView(self.standardBtn, 5)
    .centerXEqualToView(self.contentView)
    .autoHeightRatio(0);
    [self.standardTitleLb setSingleLineAutoResizeWithMaxWidth:50];
    
    self.scoreView.sd_layout
    .topSpaceToView(self.standardTitleLb, 10)
    .centerXEqualToView(self.contentView)
    .heightIs(SCREEN_WIDTH * 0.6 *KHeight_Scale)
    .widthIs(SCREEN_WIDTH * 0.6 *KHeight_Scale);

    
    
    [self.standardBtn setScore:@3];//标准杆初始 为3

    [self.scoreView scoreChanged:^(NSNumber *totalNum, NSNumber *pushNum) {
        NSLog(@"总分%@====推杆%@",totalNum,pushNum);
        if ([self.delegate respondsToSelector:@selector(tsoSingleScoringCell:scoreChanged:pushNumChanged:)]) {
            [self.delegate tsoSingleScoringCell:self scoreChanged:totalNum pushNumChanged:pushNum];
        }
    }];
}


- (void)setStandardNum:(NSNumber *)standardNum{
    _standardNum = standardNum;
    [self.standardBtn setScore:_standardNum];//标准杆初始
   }

- (void)setModel:(Hole *)model{
    _model = model;
    
    self.standardNum = model.par;
    
    if (model.actualBar.integerValue == 0) {
        self.scoreView.beginTotalNum = @1;
    }else{
        self.scoreView.beginTotalNum = model.actualBar;
    }
    
    self.scoreView.pushNum = model.pushBar;
    
}

//每次给mode传递值 都要重新设置按钮的值

#pragma mark - Action

- (void)standardBtnClick:(TSOScroeButton *)button{
    
    NSInteger standard = self.standardNum.integerValue;
    standard ++;
    if (standard == 6) {
        standard = 3;
    }
    self.standardNum = [NSNumber numberWithInteger:standard];
    
    if ([self.delegate respondsToSelector:@selector(tsoSingleScoringCell:standardNumChanged:)]) {
        [self.delegate tsoSingleScoringCell:self standardNumChanged:self.standardNum];
    }
}

#pragma mark - Setter&agetter

- (TSOScroeButton *)standardBtn{
    if (_standardBtn == nil) {
        _standardBtn = [[TSOScroeButton alloc] init];
        [_standardBtn addTarget:self action:@selector(standardBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _standardBtn;
}

- (UILabel *)standardTitleLb{
    if (_standardTitleLb == nil) {
        _standardTitleLb = [[UILabel alloc] init];
        _standardTitleLb.textColor = LIGHTTEXTCOLOR;
        _standardTitleLb.font = FONT(14);
        _standardTitleLb.text = @"PAR";
    }
    return _standardTitleLb;
}

- (TSOTotalScoreView *)scoreView{
    if (_scoreView == nil) {
        _scoreView = [[TSOTotalScoreView alloc] init];
        
    }
    return _scoreView;
}



@end
