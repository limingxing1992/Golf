//
//  LevelProgressView.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/10.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "LevelProgressView.h"

@interface LevelProgressView ()
/** 指示图*/
@property (nonatomic, strong) UIImageView *indicatorIv;
/** 当前等级图*/
@property (nonatomic, strong) UIImageView *currentIv;
/** 未来等级图*/
@property (nonatomic, strong) UIImageView *futureIv;
/** 当前等级*/
@property (nonatomic, strong) UILabel *currentLb;
/** 未来等级*/
@property (nonatomic, strong) UILabel *futureLb;




@end

@implementation LevelProgressView


- (instancetype)init{
    self =[super init];
    if (self) {
        [self addSubview:self.indicatorIv];
        [self addSubview:self.currentIv];
        [self addSubview:self.futureIv];
        [self addSubview:self.futureLb];
        [self addSubview:self.currentLb];
        self.indicatorIv.sd_layout
        .centerYEqualToView(self)
        .leftSpaceToView(self, 23.5)
        .heightIs(13)
        .widthEqualToHeight();
        
        self.currentIv.sd_layout
        .centerYEqualToView(self)
        .leftSpaceToView(self, 0)
        .heightIs(23.5)
        .widthEqualToHeight();
        
        self.futureIv.sd_layout
        .centerYEqualToView(self)
        .rightSpaceToView(self, 0)
        .heightIs(23.5)
        .widthEqualToHeight();
        
        self.currentLb.sd_layout
        .topSpaceToView(self, -28)
        .centerXEqualToView(_currentIv)
        .autoHeightRatio(0);
        [self.currentLb setSingleLineAutoResizeWithMaxWidth:300];
        
        self.futureLb.sd_layout
        .topSpaceToView(self, -28)
        .centerXEqualToView(_futureIv)
        .autoHeightRatio(0);
        [self.futureLb setSingleLineAutoResizeWithMaxWidth:300];
    }
    return self;

}

#pragma mark ----------------界面逻辑

/** 改变进度条*/
- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsDisplay];
}
/** 改变等级图和等级文字*/
- (void)setLevel:(NSInteger)level{
    //根据level等级替换两个指示图
}
/** 重会，内外矩形*/
- (void)drawRect:(CGRect)rect{
    [self.indicatorIv setLeft_sd:(self.frame.size.width - 44) * _progress + 20.5];
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    
    //指定矩形
    
    //外圈
    CGRect rectangle = CGRectMake(22, 0.5,rect.size.width-44,
                                  rect.size.height - 1);
    
    
    //将矩形添加到路径中
    
    
    CGPathAddRect(path,NULL,
                  rectangle);
    
    //内圈
    CGMutablePathRef path_1 = CGPathCreateMutable();
    CGRect rect_1 = CGRectMake(22, 0.5, (rect.size.width - 44) *_progress, rect.size.height - 1);
    CGPathAddRect(path_1, NULL, rect_1);
    
    //获取上下文
    
    
    CGContextRef currentContext =
    UIGraphicsGetCurrentContext();
    
    
    //将路径添加到上下文
    
    
    CGContextAddPath(currentContext, path);
    //设置矩形填充色
    
    
    [GLOBALCOLOR setFill];
    
    
    //矩形边框颜色
    
    
    [WHITECOLOR setStroke];
    
    
    //边框宽度
    
    
    CGContextSetLineWidth(currentContext,1);
    
    
    //绘制
    
    
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    
    
    CGPathRelease(path);
    CGContextAddPath(currentContext, path_1);
    [[UIColor redColor] setFill];
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    CGPathRelease(path_1);
}



#pragma mark ----------------实例化

- (UIImageView *)indicatorIv{
    if (!_indicatorIv) {
        _indicatorIv = [[UIImageView alloc] init];
        _indicatorIv.image = IMAGE(@"classify126");
    }
    return _indicatorIv;
}

- (UIImageView *)currentIv{
    if (!_currentIv) {
        _currentIv = [[UIImageView alloc] init];
        _currentIv.image = IMAGE(@"classify124");
    }
    return _currentIv;
}

- (UIImageView *)futureIv{
    if (!_futureIv) {
        _futureIv  = [[UIImageView alloc] init];
        _futureIv.image = IMAGE(@"classify125");
    }
    return _futureIv;
}

- (UILabel *)currentLb{
    if (!_currentLb) {
        _currentLb = [[UILabel alloc] init];
        _currentLb.font = FONT(14);
        _currentLb.text =@"男爵";
        _currentLb.textColor = WHITECOLOR;
    }
    return _currentLb;
}

- (UILabel *)futureLb{
    if (!_futureLb) {
        _futureLb = [[UILabel alloc] init];
        _futureLb.font = FONT(14);
        _futureLb.textColor = WHITECOLOR;
        _futureLb.text = @"子爵";
    }
    return _futureLb;
}

@end
