//
//  TSOUSelectHoleView.m
//  GolfIOS
//
//  Created by yangbin on 16/11/21.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TSOUSelectHoleView.h"
#import "UIImage+Image.h"
#import "ScoreInfo.h"

@interface TSOUSelectHoleView ()

/**选中的按钮*/
@property (nonatomic, strong) UIButton *selectedBtn;
/**OUT*/
@property (nonatomic, strong) UILabel *outLabel;
/**in*/
@property (nonatomic, strong) UILabel *inLabel;
/** array*/
@property (nonatomic, strong) NSMutableArray *btnArray;
/**初始选中的按钮*/
@property (nonatomic, assign) NSInteger selectIndex;
/**groupInfo*/
@property (nonatomic, strong) GroupInfo *groupInfo;

@end

#define kBtnWidth  (self.size.width - 30) * 0.2
#define kBtnHeight (self.size.height - 60) * 0.25

@implementation TSOUSelectHoleView

- (instancetype)initWithGroupInfo:(GroupInfo *)groupInfo{
    if (self = [super init]) {
        self.groupInfo = groupInfo;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.backgroundColor = WHITECOLOR;
    }
    return self;
}

- (void)setupUI{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4;
    
    for (int i = 0 ; i< 18; i ++) {
        UIButton *holeBtn = [[UIButton alloc] init];
        holeBtn.tag = i + 1;
        if (i < 9) {
            [holeBtn setTitle:[NSString stringWithFormat:@"%@%zd",_groupInfo.beforeField,holeBtn.tag] forState:UIControlStateNormal];
        }else{
            [holeBtn setTitle:[NSString stringWithFormat:@"%@%zd",_groupInfo.afterField,holeBtn.tag] forState:UIControlStateNormal];
        }
        
        [self addSubview:holeBtn];
        holeBtn.layer.cornerRadius = 3;
        holeBtn.layer.masksToBounds = YES;
        [holeBtn setTitleColor:LIGHTTEXTCOLOR forState:UIControlStateNormal];
        [holeBtn setTitleColor:GLOBALCOLOR forState:UIControlStateSelected];
        
        [holeBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:213 green:243 blue:243]] forState:UIControlStateSelected];
        
        [holeBtn addTarget:self action:@selector(holeBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        if (i < 9) {
            int y = i / 5;
            int x = i % 5;
            holeBtn.frame = CGRectMake(x * kBtnWidth + 15, y * kBtnHeight + 45, kBtnWidth, kBtnHeight);
        }else{
            int y = (i + 1)/ 5;
            int x = (i + 1) % 5;
            holeBtn.frame = CGRectMake(x * kBtnWidth + 15, y * kBtnHeight + 45, kBtnWidth, kBtnHeight);
        }
        [self.btnArray addObject:holeBtn];
    }
    
    [self addSubview:self.outLabel];
    [self addSubview:self.inLabel];
    
    self.outLabel.frame = CGRectMake(4 * kBtnWidth + 15, 1 * kBtnHeight + 45, kBtnWidth, kBtnHeight);
    self.inLabel.frame = CGRectMake(4 * kBtnWidth + 15, 3 * kBtnHeight + 45, kBtnWidth, kBtnHeight);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self setupUI];
    
    UIButton *btn = self.btnArray[_selectIndex];
    _selectedBtn.selected = NO;
    _selectedBtn = btn;
    _selectedBtn.selected = YES;
}


- (void)clickBtnAtIndex:(NSInteger)index{
    _selectIndex = index;
    if (self.btnArray.count >0) {
        UIButton *btn = self.btnArray[_selectIndex];
        _selectedBtn.selected = NO;
        _selectedBtn = btn;
        _selectedBtn.selected = YES;
    }
}


- (void)holeBtnDidClicked:(UIButton *)button{
    _selectedBtn.selected = NO;
    _selectedBtn = button;
    _selectedBtn.selected = YES;
    
    if ([self.delegate respondsToSelector:@selector(TSOUSelectHoleView:holeButtonDidClick:)]) {
        [self.delegate TSOUSelectHoleView:self holeButtonDidClick:button];
    }
}

- (UILabel *)outLabel{
    if (_outLabel == nil) {
        _outLabel = [[UILabel alloc] init];
        _outLabel.font = FONT(14);
        _outLabel.textColor = GLOBALCOLOR;
        _outLabel.text = @"OUT";
        _outLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _outLabel;
}

- (UILabel *)inLabel{
    if (_inLabel == nil) {
        _inLabel = [[UILabel alloc] init];
        _inLabel.font = FONT(14);
        _inLabel.textColor = GLOBALCOLOR;
        _inLabel.text = @"IN";
        _inLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _inLabel;
}

- (NSMutableArray *)btnArray{
    if (_btnArray == nil) {
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}

@end
