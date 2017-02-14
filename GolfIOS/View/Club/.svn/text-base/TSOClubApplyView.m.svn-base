//
//  TSOClubApplyView.m
//  GolfIOS
//
//  Created by yangbin on 16/11/10.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOClubApplyView.h"
#import "UIImage+Image.h"

@interface TSOClubApplyView ()<UITextFieldDelegate>
/**title*/
@property (nonatomic, strong) UILabel *titleLb;
/**关闭按钮*/
@property (nonatomic, strong) UIButton *closeBtn;
/**输入框*/
@property (nonatomic, strong) UITextField *reasonTF;
/**取消按钮*/
@property (nonatomic, strong) UIButton *cancelBtn;
/**提交申请*/
@property (nonatomic, strong) UIButton *applyBtn;

@end

@implementation TSOClubApplyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    self.backgroundColor = WHITECOLOR;
    self.layer.cornerRadius = 6;
    [self addSubview:self.titleLb];
    [self addSubview:self.closeBtn];
    [self addSubview:self.reasonTF];
    [self addSubview:self.cancelBtn];
    [self addSubview:self.applyBtn];
    
    self.titleLb.sd_layout
    .topSpaceToView(self, 15)
    .leftSpaceToView(self, 15)
    .autoHeightRatio(0);
    [self.titleLb setSingleLineAutoResizeWithMaxWidth:100];
    
    self.closeBtn.sd_layout
    .topSpaceToView(self, 15)
    .rightSpaceToView(self, 15)
    .widthIs(18)
    .heightIs(18);
    
    self.reasonTF.sd_layout
    .leftSpaceToView(self, 15)
    .topSpaceToView(self, 75)
    .heightIs(40)
    .rightSpaceToView(self, 15);
    self.reasonTF.sd_cornerRadius = @4;
    
    self.cancelBtn.sd_layout
    .leftSpaceToView(self, 15)
    .bottomSpaceToView(self, 20)
    .heightIs(40)
    .widthRatioToView(self.reasonTF, 0.4);
    self.cancelBtn.sd_cornerRadius = @4;
    
    self.applyBtn.sd_layout
    .rightSpaceToView(self, 15)
    .bottomSpaceToView(self, 20)
    .heightIs(40)
    .widthRatioToView(self.reasonTF, 0.4);
    self.applyBtn.sd_cornerRadius = @4;
    
    [self.closeBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.applyBtn addTarget:self action:@selector(applyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.reasonTF becomeFirstResponder];
    });
    
}

- (void)cancelBtnClick{
    if ([self.delegate respondsToSelector:@selector(clubApplyViewCancelButtonDidClick)]) {
        [self.delegate clubApplyViewCancelButtonDidClick];
    }
}

- (void)applyBtnClick{
    if ([self.delegate respondsToSelector:@selector(clubApplyView:applyButtonDidClick:)]) {
        [self.delegate clubApplyView:self applyButtonDidClick:self.reasonTF.text];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    return YES;
}


- (UILabel *)titleLb{
    if (_titleLb == nil) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = FONT(16);
        _titleLb.textColor = SHENTEXTCOLOR;
        _titleLb.text = @"申请理由";
    }
    return _titleLb;
}

- (UIButton *)closeBtn{
    if (_closeBtn == nil) {
        _closeBtn = [[UIButton alloc] init];
        [_closeBtn setBackgroundImage:IMAGE(@"classify88") forState:UIControlStateNormal];
    }
    return _closeBtn;
}

- (UITextField *)reasonTF{
    if (_reasonTF == nil) {
        _reasonTF = [[UITextField alloc] init];
        _reasonTF.backgroundColor = BACKGROUNDCOLOR;
        _reasonTF.delegate = self;
    }
    return _reasonTF;
}

- (UIButton *)cancelBtn{
    if (_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitleColor:LIGHTTEXTCOLOR forState:UIControlStateNormal];
        _cancelBtn.layer.borderWidth = 1;
        _cancelBtn.layer.borderColor = BACKGROUNDCOLOR.CGColor;
        [_cancelBtn setBackgroundColor:WHITECOLOR];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    }
    return _cancelBtn;
}

- (UIButton *)applyBtn{
    if (_applyBtn == nil) {
        _applyBtn = [[UIButton alloc] init];
        [_applyBtn setTitle:@"提交申请" forState:UIControlStateNormal];
        [_applyBtn setBackgroundImage:[UIImage imageWithColor:GLOBALCOLOR] forState:UIControlStateNormal];
        
    }
    return _applyBtn;
}

@end
