//
//  TSOHomeBtnListTableViewCell.m
//  GolfIOS
//
//  Created by yangbin on 16/11/1.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOHomeBtnListTableViewCell.h"
#import "TSOHomeButton.h"

@implementation TSOHomeBtnListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.clubBtn];
    [self.contentView addSubview:self.tvShowBtn];
    [self.contentView addSubview:self.communityBtn];
    [self.contentView addSubview:self.chartsBtn];
    
    self.clubBtn.sd_layout
    .topEqualToView(self.contentView)
    .leftEqualToView(self.contentView)
    .widthIs(SCREEN_WIDTH * 0.25)
    .bottomEqualToView(self.contentView);
    
    self.tvShowBtn.sd_layout
    .topEqualToView(self.contentView)
    .leftSpaceToView(self.clubBtn, 0)
    .widthIs(SCREEN_WIDTH * 0.25)
    .bottomEqualToView(self.contentView);
    
    self.communityBtn.sd_layout
    .topEqualToView(self.contentView)
    .leftSpaceToView(self.tvShowBtn, 0)
    .widthIs(SCREEN_WIDTH * 0.25)
    .bottomEqualToView(self.contentView);
    
    self.chartsBtn.sd_layout
    .topEqualToView(self.contentView)
    .leftSpaceToView(self.communityBtn, 0)
    .widthIs(SCREEN_WIDTH * 0.25)
    .bottomEqualToView(self.contentView);
    
    
}

- (TSOHomeButton *)clubBtn{
    if (_clubBtn == nil) {
        _clubBtn = [[TSOHomeButton alloc] init];
        [_clubBtn setTitle:@"俱乐部" forState:UIControlStateNormal];
        [_clubBtn setImage:IMAGE(@"classify2") forState:UIControlStateNormal];
    }
    return _clubBtn;
}

- (TSOHomeButton *)tvShowBtn{
    if (_tvShowBtn == nil) {
        _tvShowBtn = [[TSOHomeButton alloc] init];
        [_tvShowBtn setTitle:@"影视乐" forState:UIControlStateNormal];
        [_tvShowBtn setImage:IMAGE(@"classify3") forState:UIControlStateNormal];
    }
    return _tvShowBtn;
}

- (TSOHomeButton *)communityBtn{
    if (_communityBtn == nil) {
        _communityBtn = [[TSOHomeButton alloc] init];
        [_communityBtn setTitle:@"社区秀" forState:UIControlStateNormal];
        [_communityBtn setImage:IMAGE(@"classify4") forState:UIControlStateNormal];
    }
    return _communityBtn;
}

- (TSOHomeButton *)chartsBtn{
    if (_chartsBtn == nil) {
        _chartsBtn = [[TSOHomeButton alloc] init];
        [_chartsBtn  setTitle:@"排行榜" forState:UIControlStateNormal];
        [_chartsBtn setImage:IMAGE(@"classify5") forState:UIControlStateNormal];
        
    }
    return _chartsBtn;
}

@end
