//
//  MyMessageSystemMsgViewController.m
//  GolfIOS
//
//  Created by mac mini on 16/11/17.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyMessageSystemMsgViewController.h"
#import "MyMessageSysMsgCell.h"

static NSString * MyMessageSysMsgCellid = @"MyMessageSysMsgCellid";
static CGFloat sectionHeight = 10;

@interface MyMessageSystemMsgViewController ()<
UITableViewDelegate,
UITableViewDataSource,
DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate
>
/** 列表*/
@property (nonatomic, strong) UITableView *tableView;

/**dataList*/
@property (nonatomic, strong) NSMutableArray *dataList;
/**page*/
@property (nonatomic, assign) NSInteger page;

@end

@implementation MyMessageSystemMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"系统消息";
    self.isAutoBack = NO;
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, NaviBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NaviBar_HEIGHT);
    [self loadData];
    
    //通知主页清除系统消息数字
    [GOLFNotificationCenter postNotificationName:@"updateSysMsgNum" object:nil userInfo:nil];
}

-(void)loadData{
    
    if (self.page == 1) {
        [self.dataList removeAllObjects];
    }
    
    
    //参数字段
    NSDictionary *Parameter = @{@"currentPage":[NSString stringWithFormat:@"%zd",_page],
                                       @"pageSize":PAGESIZE.stringValue};
    

    [ShareBusinessManager.userManager postMyMessageSystemListWithParameters:Parameter success:^(id responObject) {
        //遍历数据模型数组
        for (MyClubItemModel *model in responObject) {
            [self.dataList addObject:model];
        }
        //NSLog(@"----------四通消息----------%@",self.dataList);
        
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
    }];
}

#pragma mark - tableView数据源

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  sectionHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = [tableView cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:tableView];
    return height;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001;
    
}
#pragma mark - cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyMessageSysMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:MyMessageSysMsgCellid];
    cell.sysModel = self.dataList[indexPath.section];
    return cell;
    
}
#pragma mark - tableView代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark - 左滑删除好友

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyMessageSysModel *itemModel = self.dataList[indexPath.section];
    [self.dataList removeObjectAtIndex:indexPath.section];
    [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
    
    if (!self.dataList.count) {
        
        [self.tableView reloadData];
    }
    
    //静默处理删除请求
    [ShareBusinessManager.userManager postMyMessageSystemDeleteListWithParameters:@{@"sysMsgId":itemModel.ID} success:^(id responObject) {
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
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        /* STEP5:去掉TableView中的默认横线 */
        _tableView.tableFooterView = [UIView new];
        //不显示滚动指示器
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[MyMessageSysMsgCell class] forCellReuseIdentifier:MyMessageSysMsgCellid];
        
        weak(self);
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf loadData];
            
        }];
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 1;
            [weakSelf loadData];
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
