//
//  TSORecoreView.m
//  GolfIOS
//
//  Created by yangbin on 16/11/15.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TSORecoreView.h"

@interface TSORecoreView ()

/**labelArr*/
@property (nonatomic, strong) NSMutableArray *labelArray;
/**clour*/
@property (nonatomic, strong) UIColor *color;

@end

#define recordwidth ((SCREEN_HEIGHT * 0.9) - 100) / 19
#define recordHeight SCREEN_WIDTH * 0.06


@implementation TSORecoreView



- (instancetype)initWithColor:(UIColor *)color{
    self = [super init];
    if (self) {
        _color = color;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{

    for (int i = 0; i < 21; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        if (i == 20) {
            label.frame = CGRectMake(i * recordwidth + 10, 0, recordwidth, recordHeight);
        }else{
        
            label.frame = CGRectMake((i * recordwidth), 0, recordwidth, recordHeight);
        }
        [self addSubview:label];
        if (_color) {
           label.textColor = _color;
        }else{
            label.textColor = BLACKCOLOR;
        }
        label.font = FONT(10);
        
        [self.labelArray addObject:label];
    }
    
    
    
}

- (void)setScoreArray:(NSMutableArray *)scoreArray{
    _scoreArray = scoreArray;
    [_labelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UILabel *label = (UILabel *)obj;
        NSNumber *score = (NSNumber *)_scoreArray[idx];
        
        label.text = [NSString stringWithFormat:@"%@",score];
        
    }];
    
}

-(NSMutableArray *)labelArray{
    if (_labelArray == nil) {
        _labelArray = [[NSMutableArray alloc] init];
    }
    return _labelArray;
}
@end
