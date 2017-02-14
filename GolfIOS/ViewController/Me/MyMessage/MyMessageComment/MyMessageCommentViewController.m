//
//  MyMessagecommentViewController.m
//  GolfIOS
//  Created by mac mini on 16/11/17.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyMessageCommentViewController.h"
#import "CommunityArticleModel.h"
#import "MyMessageMovementCell.h"

static NSString * MyMessageCommentCellid = @"MyMessageCommentCellid";
@interface MyMessageCommentViewController ()<
UITableViewDelegate,
UITableViewDataSource,
DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate
>

/** 列表*/
@property (nonatomic, strong) UITableView *tableView;
/** 数据页数*/
@property (nonatomic, assign) NSInteger page;
/**数据列表*/
@property (nonatomic, strong) NSMutableArray *dataList;


@end

@implementation MyMessageCommentViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"我的动态";
    self.isAutoBack = NO;
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, NaviBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NaviBar_HEIGHT);
    
    [self requestData];
    //通知主页清除我的动态消息数字
    [GOLFNotificationCenter postNotificationName:@"updateDynamicNum" object:nil userInfo:nil];
}


#pragma mark - 请求网络数据
-(void)requestData{
    
    if (self.page == 1) {
        [self.dataList removeAllObjects];
    }
    
    NSDictionary *parameter = @{@"currentPage":[NSString stringWithFormat:@"%zd",_page],
                                @"pageSize":PAGESIZE.stringValue};
    
    [ShareBusinessManager.userManager postMyMessageListWithParameters:parameter success:^(id responObject) {
        
        for (MyMessageItemModel *model in responObject) {
            [self.dataList addObject:model];
        }
        
        if (self.dataList.count > 0) {
            self.page ++;
            [self.tableView reloadData];
        }
        
        if (self.dataList.count < PAGESIZE.integerValue) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - tableView代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark - 左滑删除好友

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    MyMessageItemModel *itemModel = self.dataList[indexPath.section];
    [self.dataList removeObjectAtIndex:indexPath.section];
    [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
    
    if (!self.dataList.count) {

        [self.tableView reloadData];
    }

    //静默处理删除请求
    [ShareBusinessManager.userManager postMyMessageDeleteListWithParameters:@{@"dynamicId":itemModel.ID} success:^(id responObject) {
        NSLog(@"%@",responObject);
    } failure:^(NSInteger errCode, NSString *errorMsg) {
         [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
    
}

/** 修改Delete按钮文字为“删除” */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark - tableView的数据源方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    CGFloat height = [tableView cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:tableView];
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark - cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyMessageMovementCell *Cell = [tableView dequeueReusableCellWithIdentifier:MyMessageCommentCellid];
    
    if (self.dataList.count >0) {
         MyMessageItemModel *model = self.dataList[indexPath.section];
        Cell.MovementModel = model;
    }
    return Cell;
    
}

#pragma mark - 空白页代理
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return EmptyImage;
}

#pragma mark - 控件懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.separatorColor = GRAYCOLOR;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        /* STEP5:去掉TableView中的默认横线 */
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[MyMessageMovementCell class] forCellReuseIdentifier:MyMessageCommentCellid ];

        
        //添加上啦刷新和下拉加载
        weak(self);
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf requestData];
            
        }];
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 1;
            [weakSelf requestData];
            
            [weakSelf.tableView.mj_header endRefreshing];
        }];
        
    }
    return _tableView;
    
}
- (NSMutableArray *)dataList{
    if (_dataList == nil) {
        _dataList = [[NSMutableArray alloc] init];
        
    }
    return _dataList;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
