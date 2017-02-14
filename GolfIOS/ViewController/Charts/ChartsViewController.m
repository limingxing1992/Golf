//
//  ChartsViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/1.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "ChartsViewController.h"
#import "StrarChartsViewController.h"
#import "BattleScoreViewController.h"
#import "ScroeChartViewController.h"
#define ViewHeight SCREEN_HEIGHT - NaviBar_HEIGHT - 92.5
@interface ChartsViewController ()
<
    STL_SegementControlDelegate,
    UIScrollViewDelegate
>

/** 顶部菜单栏*/
@property (nonatomic, strong) STL_SegementControl *control;
/** 主体*/
@property (nonatomic, strong) UIScrollView *backView;
/** views数组*/
@property (nonatomic, strong) NSArray *viewAry;

@end

@implementation ChartsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"排行榜";
    self.isAutoBack = NO;
    [self createSegement];//创建菜单栏
    [self.view addSubview:self.backView];
    BattleScoreViewController *bc = [[BattleScoreViewController alloc] init];
    bc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, ViewHeight);
    [self addChildViewController:bc];
    ScroeChartViewController *sc = [[ScroeChartViewController alloc] init];
    sc.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, ViewHeight);
    [self addChildViewController:sc];
    StrarChartsViewController *cha = [[StrarChartsViewController alloc] init];
    cha.view.frame = CGRectMake(SCREEN_WIDTH *2, 0, SCREEN_WIDTH, ViewHeight);
    [self addChildViewController:cha];
    
    [self.backView addSubview:bc.view];
    [self.backView addSubview:sc.view];
    [self.backView addSubview:cha.view];
    self.backView.contentSize = CGSizeMake(SCREEN_WIDTH *3, ViewHeight);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ----------------头部菜单栏

- (void)createSegement{
    UIImageView *topIv = [[UIImageView alloc] initWithFrame:CGRectMake(0, NaviBar_HEIGHT, SCREEN_WIDTH, 92.5)];
    topIv.image = IMAGE(@"classify189");
    topIv.userInteractionEnabled = YES;
    [self.view addSubview:topIv];
    
    ScrollItem *item_0 = [[ScrollItem alloc] initWithItem_Name:@"战绩排行" title_norml_Color:SHENTEXTCOLOR tile_selected_Color:WHITECOLOR];
    ScrollItem *item_1 = [[ScrollItem alloc] initWithItem_Name:@"积分排行" title_norml_Color:SHENTEXTCOLOR tile_selected_Color:WHITECOLOR];
    ScrollItem *item_2 = [[ScrollItem alloc] initWithItem_Name:@"明日之星" title_norml_Color:SHENTEXTCOLOR tile_selected_Color:WHITECOLOR];
    
    _control = [[STL_SegementControl alloc] initWithFrame:CGRectMake(0, 16, SCREEN_WIDTH, 30)];
    _control.delegat = self;
    _control.items = @[item_0, item_1, item_2];
    _control.cornerRadius = 15;
    _control.selectionColor = RGBColor(203, 76, 86);
    [topIv addSubview:_control];
}
#pragma mark ----------------菜单栏代理和scorllview代理（控制页面切换）
/** 点击切换*/
- (void)selectByIndex:(NSInteger)index{
    [self.backView setContentOffset:CGPointMake(SCREEN_WIDTH *index, 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    [self.control setIndex:index];
}


- (UIScrollView *)backView{
    if (!_backView) {
        _backView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NaviBar_HEIGHT + 92.5, SCREEN_WIDTH, ViewHeight)];
        _backView.showsVerticalScrollIndicator = NO;
        _backView.showsHorizontalScrollIndicator = NO;
        _backView.delegate = self;
        _backView.backgroundColor = WHITECOLOR;
        _backView.pagingEnabled = YES;
        _backView.scrollEnabled = NO;
    }
    return _backView;
}

@end
