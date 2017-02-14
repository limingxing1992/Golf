//
//  YB_ToolBtn.m
//  GolfIOS
//
//  Created by yangbin on 16/11/7.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "YB_ToolBtn.h"
#import "UIImage+Image.h"

@interface YB_ToolBtn ()

/**bgImageView*/
@property (nonatomic, strong) UIImageView *bgImgView;

@end

@implementation YB_ToolBtn


+ (instancetype)loveButton{
    YB_ToolBtn *loveBtn = [[YB_ToolBtn alloc] init];
    [loveBtn setImage:IMAGE(@"classify15") forState:UIControlStateNormal];
    [loveBtn setImage:IMAGE(@"classify16") forState:UIControlStateSelected];
    [loveBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [loveBtn setTitleColor:LIGHTTEXTCOLOR forState:UIControlStateNormal];
    [loveBtn setTitleColor:GLOBALCOLOR forState:UIControlStateSelected];
    loveBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    loveBtn.titleLabel.font = FONT(14);
    return loveBtn;
}

+ (instancetype)commentButton{
    YB_ToolBtn * commentButton = [[YB_ToolBtn alloc] init];
    [commentButton setImage:IMAGE(@"classify17") forState:UIControlStateNormal];
    [commentButton setImage:IMAGE(@"classify18") forState:UIControlStateSelected];
    commentButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    [commentButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    commentButton.titleLabel.font = FONT(14);
    [commentButton setTitleColor:LIGHTTEXTCOLOR forState:UIControlStateNormal];
    [commentButton setTitleColor:GLOBALCOLOR forState:UIControlStateSelected];

    return commentButton;
}

+ (instancetype)selectButton{
    YB_ToolBtn * selectButton = [[YB_ToolBtn alloc] init];
    [selectButton setImage:IMAGE(@"classify71") forState:UIControlStateNormal];
    [selectButton setImage:IMAGE(@"classify72") forState:UIControlStateSelected];
    selectButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [selectButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    selectButton.titleLabel.font = FONT(12);
    [selectButton setTitleColor:SHENTEXTCOLOR forState:UIControlStateNormal];
    [selectButton setTitleColor:GLOBALCOLOR forState:UIControlStateSelected];
    
    return selectButton;
}



- (instancetype)initBottomButton{
    
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, SCREEN_HEIGHT - 60, SCREEN_WIDTH, 60);
        _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 40)];
        _bgImgView.backgroundColor = GLOBALCOLOR;
        _bgImgView.layer.cornerRadius = 4;
        [self insertSubview:_bgImgView atIndex:0];
        self.backgroundColor = WHITECOLOR;
    }
    return self;

}

- (void)setHighlighted:(BOOL)highlighted{
    if (highlighted == YES) {
        _bgImgView.backgroundColor = RGBColor(49,162,73);
    }else{
        _bgImgView.backgroundColor = GLOBALCOLOR;
    }
    [super setHighlighted:highlighted];
}





@end
