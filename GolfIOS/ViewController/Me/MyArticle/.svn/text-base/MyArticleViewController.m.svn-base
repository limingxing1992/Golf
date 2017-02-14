//
//  MyArticleViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/8.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "MyArticleViewController.h"

@interface MyArticleViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    DZNEmptyDataSetSource,
    DZNEmptyDataSetDelegate
>
/** 帖子列表*/
@property (nonatomic, strong) UITableView *articleTableView;
/** 数据源*/
@property (nonatomic, strong) NSMutableArray *data;
/** 当前页*/
@property (nonatomic, assign) NSInteger currentPage;


@end

@implementation MyArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"我的帖子";
    self.isAutoBack = NO;
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self.view addSubview:self.articleTableView];
    [self loadDataWithRet:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
    [ShareBusinessManager.userManager postMyArticleListWithParameters:@{@"currentPage":[NSNumber numberWithInteger:_currentPage],
                                                                        @"pageSize":PAGESIZE}
                                                              success:^(id responObject) {
                                                                  NSArray *data = responObject;
                                                                  if (ret) {
                                                                      [weakself.data removeAllObjects];
                                                                      [weakself.articleTableView.mj_header endRefreshing];
                                                                      [weakself.articleTableView.mj_footer setState:MJRefreshStateIdle];
                                                                  }else{
                                                                      if (data.count < PAGESIZE.integerValue ) {
                                                                          [weakself.articleTableView.mj_footer endRefreshingWithNoMoreData];
                                                                      }else{
                                                                          [weakself.articleTableView.mj_footer endRefreshing];
                                                                      }
                                                                  }
                                                                  [weakself.data addObjectsFromArray:responObject];
                                                                  [weakself.articleTableView reloadData];
                                                              }
                                                              failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                  [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                  if (ret) {
                                                                      [weakself.articleTableView.mj_header endRefreshing];
                                                                  }else{
                                                                      [weakself.articleTableView.mj_footer endRefreshing];
                                                                  }
                                                              }];
}


#pragma mark ----------------table代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"articleCell"];
    MyArticleItemModel *model = _data[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark ----------------左滑删除好友

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyArticleItemModel *model = _data[indexPath.row];
    [_data removeObject:model];
    [_articleTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
    //静默删除
    [ShareBusinessManager.userManager postMyArticleDeleteWithParameters:@{@"articleId":model.ID}
                                                                success:^(id responObject) {
                                                                    
                                                                }
                                                                failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                    [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                }];
}

/**
 *  修改Delete按钮文字为“删除”
 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark ----------------缺省页代理

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return EmptyImage;
}


#pragma mark ----------------实例

- (UITableView *)articleTableView{
    if (!_articleTableView) {
        _articleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NaviBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NaviBar_HEIGHT)];
        _articleTableView.delegate = self;
        _articleTableView.dataSource= self;
        _articleTableView.backgroundColor  = BACKGROUNDCOLOR;
        _articleTableView.separatorColor = GRAYCOLOR;
        _articleTableView.separatorInset = UIEdgeInsetsZero;
        _articleTableView.emptyDataSetSource = self;
        _articleTableView.emptyDataSetDelegate = self;
        _articleTableView.tableFooterView = [UIView new];
        [_articleTableView registerClass:[MyArticleTableViewCell class] forCellReuseIdentifier:@"articleCell"];
        
        GOLFWeakObj(self);
        //下拉刷新
        _articleTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakself loadDataWithRet:YES];
        }];
        
        _articleTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakself loadDataWithRet:NO];
        }];
        
        _articleTableView.mj_footer.automaticallyHidden = YES;
    }
    return _articleTableView;
}



@end
