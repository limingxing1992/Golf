//
//  TSOScoreSelectHoleCell.m
//  GolfIOS
//
//  Created by yangbin on 16/12/26.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TSOScoreSelectHoleCell.h"

@interface TSOScoreSelectHoleCell ()



@end

@implementation TSOScoreSelectHoleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.contentView addSubview:self.holeLabel];
    [self.contentView addSubview:self.selHole];
    
    self.holeLabel.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .centerYEqualToView(self.contentView)
    .autoHeightRatio(0);
    [self.holeLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.selHole.sd_layout
    .leftSpaceToView(self.holeLabel, 15)
    .centerYEqualToView(self.contentView)
    .heightIs(30)
    .widthIs(150);
}




- (UISegmentedControl *)selHole{
    if (_selHole == nil) {
        _selHole = [[UISegmentedControl alloc] initWithItems:@[@"A场",@"B场"]];
        _selHole.tintColor = GLOBALCOLOR;
    }
    return _selHole;
}

- (UILabel *)holeLabel{
    if (_holeLabel == nil) {
        _holeLabel = [[UILabel alloc] init];
        _holeLabel.textColor = LIGHTTEXTCOLOR;
        _holeLabel.font = FONT(12);
    }
    return _holeLabel;
}
@end
