//
//  PlaceSearchListViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/3.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "PlaceSearchListViewController.h"
#import "MallBussTopView.h"

@interface PlaceSearchListViewController ()
<
    MallBussTopViewDelegate,
    UITableViewDelegate,
    UITableViewDataSource,
    DZNEmptyDataSetSource,
    DZNEmptyDataSetDelegate
>

@property (nonatomic, strong) MallBussTopView *topView;

@property (nonatomic, strong) UITableView *historyTableView;//搜索历史

@property (nonatomic, strong) NSMutableArray *historyData;//搜索历史数据源
 
@end

@implementation PlaceSearchListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isAutoBack = NO;
    [self.view addSubview:self.topView];
    [self.view addSubview:self.historyTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [_historyData removeAllObjects];
    NSArray *hisData = [GOLFUserDefault objectForKey:@"historyPlaceSearch"];
    [_historyData addObjectsFromArray:hisData];
    [_historyTableView reloadData];
    [_topView.searchBar becomeFirstResponder];
}
/** 初始化数据*/
- (void)initData{
    _historyData = [NSMutableArray array];
}

#pragma mark ----------------tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _historyData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"history"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _historyData[indexPath.row];
    cell.textLabel.font = FONT(12);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 41.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (!_historyData.count) {
        return 0.001;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (!_historyData.count) {
        return 0.001;
    }
    
    return 50;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!_historyData.count) {
        return nil;
    }
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    headView.backgroundColor = WHITECOLOR;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = WHITECOLOR;
    [headView addSubview:lineView];
    UIImageView *historyIv = [[UIImageView alloc] init];
    historyIv.image = IMAGE(@"classify9");
    [headView addSubview:historyIv];
    historyIv.sd_layout
    .centerYEqualToView(headView)
    .leftSpaceToView(headView, 15)
    .heightIs(20)
    .widthEqualToHeight();
    
    
    UILabel *titleLb = [[UILabel alloc] init];
    titleLb.font = FONT(12);
    titleLb.textColor = LIGHTTEXTCOLOR;
    titleLb.text = @"搜索历史";
    [headView addSubview:titleLb];
    titleLb.sd_layout
    .centerYEqualToView(headView)
    .leftSpaceToView(historyIv, 3)
    .rightSpaceToView(headView, 15)
    .autoHeightRatio(0);
    
    
    return headView;
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (!_historyData.count) {
        return nil;
    }
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    footerView.backgroundColor = WHITECOLOR;
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundColor:WHITECOLOR];
    [btn setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
    [btn setTitle:@"清除搜索记录" forState:UIControlStateNormal];
    btn.titleLabel.font = FONT(14);
    btn.layer.borderColor = GLOBALCOLOR.CGColor;
    btn.layer.cornerRadius = 5;
    btn.layer.borderWidth = 0.5;
    [btn addTarget:self action:@selector(clearHistorySearchAction) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:btn];
    
    btn.sd_layout
    .topSpaceToView(footerView, 19)
    .centerXEqualToView(footerView)
    .heightIs(31);
    [btn setupAutoSizeWithHorizontalPadding:15 buttonHeight:31];
    
    
    return footerView;
    
}

#pragma mark ----------------清除和点击

- (void)clearHistorySearchAction{
    [GOLFUserDefault removeObjectForKey:@"historyPlaceSearch"];
    [_historyData removeAllObjects];
    [self.historyTableView reloadData];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //进入结果页面
    PlaceSearchResultViewController *resultVc = [[PlaceSearchResultViewController alloc] init];
    resultVc.keyWord = _historyData[indexPath.row];
    resultVc.isSelect = _isSelect;
    [self.navigationController pushViewController:resultVc animated:YES];
}

#pragma mark ----------------缺省页代理

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return EmptyImage;
}

#pragma mark ----------------MallBussTopDelegate

- (void)backToLast{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)searchWithText:(NSString *)text{
    [_topView.searchBar resignFirstResponder];
    BOOL flag = YES;
    for (NSString *str in _historyData) {
        if ([str isEqualToString:text]) {
            flag = NO;
        }
    }
    if (flag) {
        [_historyData addObject:text];
        [GOLFUserDefault setObject:_historyData forKey:@"historyPlaceSearch"];
    }
    
    _topView.searchBar.text = @"";
    
    //进入结果页面
    PlaceSearchResultViewController *resultVc = [[PlaceSearchResultViewController alloc] init];
    resultVc.keyWord = text;
    [self.navigationController pushViewController:resultVc animated:YES];

    
}
//取消。返回
- (void)enterPeopleHome{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ----------------实例化

- (UITableView *)historyTableView{
    if (_historyTableView == nil) {
        _historyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        _historyTableView.delegate = self;
        _historyTableView.backgroundColor = WHITECOLOR;
        _historyTableView.dataSource = self;
        _historyTableView.emptyDataSetDelegate = self;
        _historyTableView.emptyDataSetSource = self;
        _historyTableView.tableFooterView = [UIView new];
        _historyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_historyTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"history"];
    }
    return _historyTableView;
    
    
}

- (MallBussTopView *)topView{
    if (_topView == nil) {
        _topView = [[MallBussTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64) ret:YES];
        _topView.delegate = self;
    }
    return _topView;
    
    
}

@end
