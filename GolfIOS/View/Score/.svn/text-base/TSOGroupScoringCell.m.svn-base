//
//  TSOGroupScoringCell.m
//  GolfIOS
//
//  Created by yangbin on 16/11/16.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TSOGroupScoringCell.h"
#import "TSOScroeButton.h"

@interface TSOGroupScoringCell ()


/**顶部容器视图*/
@property (nonatomic, strong) UIView *topView;
/**标准杆*/
@property (nonatomic, strong) UILabel *standardLabel;
/**3分按钮*/
@property (nonatomic, strong) TSOScroeButton *score3Btn;
/**4分按钮*/
@property (nonatomic, strong) TSOScroeButton *score4Btn;
/**5分按钮*/
@property (nonatomic, strong) TSOScroeButton *score5Btn;
/**球员*/
@property (nonatomic, strong) UILabel *playerLabel;
/**杆数*/
@property (nonatomic, strong) UILabel *scoreLabel;
/**总杆*/
@property (nonatomic, strong) UILabel *totalScoreLabel;

/**球员容器视图*/
@property (nonatomic, strong) UIView *playerContainerView;
/**选中的标准杆按钮*/
@property (nonatomic, strong) TSOScroeButton *selectedBtn;
/**标准杆按钮数组*/
@property (nonatomic, strong) NSMutableArray *standardArray;


@end

static CGFloat kButtonHeight = 50;
static CGFloat kButtonWidth = 50;
#define kPlayerViewHeight self.contentView.size.height * 0.18

@implementation TSOGroupScoringCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    [self.contentView addSubview:self.topView];
    [self.topView addSubview:self.standardLabel];
    [self.topView addSubview:self.score3Btn];
    [self.topView addSubview:self.score4Btn];
    [self.topView addSubview:self.score5Btn];
    [self.topView addSubview:self.playerLabel];
    [self.topView addSubview:self.scoreLabel];
    [self.topView addSubview:self.totalScoreLabel];
    [self.contentView addSubview:self.playerContainerView];
    
    _standardArray = [[NSMutableArray alloc] init];
    
    [_standardArray addObject:_score3Btn];
    [_standardArray addObject:_score4Btn];
    [_standardArray addObject:_score5Btn];
    
    self.topView.sd_layout
    .topSpaceToView(self.contentView, 0)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightRatioToView(self.contentView, 0.28);
    
    self.standardLabel.sd_layout
    .topSpaceToView(self.topView, 10)
    .centerXEqualToView(self.topView)
    .autoHeightRatio(0);
    [self.standardLabel  setSingleLineAutoResizeWithMaxWidth:100];
    
    self.score4Btn.sd_layout
    .centerYEqualToView(self.topView)
    .centerXEqualToView(self.topView)
    .widthIs(kButtonWidth)
    .heightIs(kButtonHeight);
    self.score4Btn.sd_cornerRadius = [NSNumber numberWithFloat:kButtonHeight * 0.5];
 
    self.score3Btn.sd_layout
    .topEqualToView(self.score4Btn)
    .rightSpaceToView(self.score4Btn,kButtonHeight)
    .widthIs(kButtonWidth)
    .heightIs(kButtonHeight);
    self.score3Btn.sd_cornerRadius = [NSNumber numberWithFloat:kButtonHeight * 0.5];
    
    self.score5Btn.sd_layout
    .topEqualToView(self.score4Btn)
    .leftSpaceToView(self.score4Btn,kButtonHeight)
    .widthIs(kButtonWidth)
    .heightIs(kButtonHeight);
    self.score5Btn.sd_cornerRadius = [NSNumber numberWithFloat:kButtonHeight * 0.5];
    
    self.scoreLabel.sd_layout
    .bottomSpaceToView(self.topView, 10)
    .centerXEqualToView(self.topView)
    .autoHeightRatio(0);
    [self.scoreLabel setSingleLineAutoResizeWithMaxWidth:70];
    
    self.playerLabel.sd_layout
    .topEqualToView(self.scoreLabel)
    .leftSpaceToView(self.topView, 25)
    .autoHeightRatio(0);
    [self.playerLabel setSingleLineAutoResizeWithMaxWidth:70];
    
    self.totalScoreLabel.sd_layout
    .topEqualToView(self.scoreLabel)
    .rightSpaceToView(self.topView, 25)
    .autoHeightRatio(0);
    [self.totalScoreLabel setSingleLineAutoResizeWithMaxWidth:70];
    
    

}



- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    NSMutableDictionary *playerDataDict = _dataArray[self.tag];
    
    
    for (UIView *subView in [self.playerContainerView subviews]) {
        [subView removeFromSuperview];
    }
//    NSLog(@"%@",playerDataDict);
   
    //刷新标准杆按钮状态
    NSNumber *standNum = [playerDataDict objectForKey:@"standardNum"];
    int indexStandard = standNum.intValue - 3;
    [_standardArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TSOScroeButton *currentStandardBtn = (TSOScroeButton *)obj;
        if (idx == indexStandard) {
            _selectedBtn = currentStandardBtn;
            _selectedBtn.selected = YES;
            _selectedBtn.layer.borderColor = GLOBALCOLOR.CGColor;
        }else{
            currentStandardBtn.selected = NO;
            currentStandardBtn.layer.borderColor = SHENTEXTCOLOR.CGColor;
        }
    }];
    
    
    //有几个球员参加比赛
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    for (NSString *key in [playerDataDict allKeys]) {
        if (key.length == 7) {
            [keys addObject:key];

        }
    }
    [keys sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *str1 = (NSString *)obj1;
        NSString *str2 = (NSString *)obj2;
        return [str1 compare:str2];
        
    }];
    //取出球员信息
    
    for (int i = 0; i< keys.count ; i ++) {
        UIView *playerView = [[UIView alloc] init];
        NSString *key = keys[i];
        [self.playerContainerView addSubview:playerView];
        playerView.frame = CGRectMake(0, kPlayerViewHeight * i, SCREEN_WIDTH , kPlayerViewHeight);
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = LIGHTTEXTCOLOR;
        lineView.frame = CGRectMake(20, 0, SCREEN_WIDTH - 40, 0.5);
        [playerView addSubview:lineView];
        
        
        TSOScroeButton *scoreBtn = [[TSOScroeButton alloc] init];
        [scoreBtn setScore:[playerDataDict objectForKey:keys[i]]];
        [playerView addSubview:scoreBtn];
        scoreBtn.sd_layout
        .centerXEqualToView(playerView)
        .centerYEqualToView(playerView)
        .widthIs(kButtonWidth)
        .heightIs(kButtonHeight);
        scoreBtn.sd_cornerRadius = [NSNumber numberWithInteger:kButtonWidth *0.5];
        scoreBtn.player = key;
        [scoreBtn addTarget:self action:@selector(scoreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel *playerNameLb = [[UILabel alloc] init];
        playerNameLb.font = FONT(12);
        playerNameLb.textColor = BLACKCOLOR;
        [playerView addSubview:playerNameLb];
        playerNameLb.sd_layout
        .leftSpaceToView(playerView, 25)
        .centerYEqualToView(playerView)
        .autoHeightRatio(0);
        [playerNameLb setSingleLineAutoResizeWithMaxWidth:100];
        
        UILabel *totalScoreLabel = [[UILabel alloc] init];
        totalScoreLabel.font = FONT(12);
        totalScoreLabel.textColor = BLACKCOLOR;
        NSNumber *number = [playerDataDict objectForKey:[NSString stringWithFormat:@"total%@",keys[i]]];
        
        
        totalScoreLabel.text = number.stringValue;
        [playerView addSubview:totalScoreLabel];
        totalScoreLabel.sd_layout
        .rightSpaceToView(playerView,  25)
        .centerYEqualToView(playerView)
        .autoHeightRatio(0);
        [totalScoreLabel setSingleLineAutoResizeWithMaxWidth:100];
        
        playerNameLb.text = [playerDataDict objectForKey:[NSString stringWithFormat:@"%@name",keys[i]]];

    }

}





#pragma mark - Action

- (void)standardBtnClick:(TSOScroeButton *)button{
    
    
    _selectedBtn.selected = NO;
    _selectedBtn.layer.borderColor = SHENTEXTCOLOR.CGColor;
    _selectedBtn = button;
    _selectedBtn.selected = YES;
    _selectedBtn.layer.borderColor = GLOBALCOLOR.CGColor;
    
    if ([self.delegate respondsToSelector:@selector(tsoGroupScoringCell:standardBtnDidClick:)]) {
        [self.delegate tsoGroupScoringCell:self standardBtnDidClick:button];
    }
}

- (void)scoreBtnClick:(TSOScroeButton *)button{
    
    
    if ([self.delegate respondsToSelector:@selector(tsoGroupScoringCell:scoreBtnDidClick:score:)])
    {
        [self.delegate tsoGroupScoringCell:self scoreBtnDidClick:button score:button.score];
    }
    
}


#pragma mark - Setter&Getter

- (UIView *)topView{
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
    }
    return _topView;
}

