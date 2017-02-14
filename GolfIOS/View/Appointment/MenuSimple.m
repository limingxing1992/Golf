//
//  MenuSimple.m
//  MenuSimple
//
//  Created by 李明星 on 2016/11/2.
//  Copyright © 2016年 李明星. All rights reserved.
//

#import "MenuSimple.h"


@interface MenuSimple ()
/** 记录上次选中标题*/
@property (nonatomic, assign) NSInteger lastSelectIndex;
/** 记录上次选中顺序*/
@property (nonatomic, assign) BOOL isUp;
/** 距离排序指示图片*/
@property (nonatomic, strong) UIImageView *distanceIv;
/** 价格排序指示图片*/
@property (nonatomic, strong) UIImageView *priceIv;

@property (nonatomic, strong) NSMutableArray *titleLayerData;



@end

@implementation MenuSimple

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WHITECOLOR;
        _lastSelectIndex = 0;
        _isUp = NO;
        _titleLayerData = [[NSMutableArray alloc] init];
        [self createLayersWithTitles:@[@"智能排序", @"距离排序", @"价格排序"]];//创建标题指示器
        [self createTap];//添加手势
//        [self addSubview:self.distanceIv];
//        [self addSubview:self.priceIv];
        //切割线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 0.5, frame.size.width, 0.5)];
        lineView.backgroundColor = GRAYCOLOR;
        [self addSubview:lineView];
    }
    return self;
}

#pragma mark ----------------创建标题

- (void)createLayersWithTitles:(NSArray *)titleAry{
    NSInteger titleCount = titleAry.count;
    CGFloat textLayerInterval = self.frame.size.width / (titleCount *2);
    CGFloat separatorLineInterval = self.frame.size.width / titleCount;
    for (NSInteger i = 0; i < titleCount; i++) {
        //title
        CGPoint titlePosition = CGPointMake( (i * 2  + 1) * textLayerInterval , self.frame.size.height / 2);
        CATextLayer *title = [self createTextLayerWithNSString:titleAry[i] position:titlePosition];
        if (i==0) {
            title.foregroundColor = GLOBALCOLOR.CGColor;
        }
        [self.titleLayerData addObject:title];
        [self.layer addSublayer:title];
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
    CGFloat sizeWidth = (size.width < (self.frame.size.width / 3) - 25) ? size.width : self.frame.size.width / 3 - 25;
    layer.bounds = CGRectMake(0, 0, sizeWidth, size.height);
    layer.string = string;
    layer.fontSize = 15.0;
    layer.alignmentMode = kCAAlignmentCenter;
    layer.foregroundColor = BLACKTEXTCOLOR.CGColor;
    
    layer.contentsScale = [[UIScreen mainScreen] scale];
    
    layer.position = point;
    
    return layer;
}

#define TextIntervel self.frame.size.width / 6

- (UIImageView *)distanceIv{
    if (!_distanceIv) {
        CGSize size = [self calculateTitleSizeWithString:@"距离排序"];
        _distanceIv = [[UIImageView alloc] initWithFrame:CGRectMake(TextIntervel *3 + size.width / 2 + 4, HEIGHT_CELL / 2 - 3, 6, 10)];
        _distanceIv.image = IMAGE(@"classify41");
    }
    return _distanceIv;
}

- (UIImageView *)priceIv{
    if (!_priceIv) {
        CGSize size = [self calculateTitleSizeWithString:@"价格排序"];
        _priceIv = [[UIImageView alloc] initWithFrame:CGRectMake(TextIntervel *5 + size.width / 2 + 4, HEIGHT_CELL / 2 - 3, 6, 10)];
        _priceIv.image = IMAGE(@"classify41");
    }
    return _priceIv;
}


//获取标题宽度
- (CGSize)calculateTitleSizeWithString:(NSString *)string
{
    CGFloat fontSize = 15.0;
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(280, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size;
}

#pragma mark ----------------手势

- (void)createTap{
    UITapGestureRecognizer *menuTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuTapped:)];
    [self addGestureRecognizer:menuTap];
}
//菜单栏点击
- (void)menuTapped:(UITapGestureRecognizer *)sender{
    CGPoint touchPoint = [sender locationInView:self];//获取手势触发点
    NSInteger tapIndex = touchPoint.x / (self.frame.size.width / 3);
    //界面处理
    if (tapIndex != _lastSelectIndex) {
        //切换了点击标题
        //记录本次点
        CATextLayer *title_last = _titleLayerData[_lastSelectIndex];
        title_last.foregroundColor = BLACKTEXTCOLOR.CGColor;
        CATextLayer *title_Current = _titleLayerData[tapIndex];
        title_Current.foregroundColor = GLOBALCOLOR.CGColor;
        
        
        _lastSelectIndex = tapIndex;
//        _distanceIv.image = IMAGE(@"classify41");
//        _priceIv.image = IMAGE(@"classify41");
//        if (tapIndex == 1){
//            _distanceIv.image = IMAGE(@"classify31");
//        }else if (tapIndex ==2){
//            _priceIv.image = IMAGE(@"classify31");
//        }
//        _isUp = NO;
        //业务处理
        if (_delegate) {
            [self.delegate changeSortStyleWithIndex:tapIndex style:_isUp];
        }
    }
    //效果图改--没有升序和降许
//    }else{
//        //未切换点击标题
//        if (tapIndex == 0) {
//            //重复点击智能排序无效
//            return;
//        }
//        //改变排序
//        _isUp = !_isUp;
//        if (tapIndex == 1){
//            if (_isUp) {
//                _distanceIv.image = IMAGE(@"classify32");
//            }else{
//                _distanceIv.image = IMAGE(@"classify31");
//            }
//        }else if (tapIndex ==2){
//            if (_isUp) {
//                _priceIv.image = IMAGE(@"classify32");
//            }else{
//                _priceIv.image = IMAGE(@"classify31");
//            }
//        }

//    }
//    //业务处理
//    if (_delegate) {
//        [self.delegate changeSortStyleWithIndex:tapIndex style:_isUp];
//    }
    
}
@end
