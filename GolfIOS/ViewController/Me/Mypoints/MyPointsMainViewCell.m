//
//  MyPointsMainViewCell.m
//  GolfIOS
//
//  Created by wyao on 16/11/22.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyPointsMainViewCell.h"


@interface MyPointsMainViewCell ()

@end

@implementation MyPointsMainViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setUI];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self ) {
        [self setUI];
    }
    return self;
}

#pragma mark - 初始化UI
-(void)setUI{
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.btn];
    
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(30);
        make.left.equalTo(self.contentView).offset(15);
        make.width.height.offset(67);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView).offset(9);
        make.left.equalTo(self.iconView.mas_right).offset(25);
    }];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(12);
        make.left.equalTo(self.nameLabel);
        make.width.offset(87);
        make.height.offset(27);
    }];
    
}
#pragma mark - 懒加载 
- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = IMAGE(@"classify19");
    }
    return _iconView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"预定球场获取更多积分";
        _nameLabel.font = FONT(16);
        _nameLabel.textColor = BLACKTEXTCOLOR;
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}

-(UIButton *)btn{
    if (!_btn) {
        _btn = [[UIButton alloc] init];
        [_btn setTitle:@"去充值" forState:UIControlStateNormal];
        [_btn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_btn setTintColor:GLOBALCOLOR ];
        _btn.backgroundColor = [UIColor colorWithHex:0x2aa344];
        //[_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btn.titleLabel.font = FONT(16);
    }
    return _btn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
