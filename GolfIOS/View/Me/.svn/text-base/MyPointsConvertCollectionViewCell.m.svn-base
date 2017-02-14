//
//  MyPointsConvertCollectionViewCell.m
//  GolfIOS
//
//  Created by 李明星 on 2017/1/6.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import "MyPointsConvertCollectionViewCell.h"

@interface MyPointsConvertCollectionViewCell()

@property (nonatomic, strong) UILabel *titleLb;


@property (nonatomic, strong) UIImageView *headIv;



@end

@implementation MyPointsConvertCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = WHITECOLOR;
        [self.contentView sd_addSubviews:@[self.titleLb, self.headIv]];
        
        _headIv.sd_layout
        .topSpaceToView(self.contentView, 0)
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .heightEqualToWidth();
        [_headIv setSd_cornerRadiusFromWidthRatio:@0.5];
        
        _titleLb.sd_layout
        .bottomSpaceToView(self.contentView, 0)
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .heightIs(14);
        
    }
    return self;
}


- (void)setModel:(MyPointsModel *)model{
    _model = model;
    _titleLb.text = model.serviceName;
    [_headIv sd_setImageWithURL:FULLIMGURL(model.logoUrl) placeholderImage:Placeholder_middle];
}


#pragma mark ----------------实例

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = FONT(14);
        _titleLb.textColor = BLACKTEXTCOLOR;
    }
    return _titleLb;
}

- (UIImageView *)headIv{
    if (!_headIv) {
        _headIv = [[UIImageView alloc] init];
    }
    return _headIv;
}

@end
