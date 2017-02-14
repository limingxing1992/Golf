//
//  OrderCommentViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/30.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "OrderCommentViewController.h"

#import "HX_AddPhotoView.h"//四个头文件导入使用第三方
#import "MBProgressHUD.h"

#define CommentPlaceholder @"  写下对球场的使用感觉吧，我们会根据您的建议改进的。"

@interface OrderCommentViewController ()
<
    UITextViewDelegate,
    HX_AddPhotoViewDelegate

>
{
    HX_AddPhotoView *addPhotoView;
}

@property (nonatomic, strong) UIView *topBackView;

/** 球场图标*/
@property (nonatomic, strong) UIImageView *headIv;

/** 球场名称*/
@property (nonatomic, strong) UILabel *titleLb;

/** 打分*/
@property (nonatomic, strong) CommentStarView *starView;

/** 评价内容*/
@property (nonatomic, strong) UITextView *textView;

/** 底部提交评价视图*/
@property (nonatomic, strong) UIView *bottomView;


/** 提交那妞*/
@property (nonatomic, strong) UIButton *sumbitBtn;




@end

@implementation OrderCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"评价";
    [self.contentView sd_addSubviews:@[self.topBackView, self.textView]];
    [self.view addSubview:self.bottomView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _topBackView.sd_layout
    .topSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0);
    
    _textView.sd_layout
    .topSpaceToView(_topBackView, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(200);
    
    [self.contentView setupAutoHeightWithBottomView:addPhotoView bottomMargin:70];

}


#pragma mark ----------------界面逻辑

/** 提交*/
- (void)sumbitAction{
    if (_textView.text.length < 5 || [_textView.text isEqualToString:CommentPlaceholder]) {
        [SVProgressHUD showErrorWithStatus:@"评价不能少于5个字"];
        return;
    }
    [SVProgressHUD show];
    
    GOLFWeakObj(self);
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:@{@"detail":_textView.text,
                                                                                  @"score":[NSNumber numberWithInteger:_starView.lastIndex]}];
    if (_orderNo) {
        //@"orderNo":_model.orderInfo.orderNo,
        [dict setValue:_orderNo forKey:@"orderNo"];
    }else{
        [dict setValue:_model.orderInfo.orderNo forKey:@"orderNo"];
    }
    
    
    [ShareBusinessManager.userManager postMyOrderJugeWithParameters:dict
                                                            success:^(id responObject) {
                                                                [SVProgressHUD showSuccessWithStatus:@"评价成功"];
                                                                [GOLFNotificationCenter postNotificationName:OrderListUpdate object:nil];
                                                                [GOLFNotificationCenter postNotificationName:OrderDetailUpdate object:nil];
                                                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                                    [weakself.navigationController popViewControllerAnimated:YES];
                                                                });
                                                            } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                [SVProgressHUD showErrorWithStatus:errorMsg];
                                                            }];
}


#pragma mark ----------------textview代理

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:CommentPlaceholder]) {
        textView.textColor = BLACKTEXTCOLOR;
        textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (!textView.text.length) {
        textView.text = CommentPlaceholder;
        textView.textColor = LIGHTTEXTCOLOR;
    }
}


#pragma mark ----------------实例

- (UIView *)topBackView{
    if (!_topBackView) {
        _topBackView = [[UIView alloc] init];
        _topBackView.backgroundColor = WHITECOLOR;
        [_topBackView sd_addSubviews:@[self.headIv, self.titleLb, self.starView]];
        _headIv.sd_layout
        .centerXEqualToView(self.topBackView)
        .topSpaceToView(self.topBackView, 35)
        .heightIs(40)
        .widthEqualToHeight();
        
        _titleLb.sd_layout
        .centerXEqualToView(self.topBackView)
        .topSpaceToView(_headIv, 20)
        .autoHeightRatio(0);
        [_titleLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
        
        _starView.sd_layout
        .topSpaceToView(_titleLb, 13)
        .centerXEqualToView(self.topBackView)
        .heightIs(50);
        
        [_topBackView setupAutoHeightWithBottomView:_starView bottomMargin:20];
    }
    return _topBackView;
}

- (UIImageView *)headIv{
    if (!_headIv) {
        _headIv = [[UIImageView alloc] init];
        [_headIv sd_setImageWithURL:FULLIMGURL(_model.serviceInfo.logoUrl) placeholderImage:Placeholder_middle];
    }
    return _headIv;
}

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = FONT(14);
        _titleLb.textColor  = BLACKTEXTCOLOR;
        _titleLb.text = @"高尔夫俱乐部";
    }
    return _titleLb;
}

- (CommentStarView *)starView{
    if (!_starView) {
        _starView = [[CommentStarView alloc] initWithNum:5 normalImage:IMAGE(@"classify109") selctImage:IMAGE(@"classify108") spacing:25 size:CGSizeMake(25, 24)];
    }
    return _starView;
}

- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.layer.borderColor = GRAYCOLOR.CGColor;
        _textView.layer.borderWidth = 0.5;
        _textView.delegate = self;
        _textView.font = FONT(14);
        _textView.text = CommentPlaceholder;
        _textView.textColor = LIGHTTEXTCOLOR;
    }
    return _textView;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
        _bottomView.backgroundColor = WHITECOLOR;
        [_bottomView addSubview:self.sumbitBtn];
        
        
        _sumbitBtn.sd_layout
        .centerYEqualToView(_bottomView)
        .rightSpaceToView(_bottomView, 15)
        .leftSpaceToView(_bottomView, 15)
        .heightIs(35);
        [_sumbitBtn setSd_cornerRadius:@3];
    }
    return _bottomView;
}

- (UIButton *)sumbitBtn{
    if (!_sumbitBtn) {
        _sumbitBtn = [[UIButton alloc] init];
        _sumbitBtn.backgroundColor = GLOBALCOLOR;
        _sumbitBtn.titleLabel.font = FONT(16);
        [_sumbitBtn setTitle:@"提交评价" forState:UIControlStateNormal];
        [_sumbitBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_sumbitBtn addTarget:self action:@selector(sumbitAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sumbitBtn;
}
@end
