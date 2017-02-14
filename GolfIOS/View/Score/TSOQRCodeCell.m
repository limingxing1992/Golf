//
//  TSOQRCodeCell.m
//  GolfIOS
//
//  Created by yangbin on 16/12/26.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TSOQRCodeCell.h"
#import "YB_QRCodeTool.h"
@interface TSOQRCodeCell ()

/**二维码视图*/
@property (nonatomic, strong) UIImageView *qrCodeView;
/**提示Lable*/
@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation TSOQRCodeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.qrCodeView];
    [self.contentView addSubview:self.tipLabel];

    [self refresh];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    // .centerYIs(self.contentView.mj_h * 0.5 - (10 *KHeight_Scale))
    self.qrCodeView.sd_layout
    .centerXEqualToView(self.contentView)
    .topSpaceToView(self.contentView,10 * KHeight_Scale)
    .heightIs(self.contentView.mj_h * 0.8* KHeight_Scale)
    .widthIs(self.contentView.mj_h * 0.8* KHeight_Scale);
    
    self.tipLabel.sd_layout
    .centerXEqualToView(self.contentView)
    .topSpaceToView(self.qrCodeView , 8 *KHeight_Scale)
    .autoHeightRatio(0);
    [self.tipLabel setSingleLineAutoResizeWithMaxWidth:150];

}

- (void)refresh{
    if (IsLogin) {
        self.qrCodeView.image = [YB_QRCodeTool createQRCodeWithString:[UserModel sharedUserModel].ID];
    }
}

- (UIImageView *)qrCodeView{
    if (_qrCodeView == nil) {
        _qrCodeView = [[UIImageView alloc] init];
        _qrCodeView.image = Placeholder_middle;
    }
    return _qrCodeView;
}

- (UILabel *)tipLabel{
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.text = @"扫二维码加入我的组队";
        _tipLabel.textColor = LIGHTTEXTCOLOR;
        _tipLabel.font = FONT(12);
    }
    return _tipLabel;
}
@end
