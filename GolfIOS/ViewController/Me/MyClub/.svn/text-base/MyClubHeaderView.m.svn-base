//
//  MyClubHeaderView.m
//  GolfIOS
//
//  Created by wyao on 16/12/16.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyClubHeaderView.h"
#import "UIButton+category.h"
#import "TSOMyClubButton.h"


/** 按钮宽度*/
#define btnW SCREEN_WIDTH * 0.5
/** 按钮高度*/
#define btnH  60.0f

#define COLUMN 2

@interface MyClubHeaderView ()
/** 更多按钮背景视图*/
@property (nonatomic, strong) UIView *moreBgView;
/** 查看更多按钮*/
@property (nonatomic, strong) UIButton *moreBtn;
/** 按钮文字数组*/
@property (nonatomic,strong)NSMutableArray * btnTitles;
/** 按钮图片地址数组*/
@property (nonatomic,strong)NSMutableArray * btnImages;

@end

@implementation MyClubHeaderView


-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)setDataList:(NSMutableArray *)DataList{
    _DataList = DataList;
    
    if (DataList.count == 0) {
        return;
    }
    
    [self.btnTitles removeAllObjects];
    [self.btnImages removeAllObjects];
    
    for (MyClubItemModel *model in self.DataList) {
        
        [self.btnTitles addObject:model.clubName];
        [self.btnImages addObject:model.logoUrl];
    }
    
    [self setHeaderViewWithTitlesArray:self.btnTitles andImagesArr:self.btnImages];
    
}


-(void)setHeaderViewWithTitlesArray:(NSArray*)titlesArr  andImagesArr:(NSArray*)imagesArr{
    
    
    if (self.DataList.count <= 0) {
        return;
    }
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    NSInteger ArrCount = (_DataList.count <= 4) ? _DataList.count : 4 ;
    
    for (int i = 0; i < ArrCount ; i++) {
        
        int row = i / COLUMN;
        int column = i % COLUMN;
        
        TSOMyClubButton *btn = [[TSOMyClubButton alloc] init];
        btn.frame = CGRectMake(btnW *column, btnH * row, btnW, btnH);
        btn.tag = i;
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:titlesArr[i] forState:UIControlStateNormal];
        [btn setImage:Placeholder_small forState:UIControlStateNormal];
        btn.titleLabel.font = FONT(14);
        [btn setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(spitlotBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self  addSubview:btn];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:FULLIMGURL(imagesArr[i]) placeholderImage:Placeholder_small];
        [btn setImage:imageView.image forState:UIControlStateNormal];
    }
    
    NSInteger count = (_DataList.count <= 2) ? 1 : 2 ;
    
    [self addSubview:self.moreBgView];
    self.moreBgView.frame = CGRectMake(0, count * btnH, SCREEN_WIDTH, 38);
    
    [self.moreBgView addSubview:self.moreBtn];
    
    self.moreBtn.sd_layout
    .topSpaceToView(self.moreBgView, 12)
    .rightSpaceToView(self.moreBgView,15)
    .heightIs(15)
    .widthIs(80);
    [self.moreBtn setTitleRespectToImageWithStyle:WYCustomerButtonStyleLeft Margin:6 addTarget:nil];
}


#pragma mark - 按钮点击事件
- (void)spitlotBtnClick:(UIButton *)sender {
    
    if (sender.tag == 101) {
        if ([self.delegate respondsToSelector:@selector(MyClubHeaderView:btnDidClickWithClubModel:btnTag:)]) {
            [self.delegate MyClubHeaderView:self btnDidClickWithClubModel:nil btnTag:sender.tag];
        }
    }else{
        NSLog(@"点击第%ld个按钮",sender.tag);
        if (sender.tag < self.DataList.count) {
            //获取对应的模型
            MyClubItemModel *model = self.DataList[sender.tag];
            if (model != nil) {
                if ([self.delegate respondsToSelector:@selector(MyClubHeaderView:btnDidClickWithClubModel:btnTag:)]) {
                    [self.delegate MyClubHeaderView:self btnDidClickWithClubModel:model btnTag:sender.tag];
                }
            }
        }else{
            NSLog(@"点击的按钮没有模型数据");
        }
        
        
    }
}



#pragma mark - 懒加载控件

- (UIButton *)moreBtn{
    if (!_moreBtn) {
        _moreBtn = [[UIButton alloc] init];
        [_moreBtn setTitle:@"查看全部" forState:UIControlStateNormal];
        [_moreBtn setImage:IMAGE(@"classify8") forState:UIControlStateNormal];
        _moreBtn.backgroundColor = WHITECOLOR;
        _moreBtn.tag = 101;
        _moreBtn.titleLabel.font = FONT(15);
        [_moreBtn setTitleColor:SHENTEXTCOLOR forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(spitlotBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}
-(UIView *)moreBgView{
    if (!_moreBgView) {
        _moreBgView = [[UIView alloc] init];
        _moreBgView.backgroundColor = WHITECOLOR;
    }
    return _moreBgView;
}

-(NSMutableArray *)btnTitles {
    if (!_btnTitles) {
        _btnTitles = [NSMutableArray array];
    }
    return _btnTitles;
}
-(NSMutableArray *)btnImages {
    if (!_btnImages) {
        _btnImages = [NSMutableArray array];
    }
    return _btnImages;
}


@end
