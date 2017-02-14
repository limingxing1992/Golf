//
//  TSOScoreAddFriendCell.m
//  GolfIOS
//
//  Created by yangbin on 16/11/11.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOScoreAddFriendCell.h"
#import "UIImage+Image.h"

@interface TSOScoreAddFriendCell ()<UITextFieldDelegate>

/**icon*/
@property (nonatomic, strong) UIButton *icon;
/**textField*/
@property (nonatomic, strong) UITextField *nameTF;

@end

@implementation TSOScoreAddFriendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.nameTF];
    self.icon.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .centerYEqualToView(self.contentView)
    .heightIs(30)
    .widthIs(30);
    
    self.nameTF.sd_layout
    .leftSpaceToView(self.icon, 15)
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(30);
    
    
}
#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    return YES;
}



- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(scoreAddFriendCell:endEditing:)]) {
        [self.delegate scoreAddFriendCell:self endEditing:textField.text];
    }
    return YES;
}

#pragma mark - Setter&Getter
- (UIButton *)icon{
    if (_icon == nil) {
        _icon = [[UIButton alloc] init];
        [_icon setBackgroundImage:[UIImage imageWithColor:[UIColor orangeColor]] forState:UIControlStateNormal];
        
        [_icon setBackgroundImage:[UIImage imageWithColor:[UIColor purpleColor]] forState:UIControlStateSelected];
        
    }
    return _icon;
}

- (UITextField *)nameTF{
    if (_nameTF == nil) {
        _nameTF = [[UITextField alloc] init];
        _nameTF.font = FONT(14);
        _nameTF.placeholder = @"球友名字";
        _nameTF.delegate = self;
        _nameTF.textColor = SHENTEXTCOLOR;
        _nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _nameTF;
}

@end
