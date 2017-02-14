//
//  TVSegementView.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/29.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TVSegementView.h"

@interface TVSegementView ()
/** 指示线*/
@property (nonatomic, strong) UIView *indicatorLayer;
/** 记录上次选中标题*/
@property (nonatomic, assign) NSInteger lastSelectIndex;
/** 多少个点？*/
@property (nonatomic, assign) NSInteger countIndex;



@end

@implementation TVSegementView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = WHITECOLOR;

        [self createLayersWithTitles:@[@"人气排名", @"票数排名", @"热度排名"]];//创建标题指示器
        _countIndex = 3;
        [self createTap];
        [self addSubview:self.indicatorLayer];//指示器线条

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
    NSInteger tapIndex = touchPoint.x / (self.frame.size.width / _countIndex);
    //界面处理
    if (tapIndex != _lastSelectIndex) {
        //切换了点击标题
        //记录本次点击
        _lastSelectIndex = tapIndex;
        if (_block) {
            _block(tapIndex);
        }
        
        CGFloat interval = WIDTH_CELL / (_countIndex * 2);
        [UIView animateWithDuration:0.2 animations:^{
            if (_lastSelectIndex == 0) {
                _indicatorLayer.center = CGPointMake(interval, HEIGHT_CELL - 1);
            }else if(_lastSelectIndex == 1){
                _indicatorLayer.center = CGPointMake(interval * 3, HEIGHT_CELL - 1);
            }else{
                _indicatorLayer.center = CGPointMake(interval *5, HEIGHT_CELL - 1);
            }
        }];
        
    }
    
}

#pragma mark ----------------创建标题

- (UIView *)indicatorLayer{
    if (!_indicatorLayer) {
        CGFloat interval = WIDTH_CELL / (_countIndex * 2);

        _indicatorLayer = [[UIView alloc] init];
        _indicatorLayer.frame = CGRectMake(0, 0, WIDTH_CELL / 3, 2);
        _indicatorLayer.center = CGPointMake(interval, HEIGHT_CELL - 1);
        _indicatorLayer.backgroundColor = GLOBALCOLOR;
    }
    return _indicatorLayer;
}


- (void)createLayersWithTitles:(NSArray *)titleAry{
    NSInteger titleCount = titleAry.count;
    CGFloat textLayerInterval = self.frame.size.width / (titleCount *2);
    for (NSInteger i = 0; i < titleCount; i++) {
        //title
        CGPoint titlePosition = CGPointMake( (i * 2  + 1) * textLayerInterval , self.frame.size.height / 2);
        CATextLayer *title = [self createTextLayerWithNSString:titleAry[i] position:titlePosition];
        [self.layer addSublayer:title];
        
    }
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


//获取标题宽度
- (CGSize)calculateTitleSizeWithString:(NSString *)string
{
    CGFloat fontSize = 15.0;
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(280, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size;
}

@end