- (UILabel *)standardLabel{
    if (_standardLabel == nil) {
        _standardLabel = [[UILabel alloc] init];
        _standardLabel.textColor = BLACKCOLOR;
        _standardLabel.font = FONT(10);
        _standardLabel.text = @"标准杆";
    }
    return _standardLabel;
}
- (TSOScroeButton *)score3Btn{
    if (_score3Btn == nil) {
        _score3Btn = [[TSOScroeButton alloc] init];
        [_score3Btn setScore:@3];
        _score3Btn.layer.borderColor = LIGHTTEXTCOLOR.CGColor;
        [_score3Btn setTitleColor:SHENTEXTCOLOR forState:UIControlStateNormal];
        [_score3Btn setTitleColor:GLOBALCOLOR forState:UIControlStateSelected];
        [_score3Btn addTarget:self action:@selector(standardBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _score3Btn;
}

- (TSOScroeButton *)score4Btn{
    if (_score4Btn == nil) {
        _score4Btn = [[TSOScroeButton alloc] init];
        [_score4Btn setScore:@4];
        _score4Btn.layer.borderColor = LIGHTTEXTCOLOR.CGColor;
        [_score4Btn setTitleColor:SHENTEXTCOLOR forState:UIControlStateNormal];
        [_score4Btn setTitleColor:GLOBALCOLOR forState:UIControlStateSelected];
        [_score4Btn addTarget:self action:@selector(standardBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _score4Btn;
}

- (TSOScroeButton *)score5Btn{
    if (_score5Btn == nil) {
        _score5Btn = [[TSOScroeButton alloc] init];
        [_score5Btn setScore:@5];
        _score5Btn.layer.borderColor = LIGHTTEXTCOLOR.CGColor;
        [_score5Btn setTitleColor:SHENTEXTCOLOR forState:UIControlStateNormal];
        [_score5Btn setTitleColor:GLOBALCOLOR forState:UIControlStateSelected];
        [_score5Btn addTarget:self action:@selector(standardBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _score5Btn;
}

- (UILabel *)playerLabel{
    if (_playerLabel == nil) {
        _playerLabel = [[UILabel alloc] init];
        _playerLabel.font = FONT(10);
        _playerLabel.text = @"球员";
    }
    return _playerLabel;
}
- (UILabel *)scoreLabel{
    if (_scoreLabel == nil) {
        _scoreLabel = [[UILabel alloc] init];
        _scoreLabel.font = FONT(10);
        _scoreLabel.text = @"杆数";
    }
    return _scoreLabel;
}
- (UILabel *)totalScoreLabel{
    if (_totalScoreLabel == nil) {
        _totalScoreLabel = [[UILabel alloc] init];
        _totalScoreLabel.font = FONT(10);
        _totalScoreLabel.text = @"总杆";
    }
    return _totalScoreLabel;
}

- (UIView *)playerContainerView{
    if (_playerContainerView == nil) {
        _playerContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.size.height * 0.28, SCREEN_WIDTH, self.contentView.size.height * 0.72)];
        
    }
    return _playerContainerView;
}

@end
