//
//  TSOCommentInputView.m
//  GolfIOS
//
//  Created by yangbin on 16/12/16.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TSOCommentInputView.h"
#import "YB_UITextField.h"

@interface TSOCommentInputView ()<UITextFieldDelegate>


/**回复按钮*/
@property (nonatomic, strong) UIButton *addCommentBtn;

@end

@implementation TSOCommentInputView

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.backgroundColor = WHITECOLOR;
    [self addSubview:self.inputTF];
    [self addSubview:self.addCommentBtn];
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification{
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT - keyBoardFrame.size.height - 50, SCREEN_WIDTH , 50);
    }];
}

-(void)keyboardWillBeHidden:(NSNotification*)aNotification{
    _inputTF.placeholder = @"写评论";
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50);
    }];
    
}
//MARK: - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(commentInputViewShouldReturn:)]) {
        BOOL shouldReturn = [self.delegate commentInputViewShouldReturn:self];
        if (shouldReturn) {
            textField.text = nil;
        }
        return shouldReturn;
    }else{
        textField.text = nil;
        return YES;
    }
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(commentInputViewBeginEditing)]) {
        [self.delegate commentInputViewBeginEditing];
    }
}

- (void)addCommentBtnDidClick{
    if ([self.delegate respondsToSelector:@selector(commentInputViewCommentButtonDidClick:)]) {
        [self.delegate commentInputViewCommentButtonDidClick:self];
    }
}


- (YB_UITextField *)inputTF{
    if (_inputTF == nil) {
        _inputTF = [[YB_UITextField alloc] initWithFrame:CGRectMake(15, 6, SCREEN_WIDTH  -  73, 38)];
        _inputTF.layer.borderColor = GLOBALCOLOR.CGColor;
        _inputTF.font = FONT(14);
        _inputTF.layer.borderWidth = 0.5;
        _inputTF.layer.cornerRadius = 4;
        _inputTF.placeholder = @"写评论";
        _inputTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _inputTF.delegate = self;
        _inputTF.returnKeyType = UIReturnKeyDone;
    }
    return _inputTF;
}



- (UIButton *)addCommentBtn{
    if (_addCommentBtn == nil) {
        _addCommentBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH  - 65, 6, 70, 40)];
        [_addCommentBtn setImage:IMAGE(@"classify216") forState:UIControlStateNormal];
        [_addCommentBtn setTitleColor:LIGHTTEXTCOLOR forState:UIControlStateNormal];
        [_addCommentBtn addTarget:self action:@selector(addCommentBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addCommentBtn;
}

- (NSString *)text{
    return self.inputTF.text;
}

@end
