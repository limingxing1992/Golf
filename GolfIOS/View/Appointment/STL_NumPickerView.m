//
//  STL_NumPickerView.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/16.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "STL_NumPickerView.h"

@interface STL_NumPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>

/** 标题*/
@property (nonatomic, strong) UILabel *titleLb;
/** 当前选择内容*/
@property (nonatomic, strong) UILabel *messageLb;
/** 底部按钮视图*/
@property (nonatomic, strong) UIView *bottomView;
/** 底部取消*/
@property (nonatomic, strong) UIButton *cancelBtn;
/** 底部确定*/
@property (nonatomic, strong) UIButton *sureBtn;
/** 数据源*/
@property (nonatomic, strong) NSMutableArray *data;
/** 选择器*/
@property (nonatomic, strong) UIPickerView *pickView;
/** 是否为第一次创建*/
@property (nonatomic, assign) BOOL firstCreate;


@property (nonatomic, assign) NSInteger num;

/** 视图标识*/
@property (nonatomic, assign) NSInteger ViewTag;
/** 创建俱乐部的文字选择器*/
@property (nonatomic, strong) id stringItem;



@end

@implementation STL_NumPickerView


- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title ary:(NSArray *)ary{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self sd_addSubviews:@[self.titleLb, self.messageLb, self.bottomView, self.pickView]];
        [self setupFrame];
        _titleLb.text = title;
        _data = [NSMutableArray arrayWithArray:ary];
        [_pickView reloadAllComponents];
        [GOLFNotificationCenter addObserver:self selector:@selector(firstSelect) name:@"firstNumSelect" object:nil];
    }
    return self;
    
}

/** 增加不同行识别的tag用于判断*/
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title ary:(NSArray *)ary tag:(NSInteger)tag{
    self = [super initWithFrame:frame];
    if (self) {
        [self sd_addSubviews:@[self.titleLb, self.messageLb, self.bottomView, self.pickView]];
        [self setupFrame];
        _titleLb.text = title;
        _data = [NSMutableArray arrayWithArray:ary];
        [_pickView reloadAllComponents];
        [GOLFNotificationCenter addObserver:self selector:@selector(firstSelect) name:@"firstNumSelect" object:nil];
        _ViewTag = tag;
    }
    return self;

    
}


- (void)firstSelect{
    if (!_firstCreate) {
        _firstCreate = YES;
        [_pickView selectRow:0 inComponent:0 animated:NO];
        [self pickerView:_pickView didSelectRow:0 inComponent:0];
    }
}

- (void)dealloc{
    [GOLFNotificationCenter removeObserver:self];
}

- (void)setupFrame{
    _titleLb.sd_layout
    .topSpaceToView(self, 20)
    .centerXEqualToView(self)
    .heightIs(18);
    [_titleLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _messageLb.sd_layout
    .topSpaceToView(_titleLb, 12.5)
    .centerXEqualToView(self)
    .heightIs(12);
    [_messageLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _bottomView.sd_layout
    .bottomSpaceToView(self, 50)
    .leftSpaceToView(self, 30)
    .rightSpaceToView(self, 30)
    .heightIs(35);
    [_bottomView setSd_cornerRadiusFromHeightRatio:@0.5];
    
    _sureBtn.sd_layout
    .topSpaceToView(_bottomView, 0)
    .rightSpaceToView(_bottomView, 0)
    .bottomSpaceToView(_bottomView, 0)
    .widthRatioToView(_bottomView, 0.5);
    
    _cancelBtn.sd_layout
    .topSpaceToView(_bottomView, 0)
    .leftSpaceToView(_bottomView, 0)
    .bottomSpaceToView(_bottomView, 0)
    .widthRatioToView(_bottomView, 0.5);
    
    _pickView.sd_layout
    .leftEqualToView(_bottomView)
    .rightEqualToView(_bottomView)
    .topSpaceToView(_messageLb, 20)
    .bottomSpaceToView(_bottomView, 45);
}


#pragma mark ----------------选择器代理

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return _data.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_data[component] count];
}

//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    return _data[component][row];
//}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    ////    [view addSubview:lb];
    //    NSLog(@"%@",view);
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - 90)/_data.count, 30)];
    UILabel *lb = [[UILabel alloc] init];
    lb.textColor = SHENTEXTCOLOR;
    lb.font = FONT(12);
    lb.text = _data[component][row];
    lb.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:lb];
    lb.sd_layout
    .centerYEqualToView(contentView)
    .centerXEqualToView(contentView)
    .autoHeightRatio(0);
    [lb setSingleLineAutoResizeWithMaxWidth:200];
    
    
    return contentView;;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return (SCREEN_WIDTH - 90)/_data.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    UIView *contentView = [pickerView viewForRow:row forComponent:component];
    contentView.backgroundColor = WHITECOLOR;
    UILabel *lb = contentView.subviews.firstObject;
    lb.textColor = GLOBALCOLOR;
    
    UIView *indicatorView = [[UIView  alloc] init];
    indicatorView.backgroundColor = GLOBALCOLOR;
    [contentView addSubview:indicatorView];
    indicatorView.sd_layout
    .topSpaceToView(contentView, 0)
    .leftSpaceToView(contentView,0)
    .bottomSpaceToView(contentView,0)
    .widthIs(3);
    
    
    [self setMessage];
}


- (void)setMessage{
    NSInteger timeIndex = [_pickView selectedRowInComponent:0];
    
    NSInteger time = [_data[0][timeIndex] integerValue];
    _num = time;
    
    if ([_data[0][timeIndex] isKindOfClass:[NSString class]]) {
        _stringItem = _data[0][timeIndex];
    }else{
        // NSInteger time = [_data[0][timeIndex] integerValue];
        _stringItem = _data[0][timeIndex] ;
    }
}

#pragma mark ----------------动作

- (void)sureAction{
    if (self.delegate) {
        [self.delegate sureWithCount:_num];
    }
    if (self.delegate_1) {
        [self.delegate_1 sureWithCount:_num];
    }
    
    if (self.delegate_2) {
        [self.delegate_2 sureWithCount:_stringItem andSelectedTag:_ViewTag];
    }
}

- (void)cancelAction{
    if (self.delegate) {
        [self.delegate cancel];
    }
}



#pragma mark ----------------实例

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = FONT(18);
        _titleLb.textColor = BLACKTEXTCOLOR;
    }
    return _titleLb;
}

- (UILabel *)messageLb{
    if (!_messageLb) {
        _messageLb = [[UILabel alloc] init];
        _messageLb.font = FONT(12);
        _messageLb.textColor = LIGHTTEXTCOLOR;
        _messageLb.text = @"";
    }
    return _messageLb;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        [_bottomView addSubview:self.cancelBtn];
        [_bottomView addSubview:self.sureBtn];
        _bottomView.layer.borderWidth = 0.5;
        _bottomView.layer.borderColor = GRAYCOLOR.CGColor;
    }
    return _bottomView;
    
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc] init];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = FONT(12);
        [_sureBtn setTitleColor:BLACKTEXTCOLOR forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = FONT(12);
        [_cancelBtn setTitleColor:BLACKTEXTCOLOR forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIPickerView *)pickView{
    if (!_pickView) {
        _pickView = [[UIPickerView alloc] init];
        _pickView.delegate = self;
        _pickView.dataSource = self;
        _pickView.backgroundColor = BACKGROUNDCOLOR;
    }
    return _pickView;
}

@end