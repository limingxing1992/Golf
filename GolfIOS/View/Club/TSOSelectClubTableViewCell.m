//
//  TSOSelectClubTableViewCell.m
//  GolfIOS
//
//  Created by yangbin on 16/11/9.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOSelectClubTableViewCell.h"
#import "YB_ToolBtn.h"
#import "Club.h"

@interface TSOSelectClubTableViewCell ()



@end

@implementation TSOSelectClubTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.selectBtn];
    
    self.selectBtn.sd_layout
    .topSpaceToView(self.contentView ,2)
    .leftSpaceToView(self.contentView, 20)
    .heightIs(40)
    .rightEqualToView(self.contentView);
    
    [self setupAutoHeightWithBottomView:self.selectBtn bottomMargin:15];
    
    [self.selectBtn setTitle:@"    xxx俱乐部" forState:UIControlStateNormal];
}

- (void)setModel:(Club *)model{
    _model = model;
    
     [self.selectBtn setTitle:[NSString stringWithFormat:@"    %@俱乐部",_model.clubName] forState:UIControlStateNormal];

    _selectBtn.selected = _model.isSelected;

}

- (YB_ToolBtn *)selectBtn{
    if (_selectBtn == nil) {
        _selectBtn = [YB_ToolBtn selectButton];
        [_selectBtn addTarget:self action:@selector(selectBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

-(void)selectBtnClicked{
    if (_callBack) {
        _callBack();
    }
}

@end
