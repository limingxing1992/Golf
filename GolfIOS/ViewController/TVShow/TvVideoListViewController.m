//
//  TvVideoListViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2017/1/5.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import "TvVideoListViewController.h"


@interface TvVideoListViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    DZNEmptyDataSetSource,
    DZNEmptyDataSetDelegate,
    UIScrollViewDelegate
>
{
    NSIndexPath *_indexPath;
    XLVideoPlayer *_player;
    CGRect _currentPlayCellRect;

}
/** 帖子列表*/
@property (nonatomic, strong) UITableView *tableView;
/** 数据源*/
@property (nonatomic, strong) NSMutableArray *data;
/** 当前页*/
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation TvVideoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"小鸟视频";
    self.isAutoBack = NO;
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self.view addSubview:self.tableView];
    [self loadDataWithRet:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_player destroyPlayer];
    _player = nil;
}

#pragma mark ----------------数据

- (void)initData{
    _data = [[NSMutableArray alloc] init];
    _currentPage = 1;
}

- (void)loadDataWithRet:(BOOL)ret{
    if (ret) {
        _currentPage = 1;
    }else{
        _currentPage += 1;
    }
    GOLFWeakObj(self);
    [ShareBusinessManager.tvManager postTvVideoListWithParameters:@{@"currentPage":[NSNumber numberWithInteger:_currentPage],
                                                                    @"pageSize":PAGESIZE}
                                                          success:^(id responObject) {
                                                              NSArray *data = responObject;
                                                              if (ret) {
                                                                  [weakself.data removeAllObjects];
                                                                  [weakself.tableView.mj_header endRefreshing];
                                                                  [weakself.tableView.mj_footer setState:MJRefreshStateIdle];
                                                              }else{
                                                                  if (data.count < PAGESIZE.integerValue ) {
                                                                      [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
                                                                  }else{
                                                                      [weakself.tableView.mj_footer endRefreshing];
                                                                  }
                                                              }
                                                              [weakself.data addObjectsFromArray:responObject];
                                                              [weakself.tableView reloadData];
 
                                                              
                                                          } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                              [SVProgressHUD showErrorWithStatus:errorMsg];
                                                              if (ret) {
                                                                  [weakself.tableView.mj_header endRefreshing];
                                                              }else{
                                                                  [weakself.tableView.mj_footer endRefreshing];
                                                              }

                                                          }];
}

- (void)showVideoPlayer:(UITapGestureRecognizer *)tapGesture {
    [_player destroyPlayer];
    _player = nil;
    
    UIView *view = tapGesture.view;
    TvVideoModel *item = self.data[view.tag - 100];
    
    if (item.sort > [UserModel sharedUserModel].sort) {
        GOLFWeakObj(self);
        NSString *text = [NSString stringWithFormat:@"当前视频等级需要%@",item.gradeName];
        [STL_CommonIdea alertWithTarget:self Title:@"快去升级啊" message:text action_0:@"取消" action_1:@"确定" block_0:nil block_1:^{
            //跳转荣誉页面升级
            MyLevelViewController *levelVc = [[MyLevelViewController alloc] init];
            [weakself.navigationController pushViewController:levelVc animated:YES];
        }];
        return;
    }
    
    
    _indexPath = [NSIndexPath indexPathForRow:view.tag - 100 inSection:0];
    TvVideoTableViewCell *cell = [self.tableView cellForRowAtIndexPath:_indexPath];
    
    _player = [[XLVideoPlayer alloc] init];
    _player.videoUrl = [NSString stringWithFormat:@"https://tsoudingdan.oss-cn-hangzhou.aliyuncs.com/%@", item.videoUrl];
    
    [_player playerBindTableView:self.tableView currentIndexPath:_indexPath];
    _player.frame = view.bounds;
    
    [cell.contentView addSubview:_player];
    
    _player.completedPlayingBlock = ^(XLVideoPlayer *player) {
        [player destroyPlayer];
        _player = nil;
    };
}

#pragma mark ----------------table代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = (SCREEN_HEIGHT - NaviBar_HEIGHT)/2;
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TvVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TvVideoCell"];
    TvVideoModel *model = self.data[indexPath.row];
    cell.model = model;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showVideoPlayer:)];
    [cell.videoImageView addGestureRecognizer:tap];
    cell.videoImageView.tag = indexPath.row + 100;

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    XLVideoItem *item = self.videoArray[indexPath.row];
    TvVideoModel *model = self.data[indexPath.row];
    
    if (model.sort > [UserModel sharedUserModel].sort) {
        GOLFWeakObj(self);
        NSString *text = [NSString stringWithFormat:@"当前视频等级需要%@",model.gradeName];
        [STL_CommonIdea alertWithTarget:self Title:@"快去升级啊" message:text action_0:@"取消" action_1:@"确定" block_0:nil block_1:^{
            //跳转荣誉页面升级
            MyLevelViewController *levelVc = [[MyLevelViewController alloc] init];
            [weakself.navigationController pushViewController:levelVc animated:YES];
        }];
        return;
    }

    TvVideoDetailViewController *videoDetailViewController = [[TvVideoDetailViewController alloc] init];
    videoDetailViewController.model = model;
    [self.navigationController pushViewController:videoDetailViewController animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.tableView]) {
        
        [_player playerScrollIsSupportSmallWindowPlay:YES];
    }
}

#pragma mark ----------------缺省页代理

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return EmptyImage;
}


#pragma mark ----------------实例

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NaviBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NaviBar_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource= self;
        _tableView.backgroundColor  = BACKGROUNDCOLOR;
        _tableView.separatorColor = GRAYCOLOR;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[TvVideoTableViewCell class] forCellReuseIdentifier:@"TvVideoCell"];
        
        GOLFWeakObj(self);
        //下拉刷新
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakself loadDataWithRet:YES];
        }];
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakself loadDataWithRet:NO];
        }];
        
        _tableView.mj_footer.automaticallyHidden = YES;
    }
    return _tableView;
}



@end
