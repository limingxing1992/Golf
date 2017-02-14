//
//  STL_CommentStarView.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/26.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "STL_CommentStarView.h"

@interface STL_CommentStarView ()

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation STL_CommentStarView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createStarSubViews];
    }
    return self;
}

- (void)createStarSubViews{
    if (!_data) {
        _data = [[NSMutableArray alloc] init];
    }
    for (NSInteger i = 0; i < 5; i++) {
        UIImageView  *starView = [[UIImageView alloc] init];
        starView.image = IMAGE(@"classify220");
        [self addSubview:starView];
        starView.sd_layout
        .topSpaceToView(self, 0)
        .leftSpaceToView(self, i * 14)
        .heightIs(12)
        .widthEqualToHeight();
        [_data addObject:starView];
    }
}

- (void)setStarWithInterger:(NSInteger)count{
    
    for (NSInteger i = 0; i < count; i++) {
        UIImageView  *starView = _data[i];
        starView.image = IMAGE(@"classify219");
    }    
}


@end
