//
//  TVToupiaoDetailViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/29.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TVToupiaoDetailViewController.h"

@interface TVToupiaoDetailViewController ()
<
    UICollectionViewDelegateFlowLayout,
    UICollectionViewDataSource,
    DZNEmptyDataSetSource,
    DZNEmptyDataSetDelegate,
    UIWebViewDelegate
>
/** 顶部图*/
@property (nonatomic, strong) UIImageView *headIv;
/** 标志*/
@property (nonatomic, strong) UILabel *tagLb;
/** 活动介绍模块*/
@property (nonatomic, strong) UIView *introduceView;
/** 介绍*/
@property (nonatomic, strong) UIWebView *introduceVb;
/** 活动时间*/
@property (nonatomic, strong) UIView *timeView;
/** 时间*/
@property (nonatomic, strong) UILabel *timeLb;
/** 切换模块*/
@property (nonatomic, strong) TVSegementView *segementView;
/** 集合视图*/
@property (nonatomic, strong) UICollectionView *collectionView;
/** 数据源*/
@property (nonatomic, strong) NSMutableArray *data_pop;
@property (nonatomic, strong) NSMutableArray *data_vote;
@property (nonatomic, strong) NSMutableArray *data_hot;
/** 排名模式*/
@property (nonatomic, assign) NSInteger sortStyle;//0 == 默认人气排名 1==票数 2== 热度


@end

@implementation TVToupiaoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"小鸟投票";
    [self.contentView sd_addSubviews:@[self.headIv, self.tagLb, self.introduceView, self.timeView, self.segementView,
                                       self.collectionView]];
    [self autoLayoutSubViews];
    [self loadActionDetailInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)autoLayoutSubViews{
    _headIv.sd_layout
    .topSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(150);
    
    _tagLb.sd_layout
    .topSpaceToView(_headIv, 0)
    .leftEqualToView(_headIv)
    .rightEqualToView(_headIv)
    .heightIs(45);
    
    _introduceView.sd_layout
    .topSpaceToView(_tagLb, 0)
    .leftEqualToView(_tagLb)
    .rightEqualToView(_tagLb);
    
    [_introduceView setupAutoHeightWithBottomView:_introduceVb bottomMargin:10];

    
    _timeView.sd_layout
    .topSpaceToView(_introduceView, 10)
    .leftEqualToView(_introduceView)
    .rightEqualToView(_introduceView)
    .heightIs(50);
    
    _segementView.sd_layout
    .topSpaceToView(_timeView, 10)
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(45);
    
    
    _collectionView.sd_layout
    .topSpaceToView(_segementView, 10)
    .leftSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(SCREEN_HEIGHT - 464);
    
    [self.contentView setupAutoContentSizeWithBottomView:_collectionView bottomMargin:10];
}

#pragma mark ----------------数据

