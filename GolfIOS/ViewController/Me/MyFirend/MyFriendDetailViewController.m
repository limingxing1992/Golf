//
//  MyFriendDetailViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/21.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyFriendDetailViewController.h"

@interface MyFriendDetailViewController ()

/** 头像资料*/
@property (nonatomic, strong) UIView *headView;
/** 头像*/
@property (nonatomic, strong) UIImageView *headIv;
/** 名字*/
@property (nonatomic, strong) UILabel *nameLb;
/** 等级图*/
@property (nonatomic, strong) UIImageView *levelIv;


///** 备注*/
//@property (nonatomic, strong) UIView *noticeView;
///** 标题*/
//@property (nonatomic, strong) UILabel *noticeLb;
///** 图标*/
//@property (nonatomic, strong) UIImageView *indicatorIv;


/** 资料视图*/
@property (nonatomic, strong) UIView *infoView;
/** 杆数*/
@property (nonatomic, strong) UILabel *addressLb;
/** 横线*/
@property (nonatomic, strong) UIView *lineView;
/** 差点*/
@property (nonatomic, strong) UILabel *pointsLb;
/** 横线*/
@property (nonatomic, strong) UIView *lineview_1;

/** 手机*/
@property (nonatomic, strong) UILabel *phoneLb;

/** 删除好友*/
@property (nonatomic, strong) UIButton *addBtn;
/** 拒绝按钮*/
@property (nonatomic, strong) UIButton *refuseBtn;

/** 同意按钮*/
@property (nonatomic, strong) UIButton *sureBtn;





@end

@implementation MyFriendDetailViewController

- (instancetype)initWithModel:(FriendUserModel *)model isFriend:(BOOL)ret{
    self = [super init];
    if (self) {
        _model = model;
        _isFriend = ret;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"个人资料";
    [self.contentView addSubview:self.headView];
    [self.contentView addSubview:self.infoView];
    
    if (_isFriend) {
        [self.contentView addSubview:self.addBtn];
    }else{
        [self.contentView addSubview:self.refuseBtn];
        [self.contentView addSubview:self.sureBtn];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _headView.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(80);
    [self sdAutoLayoutHeadSubViews];
    
    
    _infoView.sd_layout
    .topSpaceToView(_headView, 10)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0);
    [self sdAutoLayoutInfoSubViews];
    
    
    if (_isFriend) {
        _addBtn.sd_layout
        .topSpaceToView(_infoView, 30)
        .leftSpaceToView(self.contentView, 15)
        .rightSpaceToView(self.contentView, 15)
        .heightIs(45);
        [_addBtn setSd_cornerRadius:@5];
        
        [self.contentView setupAutoContentSizeWithBottomView:_addBtn bottomMargin:20];
    }else{
        
        _refuseBtn.sd_layout
        .topSpaceToView(_infoView, 30)
        .leftSpaceToView(self.contentView, 15)
        .heightIs(45)
        .widthIs((SCREEN_WIDTH - 45) / 2);
        [_refuseBtn setSd_cornerRadius:@3];
        
        
        _sureBtn.sd_layout
        .topEqualToView(_refuseBtn)
        .leftSpaceToView(_refuseBtn, 15)
        .heightIs(45)
        .widthRatioToView(_refuseBtn, 1);
        [_sureBtn setSd_cornerRadius:@3];
        
        [self.contentView setupAutoContentSizeWithBottomView:_refuseBtn bottomMargin:20];
    }
    

}
/** 布局头像视图*/
- (void)sdAutoLayoutHeadSubViews{
    _headIv.sd_layout
    .centerYEqualToView(_headView)
    .leftSpaceToView(_headView, 15)
    .heightIs(60)
    .widthEqualToHeight();
    [_headIv setSd_cornerRadiusFromWidthRatio:@0.5];
    
    _nameLb.sd_layout
    .centerYIs(25)
    .leftSpaceToView(_headIv, 7)
    .rightSpaceToView(_headView, 15)
    .autoHeightRatio(0);
    
    _levelIv.sd_layout
    .centerYIs(55)
    .leftEqualToView(_nameLb)
    .widthIs(37.5)
    .heightIs(10.5);
    
}

/** 布局信息*/
- (void)sdAutoLayoutInfoSubViews{
    
    _addressLb.sd_layout
    .centerYIs(22.5)
    .leftSpaceToView(_infoView, 15)
    .rightSpaceToView(_infoView, 15)
    .autoHeightRatio(0);
    
    _lineView.sd_layout
    .topSpaceToView(_infoView, 45)
    .leftEqualToView(_addressLb)
    .rightSpaceToView(_infoView, 0)
    .heightIs(0.5);
    
    _pointsLb.sd_layout
    .centerYIs(67.5)
    .leftEqualToView(_lineView)
    .rightEqualToView(_addressLb)
    .heightIs(14);
    
    
    _lineview_1.sd_layout
    .topSpaceToView(_lineView, 45)
    .leftEqualToView(_lineView)
    .rightEqualToView(_lineView)
    .heightIs(0.5);
    
    _phoneLb.sd_layout
    .centerYIs(112.5)
    .leftEqualToView(_lineView)
    .rightEqualToView(_addressLb)
    .autoHeightRatio(0);
    
    [_infoView setupAutoHeightWithBottomView:_lineview_1 bottomMargin:45];
}

#pragma mark ----------------界面逻辑
/** 删除好友操作*/
- (void)addFriendAction{
    GOLFWeakObj(self);
    //处理删除请求
    [SVProgressHUD showWithStatus:@"删除中"];
    [ShareBusinessManager.userManager postDeleteMyFriendWithParameters:@{@"friendIds":_model.userId}
                                                               success:^(id responObject) {
                                                                   [SVProgressHUD showSuccessWithStatus:responObject];
                                                                   [GOLFNotificationCenter postNotificationName:@"updateFriendList" object:nil];
                                                                   [weakself.navigationController popViewControllerAnimated:YES];
                                                               }
                                                               failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                   [SVProgressHUD showErrorWithStatus:errorMsg];
                                                               }];

}

