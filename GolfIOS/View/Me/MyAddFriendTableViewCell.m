//
//  MyAddFriendTableViewCell.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/5.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyAddFriendTableViewCell.h"

@interface MyAddFriendTableViewCell ()

/** 头像*/
@property (nonatomic, strong) UIImageView *headIv;
/** 昵称*/
@property (nonatomic, strong) UILabel *nameLb;

/** 底部线条*/
@property (nonatomic, strong) UIView *lineView;

/** 按钮*/
@property (nonatomic, strong) UIButton *addBtn;

@end

@implementation MyAddFriendTableViewCell

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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = WHITECOLOR;
        [self.contentView addSubview:self.nameLb];
        [self.contentView addSubview:self.headIv];
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.addBtn];
        
        self.headIv.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 15)
        .heightIs(37.5)
        .widthEqualToHeight();
        [self.headIv setSd_cornerRadiusFromWidthRatio:@0.5];
        
        self.lineView.sd_layout
        .bottomSpaceToView(self.contentView, 0)
        .leftEqualToView(self.headIv)
        .rightSpaceToView(self.contentView, 0)
        .heightIs(0.5);
        
        self.addBtn.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(self.contentView, 15)
        .heightIs(22)
        .widthIs(50);
        [self.addBtn setSd_cornerRadiusFromHeightRatio:@0.5];
        
        self.nameLb.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.headIv, 7)
        .rightSpaceToView(self.contentView, 100)
        .heightIs(12);
    }
    return self;
}


#pragma mark ----------------添加好友

- (void)addFriendAction{
    if (_block) {
        _block(self.model);
    }
}


#pragma mark ----------------数据


- (void)setModel:(NSDictionary *)model{
    _model = model;
    if ([model[@"isMyFriend"] isEqualToNumber:@1]) {
        //是我的好友
        _addBtn.layer.borderWidth = 0;
        _addBtn.enabled = NO;
        
        if ([model[@"nickName"] length]) {
            self.nameLb.text = model[@"nickName"];
        }else{
            self.nameLb.text = model[@"name"];
        }
        
        [self.headIv sd_setImageWithURL:FULLIMGURL(model[@"headUrl"]) placeholderImage:Placeholder_middle];
    }else{
        //不是好友
        self.nameLb.text = model[@"name"];
    }
}

#pragma mark ----------------实例化

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
        _nameLb.font = FONT(12);
        _nameLb.text = @"---";
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

- (UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] init];
        _addBtn.titleLabel.font = FONT(12);
        [_addBtn setBackgroundColor:WHITECOLOR];
        _addBtn.layer.borderColor = GLOBALCOLOR.CGColor;
        _addBtn.layer.borderWidth = 0.5;
        [_addBtn setTitle:@"添加" forState:UIControlStateNormal];
        [_addBtn setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
        [_addBtn setTitleColor:LIGHTTEXTCOLOR forState:UIControlStateDisabled];
        [_addBtn setTitle:@"已添加" forState:UIControlStateDisabled];
        [_addBtn addTarget:self action:@selector(addFriendAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
@end