- (void)initData{
    _data_pop = [[NSMutableArray alloc] init];
    _data_vote = [[NSMutableArray alloc] init];
    _data_hot = [[NSMutableArray alloc] init];
}
/** 投票排行数据*/
- (void)loadData{
    [SVProgressHUD show];
    GOLFWeakObj(self);
    switch (_sortStyle) {
        case 0:
        {
            [ShareBusinessManager.tvManager postTvPopRankListWithParameters:@{@"activityId":_Id}
                                                                    success:^(id responObject) {
                                                                        [SVProgressHUD dismiss];
                                                                        [weakself.data_pop removeAllObjects];
                                                                        [weakself.data_pop addObjectsFromArray:responObject];
                                                                        [weakself.collectionView reloadData];
                                                                        [weakself autoCollectionViewHeightWithCount:weakself.data_pop.count];
                                                                        
                                                                    } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                        [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                    }];
        }
            break;
        case 1:
        {
            [ShareBusinessManager.tvManager postTvVoteRankListWithParameters:@{@"activityId":_Id}
                                                                     success:^(id responObject) {
                                                                         [SVProgressHUD dismiss];
                                                                         [weakself.data_vote removeAllObjects];
                                                                         [weakself.data_vote addObjectsFromArray:responObject];
                                                                         [weakself.collectionView reloadData];
                                                                         [weakself autoCollectionViewHeightWithCount:weakself.data_vote.count];
                                                                     } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                         [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                     }];
        }
            break;
        case 2:
        {
            [ShareBusinessManager.tvManager postTvHotRankListWithParameters:@{@"activityId":_Id}
                                                                    success:^(id responObject) {
                                                                        [SVProgressHUD dismiss];
                                                                        [weakself.data_hot removeAllObjects];
                                                                        [weakself.data_hot addObjectsFromArray:responObject];
                                                                        [weakself.collectionView reloadData];
                                                                        [weakself autoCollectionViewHeightWithCount:weakself.data_hot.count];
                                                                    } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                        [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                    }];
        }
            break;
        default:
            break;
    }
}
/** 计算集合视图高度*/
- (void)autoCollectionViewHeightWithCount:(NSInteger)dataCount{
        NSInteger count = dataCount / 2;
        if (dataCount % 2) {
            count += 1;
        }
    if (dataCount != 0) {
        _collectionView.sd_layout
        .heightIs(count *260);
    }
    
//    [self.contentView setupAutoContentSizeWithBottomView:_collectionView bottomMargin:10];

}
/** 请求活动详情数据*/
- (void)loadActionDetailInfo{
    GOLFWeakObj(self);
    
    [ShareBusinessManager.tvManager postTvVoteActionDetailInfoWithParameters:@{@"activityId":_Id}
                                                                     success:^(id responObject) {

                                                                         [weakself updateInfoWithModel:responObject];
                                                                         
                                                                     } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                         [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                     }];
}


/** 根据数据更新活动详情界面*/
- (void)updateInfoWithModel:(TvVoteActionModel *)model{
    [_headIv sd_setImageWithURL:FULLIMGURL(model.imageUrl) placeholderImage:Placeholder_big];
    
    [SVProgressHUD show];
    [_introduceVb loadHTMLString:model.content baseURL:nil];
    
    _timeLb.text = [NSString stringWithFormat:@"%@-%@",model.startTime, model.endTime];

}

#pragma mark ----------------界面逻辑

/** 切换当前排名模式*/
- (void)changeSelectIndex:(NSInteger)index{
    switch (index) {
        case 0:
        {
            _sortStyle = 0;
        }
            break;
        case 1:
        {
            _sortStyle = 1;
        }
            break;
        case 2:
        {
            _sortStyle = 2;
        }
            break;

        default:
            break;
    }
    
    [self loadData];
}

#pragma mark ----------------缺省页代理


- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return nil;
}


#pragma mark ----------------web代理

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    CGRect frame = webView.frame;
    
    frame.size.width = SCREEN_WIDTH;
    
    frame.size.height = 1;
    
    webView.scrollView.scrollEnabled = NO;
    
    webView.frame = frame;
    
    frame.size.height = webView.scrollView.contentSize.height + 20;
    
    
    webView.frame = frame;
    
    [SVProgressHUD dismiss];

}

#pragma mark ----------------集合代理

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (_sortStyle) {
        case 0:
        {
            return _data_pop.count;
        }
            break;
        case 1:
        {
            return _data_vote.count;
        }
            break;
        case 2:
        {
            return _data_hot.count;
        }
            break;
        default:
            break;
    }
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TvToupiaoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"toupiaoCell" forIndexPath:indexPath];
    TvVoteModel *model;
    switch (_sortStyle) {
        case 0:
        {
            model = _data_pop[indexPath.row];
        }
            break;
        case 1:
        {
            model = _data_vote[indexPath.row];
        }
            break;
        case 2:
        {
            model = _data_hot[indexPath.row];
        }
            break;
        default:
            break;
    }
    cell.model = model;

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TVToupiaoUserDetailViewController *detailVc = [[TVToupiaoUserDetailViewController alloc] init];
    TvVoteModel *model;
    switch (_sortStyle) {
        case 0:
        {
            model = _data_pop[indexPath.row];
        }
            break;
        case 1:
        {
            model = _data_vote[indexPath.row];
        }
            break;
        case 2:
        {
            model = _data_hot[indexPath.row];
        }
            break;
        default:
            break;
    }
    detailVc.model = model;
    [self.navigationController pushViewController:detailVc animated:YES];
}


#pragma mark ----------------实例

