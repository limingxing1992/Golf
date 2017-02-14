//
//  TSOScoreAddPlayerCell.m
//  GolfIOS
//
//  Created by yangbin on 16/12/26.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TSOScoreAddPlayerCell.h"
#import "TSOAddPlayerButton.h"
#import "ScoreUserModel.h"
#import "ScoreUser.h"


@interface TSOScoreAddPlayerCell ()



@end

@implementation TSOScoreAddPlayerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)setPlayers:(NSArray *)players{
    _players = players;
    
    for (UIView *subView in self.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    CGFloat btnW = 50;
    CGFloat btnH = 80;
    NSInteger playsCount = players.count;
    
    if (IsLogin) {
        [players enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ScoreUser *user = _players[idx];
            TSOAddPlayerButton *playerBtn = [[TSOAddPlayerButton alloc] init];
            [playerBtn setTitle:user.nickName forState:UIControlStateNormal];
            playerBtn.tag = user.userId.integerValue;

            [playerBtn sd_setImageWithURL:FULLIMGURL(user.headUrl.absoluteString) forState:UIControlStateNormal];
            playerBtn.frame = CGRectMake(idx * (btnW + 25) + 15, 0, btnW, btnH);
            [self.contentView addSubview:playerBtn];
            [playerBtn addTarget:self action:@selector(playerBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        }];
        
        
        TSOAddPlayerButton *addBtn = [[TSOAddPlayerButton alloc] init];
        
        [addBtn setImage:IMAGE(@"classify34")  forState:UIControlStateNormal];
        [addBtn setTitle:@"添加" forState:UIControlStateNormal];
        addBtn.frame = CGRectMake(playsCount * (btnW + 25) + 15, 0, btnW, btnH);
        [addBtn addTarget:self action:@selector(addPlayer:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:addBtn];
    }else{
        [SVProgressHUD showErrorWithStatus:@"未登陆"];
    }

}

- (void)playerBtnDidClick:(TSOAddPlayerButton *)button{
    if (_playBtnDidClick) {
        _playBtnDidClick(button);
    }
}

- (void)addPlayer:(TSOAddPlayerButton *)button{
    if (_addPlayer) {
        _addPlayer();
    }
}

@end
