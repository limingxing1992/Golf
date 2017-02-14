//
//  CommentStarView.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/30.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "CommentStarView.h"

@interface CommentStarView ()

/** 展示评级*/
@property (nonatomic, strong) UILabel *tagLb;


/** 存储btn的数组*/
@property (nonatomic, strong) NSMutableArray *btnAry;

@end


@implementation CommentStarView

- (instancetype)initWithNum:(NSInteger)num normalImage:(UIImage *)normalImage selctImage:(UIImage *)selectImage spacing:(CGFloat)spacing size:(CGSize)starSize{
    self = [super init];
    if (self) {
        _lastIndex = -1;
        _btnAry = [[NSMutableArray alloc] initWithCapacity:num];
        [self createStarWithNum:num normalImage:normalImage selctImage:selectImage spacing:spacing size:starSize];
        [self addSubview:self.tagLb];
        self.tagLb.sd_layout
        .topSpaceToView(self, 0)
        .centerXEqualToView(self)
        .autoHeightRatio(0);
        [self.tagLb setSingleLineAutoResizeWithMaxWidth:200];
    }
    return self;
}

/** 创建start*/
- (void)createStarWithNum:(NSInteger)num normalImage:(UIImage *)normalImage selctImage:(UIImage *)selectImage spacing:(CGFloat)spacing size:(CGSize)starSize{
    
    for (NSInteger i = 0; i < num; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = i;
        [btn setImage:normalImage forState:UIControlStateNormal];
        [btn setImage:selectImage forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        btn.sd_layout
        .bottomSpaceToView(self, 0)
        .leftSpaceToView(self, i *(spacing + starSize.width))
        .heightIs(starSize.height)
        .widthIs(starSize.width);
        [_btnAry addObject:btn];
        if (i  == (num - 1)) {
            [self setupAutoWidthWithRightView:btn rightMargin:0];
        }
    }
}

- (UILabel *)tagLb{
    if (!_tagLb) {
        _tagLb = [[UILabel alloc] init];
        _tagLb.font = FONT(14);
        _tagLb.textColor = GLOBALCOLOR;
    }
    return _tagLb;
}

- (void)btnSelectAction:(UIButton *)btn{
    
    NSInteger flag = btn.tag;
    if (flag == _lastIndex) {
        //重复点击上次位置
        return;
    }
    for (UIButton *btn in _btnAry) {
        btn.selected = NO;
    }
    for (NSInteger i = 0; i < flag + 1; i++) {
        UIButton *btn = _btnAry[i];
        btn.selected = YES;
    }
    _lastIndex = flag;
    if (flag <2) {
        _tagLb.text = @"差评";
    }else if (flag < 4){
        _tagLb.text = @"中评";
    }else{
        _tagLb.text = @"好评";
    }
}

@end
