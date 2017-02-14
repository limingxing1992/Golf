//
//  STL_SegementControl.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/2.
//  Copyright © 2016年 zzz. All rights reserved.
//
#define size_width self.bounds.size.width

#import "STL_SegementControl.h"

@interface STL_SegementControl ()
{
    UIView * markView;
}
@property(nonatomic,assign)CGPoint initPoint;
@property(nonatomic,assign)CGPoint markViewOldPoint;
@property(nonatomic,strong)NSMutableArray<UILabel *> * NormalsubViews;
@property(nonatomic,strong)NSMutableArray<UILabel *> * SelectsubViews;
@property(nonatomic,strong)NSMutableArray<NSValue*> * PointsSectionArray;
@property(nonatomic,assign)NSInteger beginPosition;
@property(nonatomic,assign)NSInteger endPosition;

@end

@implementation STL_SegementControl
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initBaseModel];
    }
    return self;
}
//
-(void)initBaseModel
{
    self.NormalsubViews = [NSMutableArray array];
    self.SelectsubViews = [NSMutableArray array];
    self.PointsSectionArray = [NSMutableArray array];
    self.selectionColor = [UIColor orangeColor];
    self.position = 0;
    self.inset = 0;
    self.beginPosition=0;
    self.endPosition = 0;
}
// 停止拖拽后 停留位置
-(NSInteger)aninmationForNowpoint:(CGPoint )point{
    
    
    __block NSInteger loc;
    [self.PointsSectionArray enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj CGPointValue].x>=point.x) {
            
            if ([obj CGPointValue].x-point.x<= size_width/(2*(self.PointsSectionArray.count))) {
                loc = idx;
            }else{
                loc =  idx-1;
            }
            * stop = YES;
        }
    }];
    self.endPosition = loc;
    return loc;
}

- (void)setIndex:(NSInteger)index{
    [self setPosition:index];
}

// 拖拽事件
-(void)panAction:(UIPanGestureRecognizer *)pan{
    if (pan.state ==UIGestureRecognizerStateBegan) {
        self.initPoint = markView.center;
        if (self.delegat &&[self.delegat respondsToSelector:@selector(beginScrollerFormPosintion:)]) {
            [self.delegat beginScrollerFormPosintion:self.beginPosition];
        }
        return;
    }
    
    if (pan.state == UIGestureRecognizerStateChanged) {
        NSLog(@"%f",[pan translationInView:self].x);
        CGPoint point;
        if (self.initPoint.x+[pan translationInView:self].x>=[self.NormalsubViews firstObject].center.x && self.initPoint.x+[pan translationInView:self].x<=[self.NormalsubViews lastObject].center.x) {
            point = CGPointMake(self.initPoint.x+[pan translationInView:self].x, markView.center.y);
        }else{
            point = self.initPoint.x+[pan translationInView:self].x>size_width/2?[self.NormalsubViews lastObject].center:[self.NormalsubViews firstObject].center;
        }
        [self layoutMakeViewWithPoint:point];

    }else{
        [UIView animateWithDuration:0.2 animations:^{
            [self layoutMakeViewWithPoint:[self.PointsSectionArray[[self aninmationForNowpoint:self->markView.center]]CGPointValue]];
        } completion:^(BOOL finished) {
            if (self.delegat &&[self.delegat respondsToSelector:@selector(endScrollerFormPosintion:)]) {
                [self.delegat endScrollerFormPosintion:self.endPosition];
                self.beginPosition = self.endPosition;
            }
            
        }];
    }
}


//获取标题宽度
- (CGSize)calculateTitleSizeWithString:(NSString *)string
{
    CGFloat fontSize = 15.0;
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(280, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.NormalsubViews.count==0) {
        return;
    }
    
    
    CGFloat subView_width = size_width/self.NormalsubViews.count / 2;
    [self.PointsSectionArray removeAllObjects];
    for (NSInteger i = 0; i < _NormalsubViews.count; i++) {
        UILabel *lb = _NormalsubViews[i];
        CGSize size = [self calculateTitleSizeWithString:lb.text];
        [lb setFrame:CGRectMake(0, 0, size.width+ 20, 30)];
        [lb setCenter:CGPointMake((i *2 + 1) * subView_width, self.frame.size.height / 2)];
        [self.PointsSectionArray addObject:[NSValue valueWithCGPoint:lb.center]];
    }
    [markView setFrame:CGRectInset(self.NormalsubViews[0].frame, self.inset, self.inset)];
    [self layoutMakeViewWithPoint:self.NormalsubViews[self.position].center];
    [self decorateViews];
    
}
// 修饰控件形状
-(void)decorateViews{
    self.layer.cornerRadius = self.cornerRadius;
    markView.layer.cornerRadius = self.cornerRadius<markView.bounds.size.height/2?self.cornerRadius:markView.bounds.size.height/2;
    markView.backgroundColor = self.selectionColor;
    markView.clipsToBounds = YES;
}
-(void)layoutMakeViewWithPoint:(CGPoint)point{
    markView.center = point;
    [self.NormalsubViews enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel * seleectLabel = self.SelectsubViews[idx];
        [seleectLabel setFrame:[self convertRect:obj.frame toView:self->markView]];
    }];
}
#pragma  mark---setters
-(void)setItems:(NSArray<ScrollItem *> *)items
{
    _items = items;
    
    [self.NormalsubViews removeAllObjects];
    [self.SelectsubViews removeAllObjects];
    [items enumerateObjectsUsingBlock:^(ScrollItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UILabel * label = [UILabel new];
        label.font = FONT(15);
        [label setText:obj.item_Name];
        [label setTextColor:obj.title_norml_Color];
        [self addSubview:label];
        [self.NormalsubViews addObject:label];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [label addGestureRecognizer:tap];
        
    }];
    
    markView = [UIView new];
    [self addSubview:markView];
    
    
    [items enumerateObjectsUsingBlock:^(ScrollItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel * label = [UILabel new];
        label.font = FONT(15);
        [label setText:obj.item_Name];
        [label setTextColor:obj.title_selected_Color];
        [self->markView addSubview:label];
        [self.SelectsubViews addObject:label];
        [label setTextAlignment:NSTextAlignmentCenter];
        
        
    }];
//    //禁止了拖拽事件
//    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
//    [markView addGestureRecognizer:pan];
    
}
-(void)tapAction:(UITapGestureRecognizer*)tap{
    [self.PointsSectionArray enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToValue:[NSValue valueWithCGPoint:tap.view.center]]) {
            [self setPosition:idx];
            if (_delegat) {
                [_delegat selectByIndex:idx];
            }
        }
    }];
}

-(void)setPosition:(NSInteger)position
{
    _position = position;
    if (self.PointsSectionArray.count==0)return;
    self.endPosition = position;
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutMakeViewWithPoint:[self.PointsSectionArray[position]CGPointValue]];
    } completion:^(BOOL finished) {
        if (self.delegat &&[self.delegat respondsToSelector:@selector(endScrollerFormPosintion:)]) {
            [self.delegat endScrollerFormPosintion:self.endPosition];
            self.beginPosition = self.endPosition;
        }
    }];
    
}

@end


@implementation ScrollItem
-(id)initWithItem_Name:(NSString *)item_Name title_norml_Color:(UIColor *)title_norml_Color tile_selected_Color:(UIColor *)tile_selected_Color
{
    if (self = [super init]) {
        self.item_Name = item_Name;
        self.title_norml_Color = title_norml_Color;
        self.title_selected_Color = tile_selected_Color;
    }
    return self;
}


@end

