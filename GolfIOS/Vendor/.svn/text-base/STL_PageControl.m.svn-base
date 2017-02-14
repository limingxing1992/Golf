//
//  STL_PageControl.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/4.
//  Copyright © 2016年 zzz. All rights reserved.
//
#define PageDicatiorWidth 5
#define PageDicatiorHeight 5
#define PageDicatiorSpacing 3

#import <SDAutoLayout.h>
#import "STL_PageControl.h"


@interface STL_PageControl ()

@end

@implementation STL_PageControl

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.6];
        [self setSd_cornerRadiusFromHeightRatio:@0.5];
    }
    return self;
}

/** 指定页数*/
- (void)setNumberOfPage:(NSInteger)numberOfPage{
    if (_numberOfPage != numberOfPage) {
        //清除以前的控件
        for (UIView *subView in self.subviews) {
            [subView removeFromSuperview];
        }
        //保存分页数
        _numberOfPage = numberOfPage;
        
        for (NSInteger i = 0; i < numberOfPage; i++) {
            UIView *view = [[UIView alloc] init];
            if (i == 0) {
                if (_currentIndicatiorColor) {
                    view.backgroundColor = _currentIndicatiorColor;
                }else{
                    view.backgroundColor = GLOBALCOLOR;
                }
            }else{
                if (_indicatorColor) {
                    view.backgroundColor = _indicatorColor;
                }else{
                    view.backgroundColor = WHITECOLOR;
                }
            }
            [self addSubview:view];
            CGSize size;
            if (_pageSize.width &&_pageSize.height) {
                size = _pageSize;
            }else{
                size = CGSizeMake(PageDicatiorWidth, PageDicatiorHeight);
            }
            
            CGFloat spaceing;
            if (_spacing) {
                spaceing = _spacing;
            }else{
                spaceing = PageDicatiorSpacing;
            }
            
            
            view.sd_layout
            .centerYEqualToView(self)
            .leftSpaceToView(self, 5 + i *(spaceing + size.width))
            .widthIs(size.width)
            .heightIs(size.height);
            [view setSd_cornerRadiusFromWidthRatio:@0.5];
            if (i == numberOfPage - 1) {
                [self setupAutoWidthWithRightView:view rightMargin:5];
            }
        }
    }
}
/** 指定分页*/
- (void)setCurrentPage:(NSInteger)currentPage{
    if (_currentPage == currentPage) {
        return;
    }
    UIView *view_last = self.subviews[_currentPage];
    view_last.backgroundColor = WHITECOLOR;
    _currentPage = currentPage;
    UIView *view_now = self.subviews[_currentPage];
    view_now.backgroundColor = GLOBALCOLOR;
}


@end
