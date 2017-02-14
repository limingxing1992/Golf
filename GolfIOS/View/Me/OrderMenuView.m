//
//  OrderMenuView.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/3.
//  Copyright © 2016年 zzz. All rights reserved.
//

#define OrderTitleCount 5

#import "OrderMenuView.h"

@interface OrderMenuView ()

/** 记录上次选中标题*/
@property (nonatomic, assign) NSInteger lastSelectIndex;
/** 存储标题*/
@property (nonatomic, strong) NSMutableArray *titleIndicatorAry;

@end

@implementation OrderMenuView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WHITECOLOR;
        self.titleIndicatorAry = [NSMutableArray array];
        [self createLayersWithTitles:@[@"全部", @"待付款", @"可使用", @"退款中", @"已完成"]];//创建标题指示器
        [self createTap];//添加手势
        
        //底部线条
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 0.5, frame.size.width, 0.5)];
        lineView.backgroundColor = GRAYCOLOR;
        [self addSubview:lineView];
        
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
    NSInteger tapIndex = touchPoint.x / (self.frame.size.width / OrderTitleCount);
    //界面处理
    if (tapIndex != _lastSelectIndex) {
        //切换了点击标题
        //清除上次点击标题色
        [self changColorWithIndex:_lastSelectIndex newIndex:tapIndex];
        //记录本次点击
        _lastSelectIndex = tapIndex;
        
        if (_block) {
            _block(tapIndex);
        }
    }
}

- (void)changColorWithIndex:(NSInteger)index newIndex:(NSInteger)indexNew{
    CATextLayer *title_last = _titleIndicatorAry[index];
    title_last.foregroundColor = BLACKTEXTCOLOR.CGColor;
    CATextLayer *title_new = _titleIndicatorAry[indexNew];
    title_new.foregroundColor = GLOBALCOLOR.CGColor;

}

#pragma mark ----------------创建标题

- (void)createLayersWithTitles:(NSArray *)titleAry{
    NSInteger titleCount = titleAry.count;
    CGFloat textLayerInterval = self.frame.size.width / (2 *OrderTitleCount);
    CGFloat separatorLineInterval = self.frame.size.width / titleCount;
    for (NSInteger i = 0; i < titleCount; i++) {
        //title
        CGPoint titlePosition = CGPointMake( (i * 2  + 1) * textLayerInterval , self.frame.size.height / 2);
        CATextLayer *title = [self createTextLayerWithNSString:titleAry[i] position:titlePosition];
        [self.layer addSublayer:title];
        //默认初始全部选中
        if (i == 0) {
            title.foregroundColor = GLOBALCOLOR.CGColor;
        }
        [self.titleIndicatorAry addObject:title];
        //separato
        if (i != titleCount - 1) {
            CGPoint separatorPosition = CGPointMake((i + 1) * separatorLineInterval, self.frame.size.height/2);
            CAShapeLayer *separator = [self createSeparatorLineWithPosition:separatorPosition];
            [self.layer addSublayer:separator];
        }
        
    }
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
    CGFloat sizeWidth = (size.width < (self.frame.size.width / OrderTitleCount) - 25) ? size.width : self.frame.size.width / OrderTitleCount - 25;
    layer.bounds = CGRectMake(0, 0, sizeWidth, size.height);
    layer.string = string;
    layer.fontSize = 15.0 *KWidth_Scale;
    layer.alignmentMode = kCAAlignmentCenter;
    layer.foregroundColor = BLACKTEXTCOLOR.CGColor;
    
    layer.contentsScale = [[UIScreen mainScreen] scale];
    
    layer.position = point;
    
    return layer;
}
//获取标题宽度
- (CGSize)calculateTitleSizeWithString:(NSString *)string
{
    CGFloat fontSize = 15.0 *KWidth_Scale;
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(280, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size;
}


@end