/** 拒绝添加*/
- (void)refuseAction{
    GOLFWeakObj(self);
    [ShareBusinessManager.userManager postMyFriendAllowAddWithParameters:@{@"friendId":_model.userId,
                                                                           @"handleType":@0}
                                                                 success:^(id responObject) {
                                                                     [SVProgressHUD showSuccessWithStatus:@"同意成功"];
                                                                     [GOLFNotificationCenter postNotificationName:@"updateFriendList" object:nil];
                                                                     [weakself.navigationController popViewControllerAnimated:YES];
                                                                 }
                                                                 failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                     [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                 }];
}

/** 同意添加*/

- (void)sureAction{
    GOLFWeakObj(self);
    [ShareBusinessManager.userManager postMyFriendAllowAddWithParameters:@{@"friendId":_model.userId,
                                                                           @"handleType":@1}
                                                                 success:^(id responObject) {
                                                                     [SVProgressHUD showSuccessWithStatus:@"同意成功"];
                                                                     [GOLFNotificationCenter postNotificationName:@"updateFriendList" object:nil];
                                                                     [weakself.navigationController popViewControllerAnimated:YES];
                                                                 }
                                                                 failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                     [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                 }];
}

#pragma mark ----------------实例

- (UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] init];
        _headView.backgroundColor = WHITECOLOR;
        [_headView sd_addSubviews:@[self.headIv, self.nameLb, self.levelIv]];
    }
    return _headView;
}

- (UIImageView *)headIv{
    if (!_headIv) {
        _headIv = [[UIImageView alloc] init];
        [_headIv sd_setImageWithURL:FULLIMGURL(_model.headUrl) placeholderImage:Placeholder_middle];
    }
    return _headIv;
}

- (UILabel *)nameLb{
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] init];
        _nameLb.font = FONT(14);
        _nameLb.textColor = BLACKTEXTCOLOR;
        if (_model.nickName) {
            _nameLb.text = _model.nickName;
        }else{
            _nameLb.text = _model.userName;
        }
    }
    return _nameLb;
}

- (UIImageView *)levelIv{
    if (!_levelIv) {
        _levelIv  = [[UIImageView alloc] init];
        _levelIv.image  = _model.levelImg;
    }
    return _levelIv;
}


- (UIView *)infoView{
    if (!_infoView) {
        _infoView = [[UIView alloc] init];
        _infoView.backgroundColor = WHITECOLOR;
        [_infoView addSubview:self.addressLb];
        [_infoView addSubview:self.lineView];
        [_infoView addSubview:self.pointsLb];
        [_infoView addSubview:self.lineview_1];
        [_infoView addSubview:self.phoneLb];
    }
    return _infoView;
}

- (UILabel *)addressLb{
    if (!_addressLb) {
        _addressLb = [[UILabel alloc] init];
        _addressLb.font= FONT(14);
        _addressLb.textColor = BLACKTEXTCOLOR;
        _addressLb.text = @"杆数：5";
    }
    return _addressLb;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = GRAYCOLOR;
    }
    return _lineView;
}

- (UILabel *)pointsLb{
    if (!_pointsLb) {
        _pointsLb = [[UILabel alloc] init];
        _pointsLb.font = FONT(14);
        _pointsLb.textColor = BLACKTEXTCOLOR;
        _pointsLb.text = @"差点：73";
    }
    return _pointsLb;
}

- (UIView *)lineview_1{
    if (!_lineview_1) {
        _lineview_1 = [[UIView alloc] init];
        _lineview_1.backgroundColor =GRAYCOLOR;
    }
    return _lineview_1;
}

- (UILabel *)phoneLb{
    if (!_phoneLb) {
        _phoneLb = [[UILabel alloc] init];
        _phoneLb.font = FONT(14);
        _phoneLb.textColor = BLACKTEXTCOLOR;
        if (_isFriend) {
            _phoneLb.text = [NSString stringWithFormat:@"手机号：%@",_model.userName];
        }else{
            NSMutableString *str = [NSMutableString stringWithString:_model.userName];
            [str replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            _phoneLb.text = [NSString stringWithFormat:@"手机号：%@",str];
        }
    }
    return _phoneLb;
}

- (UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] init];
        _addBtn.backgroundColor = GLOBALCOLOR;
        _addBtn.titleLabel.font = FONT(14);
        [_addBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_addBtn setTitle:@"删除好友" forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addFriendAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

- (UIButton *)refuseBtn{
    if (!_refuseBtn) {
        _refuseBtn = [[UIButton alloc] init];
        [_refuseBtn setBackgroundColor:WHITECOLOR];
        _refuseBtn.titleLabel.font = FONT(14);
        [_refuseBtn setTitle:@"拒绝" forState:UIControlStateNormal];
        [_refuseBtn setTitleColor:BLACKTEXTCOLOR forState:UIControlStateNormal];
        [_refuseBtn addTarget:self action:@selector(refuseAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refuseBtn;
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc] init];
        [_sureBtn setBackgroundColor:GLOBALCOLOR];
        _sureBtn.titleLabel.font = FONT(14);
        [_sureBtn setTitle:@"同意" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

@end