- (UIImageView *)headIv{
    if (!_headIv) {
        _headIv = [[UIImageView alloc] init];
        _headIv.image  = Placeholder_big;
    }
    return _headIv;
}

- (UILabel *)tagLb{
    if (!_tagLb) {
        _tagLb = [[UILabel alloc] init];
        _tagLb.backgroundColor = GLOBALCOLOR;
        _tagLb.font = FONT(14);
        _tagLb.textColor = WHITECOLOR;
        _tagLb.text = @"正在进行中...";
        _tagLb.textAlignment = NSTextAlignmentCenter;
    }
    return _tagLb;
}

- (UIView *)introduceView{
    if (!_introduceView) {
        _introduceView = [[UIView alloc] init];
        _introduceView.backgroundColor = WHITECOLOR;
        UIView *iv = [[UIView alloc] init];
        iv.backgroundColor = GLOBALCOLOR;
        [_introduceView addSubview:iv];
        UILabel *title = [[UILabel alloc] init];
        title.font = FONT(14);
        title.textColor = BLACKTEXTCOLOR;
        title.text = @"活动介绍";
        [_introduceView addSubview:title];
        
        iv.sd_layout
        .topSpaceToView(_introduceView, 12)
        .leftSpaceToView(_introduceView, 15)
        .heightIs(20)
        .widthIs(4);
        
        title.sd_layout
        .centerYEqualToView(iv)
        .leftSpaceToView(iv, 7.5)
        .rightSpaceToView(_introduceView, 15)
        .autoHeightRatio(0);
        
        [_introduceView addSubview:self.introduceVb];
        
        _introduceVb.sd_layout
        .topSpaceToView(iv, 10)
        .leftSpaceToView(_introduceView, 20)
        .rightSpaceToView(_introduceView, 10);
        
        [_introduceView setupAutoHeightWithBottomView:_introduceVb bottomMargin:10];
        
    }
    return _introduceView;
}

- (UIWebView *)introduceVb{
    if (!_introduceVb) {
        _introduceVb = [[UIWebView alloc] init];
        _introduceVb.delegate = self;
    }
    return _introduceVb;
}

- (UIView *)timeView{
    if (!_timeView) {
        _timeView = [[UIView alloc] init];
        _timeView.backgroundColor = WHITECOLOR;
        
        UIView *iv = [[UIView alloc] init];
        iv.backgroundColor = RGBColor(242, 103, 0);
        [_timeView addSubview:iv];
        UILabel *title = [[UILabel alloc] init];
        title.font = FONT(14);
        title.textColor = BLACKTEXTCOLOR;
        title.text = @"活动时间";
        [_timeView addSubview:title];
        
        iv.sd_layout
        .centerYEqualToView(_timeView)
        .leftSpaceToView(_timeView, 15)
        .heightIs(20)
        .widthIs(4);
        
        title.sd_layout
        .centerYEqualToView(iv)
        .leftSpaceToView(iv, 7.5)
        .autoHeightRatio(0);
        [title setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
        
        [_timeView addSubview:self.timeLb];
        
        _timeLb.sd_layout
        .centerYEqualToView(title)
        .leftSpaceToView(title, 5)
        .rightSpaceToView(_timeView, 15)
        .autoHeightRatio(0);

    }
    return _timeView;
}

- (UILabel *)timeLb{
    if (!_timeLb) {
        _timeLb = [[UILabel alloc] init];
        _timeLb.font = FONT(12);
        _timeLb.textColor = LIGHTTEXTCOLOR;
    }
    return _timeLb;
}

- (TVSegementView *)segementView{
    if (!_segementView) {
        GOLFWeakObj(self);
        _segementView = [[TVSegementView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 30, 45)];
        _segementView.block = ^(NSInteger index){
            [weakself changeSelectIndex:index];
        };
    }
    return _segementView;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout  = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 30 - 12) / 2, 250);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 12;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;//默认排列方向垂直。
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = BACKGROUNDCOLOR;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.emptyDataSetSource = self;
        _collectionView.emptyDataSetDelegate = self;
        [_collectionView registerClass:[TvToupiaoCollectionViewCell class] forCellWithReuseIdentifier:@"toupiaoCell"];
    }
    return _collectionView;
}


@end
