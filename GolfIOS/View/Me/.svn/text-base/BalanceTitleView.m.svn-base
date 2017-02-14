//
//  BalanceTitleView.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/12.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BalanceTitleView.h"

@interface BalanceTitleView ()

/** 指示线*/
@property (nonatomic, strong) UIView *indicatorLayer;
/** 记录上次选中标题*/
@property (nonatomic, assign) NSInteger lastSelectIndex;

@property (nonatomic, assign) NSInteger titleCount;


@end


@implementation BalanceTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WHITECOLOR;
        [self createLayersWithTitles:@[@"全部", @"充值", @"消费"]];//创建标题指示器
        [self createTap];//添加手势
        
        //底部线条
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 0.5, frame.size.width, 0.5)];
        lineView.backgroundColor = GRAYCOLOR;
        [self addSubview:lineView];
        [self addSubview:self.indicatorLayer];
        
    }
    return self;
}

#pragma mark ----------------添加手势

- (void)createTap{
    UITapGestureRecognizer *menuTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuTapped:)];
    [self addGestureRecognizer:menuTap];
}
//菜单栏点击
- (void)menuTapped:(UITapGestureRecognizer *)sender{
    CGPoint touchPoint = [sender locationInView:self];//获取手势触发点
    NSInteger tapIndex = touchPoint.x / (self.frame.size.width / _titleCount);
    //界面处理
    if (tapIndex != _lastSelectIndex) {
        //切换了点击标题
        //记录本次点击
        _lastSelectIndex = tapIndex;
        if (_block) {
            _block(tapIndex);
        }
        CGFloat interval = SCREEN_WIDTH / (_titleCount *2);
        [UIView animateWithDuration:0.2 animations:^{
            
            _indicatorLayer.center = CGPointMake(interval * (2 *_lastSelectIndex + 1), HEIGHT_CELL - 0.5);
//            if (_lastSelectIndex == 0) {
//                _indicatorLayer.center = CGPointMake(SCREEN_WIDTH / _titleCount *2, HEIGHT_CELL - 0.5);
//            }else if{
//                _indicatorLayer.center = CGPointMake(SCREEN_WIDTH / _titleCount * 2 *3, HEIGHT_CELL - 0.5);
//            }
        }];
        
    }
    
}

#pragma mark ----------------创建标题

- (void)createLayersWithTitles:(NSArray *)titleAry{
    _titleCount = titleAry.count;
    CGFloat textLayerInterval = self.frame.size.width / (_titleCount *2);
//    CGFloat separatorLineInterval = self.frame.size.width / _titleCount;
    for (NSInteger i = 0; i < _titleCount; i++) {
        //title
        CGPoint titlePosition = CGPointMake( (i * 2  + 1) * textLayerInterval , self.frame.size.height / 2);
        CATextLayer *title = [self createTextLayerWithNSString:titleAry[i] position:titlePosition];
        [self.layer addSublayer:title];
//        //separato
//        if (i != _titleCount - 1) {
//            CGPoint separatorPosition = CGPointMake((i + 1) * separatorLineInterval, self.frame.size.height/2);
//            CAShapeLayer *separator = [self createSeparatorLineWithPosition:separatorPosition];
//            [self.layer addSublayer:separator];
//        }
        
    }
}

- (UIView *)indicatorLayer{
    if (!_indicatorLayer) {
        _indicatorLayer = [[UIView alloc] init];
        _indicatorLayer.frame = CGRectMake(0, 0, 30, 2);
        _indicatorLayer.center = CGPointMake(SCREEN_WIDTH / (_titleCount *2), HEIGHT_CELL - 1);
        _indicatorLayer.backgroundColor = GLOBALCOLOR;
    }
    return _indicatorLayer;
}

//创建分割线
- (CAShapeLayer *)createSeparatorLineWithPosition:(CGPoint)point {
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(160,30)];
    [path addLineToPoint:CGPointMake(160, self.frame.size.height - 30)];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.strokeColor = GRAYCOLOR.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    
    CGPathRelease(bound);
    
    layer.position = point;
    
    return layer;
}
//创建标题
- (CATextLayer *)createTextLayerWithNSString:(NSString *)string position:(CGPoint)point {
    
    CGSize size = [self calculateTitleSizeWithString:string];
    
    CATextLayer *layer = [CATextLayer new];
    CGFloat sizeWidth = (size.width < (self.frame.size.width / _titleCount) - 25) ? size.width : self.frame.size.width / _titleCount - 25;
    layer.bounds = CGRectMake(0, 0, sizeWidth, size.height);
    layer.string = string;
    layer.fontSize = 14.0;
    layer.alignmentMode = kCAAlignmentCenter;
    layer.foregroundColor = BLACKTEXTCOLOR.CGColor;
    
    layer.contentsScale = [[UIScreen mainScreen] scale];
    
    layer.position = point;
    
    return layer;
}


//获取标题宽度
- (CGSize)calculateTitleSizeWithString:(NSString *)string
{
    CGFloat fontSize = 14.0;
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(280, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size;
}

@end
