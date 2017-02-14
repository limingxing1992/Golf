//
//  FirendInviteGroupTableViewCell.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/23.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "FirendInviteGroupTableViewCell.h"

@interface FirendInviteGroupTableViewCell ()

/** 选择按钮*/
@property (nonatomic, strong) UIButton *selectBtn;
/** 标题*/
@property (nonatomic, strong) UILabel *titleLb;
/** 名字。最多显示5个*/
@property (nonatomic, strong) UILabel *nameLb;

@end

@implementation FirendInviteGroupTableViewCell

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
        [self.contentView sd_addSubviews:@[self.selectBtn, self.titleLb, self.nameLb]];
        [self autoLayoutSubViews];
        [GOLFNotificationCenter addObserver:self selector:@selector(allSelect:) name:@"allSelect" object:nil];
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
    
    _titleLb.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(_selectBtn, 5)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    
    _nameLb.sd_layout
    .bottomSpaceToView(self.contentView, 15)
    .leftEqualToView(_titleLb)
    .rightSpaceToView(self.contentView, 5)
    .autoHeightRatio(0);
    
}

#pragma mark ----------------界面刷新

- (void)setModel:(FriendGroupItemModel *)model{
    _model = model;
    NSMutableArray *imgs = [[NSMutableArray alloc] init];//图片路径数组
    NSMutableString *name = [[NSMutableString alloc] init];//名字数组
    NSArray *groupList = model.groupMemberList;
    for (FriendUserModel *itemModel in groupList) {
        if (itemModel.headUrl.length) {
            [imgs addObject:itemModel.headUrl];
        }else{
            [imgs addObject:@"1"];
        }
        if (itemModel.nickName.length) {
            [name appendFormat:@"%@，",itemModel.nickName];
        }else{
            [name appendFormat:@"%@，", itemModel.userName];
        }
    }
    
    NSString *title = [NSString stringWithFormat:@"%@（%ld）",model.groupName,model.groupCount];
    if (name) {
        _nameLb.text = name;
    }
    if (title) {
        _titleLb.text = title;
    }
    
    _selectBtn.selected = model.isSelect;
}

#pragma mark ----------------选择
/** 单点选中*/
- (void)selectAction:(UIButton *)btn{
    btn.selected = ! btn.isSelected;
    _model.isSelect = btn.selected;
    [GOLFNotificationCenter postNotificationName:@"changeSelectInfo" object:nil];
    
}

/** 接受通知*/
- (void)allSelect:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    _selectBtn.selected = [userInfo[@"allSelect"] boolValue];
}

- (void)dealloc{
    [GOLFNotificationCenter removeObserver:self];
}

#pragma mark ----------------实例


- (UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [[UIButton alloc] init];
        [_selectBtn setBackgroundImage:IMAGE(@"classify71") forState:UIControlStateNormal];
        [_selectBtn setBackgroundImage:IMAGE(@"classify72") forState:UIControlStateSelected];
        [_selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}


- (UILabel *)nameLb{
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] init];
        _nameLb.font = FONT(14);
        _nameLb.textColor = LIGHTTEXTCOLOR;
        _nameLb.text = @"呆呆， 元元，沟沟";
    }
    return _nameLb;
}


- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = FONT(14);
        _titleLb.textColor = BLACKTEXTCOLOR;
        _titleLb.text = @"家人（4）";
    }
    return _titleLb;
}

@end
