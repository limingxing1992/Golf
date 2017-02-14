//
//  MyAddGroupFriendTableViewCell.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/22.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyAddGroupFriendTableViewCell.h"

@interface MyAddGroupFriendTableViewCell ()

/** 选择按钮*/
@property (nonatomic, strong) UIButton *selectBtn;

/** 头像*/
@property (nonatomic, strong) UIImageView *headIv;

/** 姓名*/

@property (nonatomic, strong) UILabel *nameLb;

/** 底部线条*/
@property (nonatomic, strong) UIView *lineView;






@end

@implementation MyAddGroupFriendTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = WHITECOLOR;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView sd_addSubviews:@[self.selectBtn, self.headIv, self.nameLb, self.lineView]];
        [self autoLayoutSubViews];
    }
    return self;
}

/** 自动布局*/
- (void)autoLayoutSubViews{
    _selectBtn.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.contentView, 15)
    .heightIs(20)
    .widthEqualToHeight();
    
    _headIv.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(_selectBtn, 5)
    .heightIs(40)
    .widthEqualToHeight();
    
    _nameLb.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(_headIv, 5)
    .rightSpaceToView(self.contentView ,15)
    .autoHeightRatio(0);
    
    _lineView.sd_layout
    .bottomSpaceToView(self.contentView, 0)
    .leftEqualToView(_headIv)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(0.5);
}

#pragma mark ----------------选择和取消
/** 更新数据*/
- (void)setModel:(FriendUserModel *)model{
    _model = model;
    if ([model.nickName length]) {
        _nameLb.text = model.nickName;
    }else{
        _nameLb.text = model.userName;
    }
    
    [_headIv sd_setImageWithURL:FULLIMGURL(model.headUrl) placeholderImage:Placeholder_middle];
    
    if (model.isGroupItem) {
        _selectBtn.enabled = NO;
    }
    
    if (model.isSelected) {
        _selectBtn.enabled = YES;
        _selectBtn.selected = YES;
    }
}

/** 选择好友*/
- (void)selectAction:(UIButton *)btn{
    
    btn.selected = ! btn.isSelected;
    
    _model.isSelected = btn.selected;
    [GOLFNotificationCenter postNotificationName:@"selectFriend" object:nil userInfo:@{@"isSelect":[NSNumber numberWithBool:btn.isSelected],
                                                                                           @"model":_model}];
}


#pragma mark ----------------实例

- (UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [[UIButton alloc] init];
        [_selectBtn setBackgroundImage:IMAGE(@"classify71") forState:UIControlStateNormal];
        [_selectBtn setBackgroundImage:IMAGE(@"classify72") forState:UIControlStateSelected];
        [_selectBtn setBackgroundImage:IMAGE(@"classify202") forState:UIControlStateDisabled];
        [_selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

- (UIImageView *)headIv{
    if (!_headIv) {
        _headIv = [[UIImageView alloc] init];
        _headIv.image = Placeholder_middle;
    }
    return _headIv;
}

- (UILabel *)nameLb{
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] init];
        _nameLb.font = FONT(14);
        _nameLb.textColor = BLACKTEXTCOLOR;
        _nameLb.text = @"奥迪";
    }
    return _nameLb;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = GRAYCOLOR;
    }
    return _lineView;
}

@end
