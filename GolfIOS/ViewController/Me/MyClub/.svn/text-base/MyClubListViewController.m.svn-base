//
//  myClubBaseViewController.m
//  GolfIOS
//
//  Created by mac mini on 16/11/14.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "MyClubListViewController.h"
#import "MyClubViewCell.h"
#import "STL_CommonIdea.h"
#import "MyClubDetailViewController.h"
#import "TSOClubHomePageViewController.h"

static NSString* Cellid = @"joinedViewCell";
@interface MyClubListViewController ()<
UITableViewDelegate,
UITableViewDataSource,
MyClubViewCellDelegate,
DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate
>
/**数据列表*/
@property (nonatomic, strong) UITableView *tableView;
/** 数据页数*/
@property (nonatomic, assign) NSInteger page;
/**数据列表*/
@property (nonatomic, strong) NSMutableArray *dataList;
@end

@implementation MyClubListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //自动滚动调整，默认为YES
    self.automaticallyAdjustsScrollViewInsets = NO;
    UILabel  *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 17)];
    titleLb.font = FONT(17);
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.textColor = BLACKTEXTCOLOR;
    [self.navigationItem setTitleView:titleLb];

    
    if (self.pageColumn == 0) {
        titleLb.text = @"已加入的俱乐部";;
    }else{
        titleLb.text  = @"已创建的俱乐部";
    }
    
    [self.view addSubview:self.tableView];
    
    [self requestData];

}

-(void)dealloc{
    NSLog(@"销毁了");
}


#pragma mark - 请求网络数据
-(void)requestData{
    
    if (self.page == 1) {
        [self.dataList removeAllObjects];
    }
    

    if (self.pageColumn == 0) {
        //参数字段
        NSDictionary *parameter = @{@"currentPage":[NSString stringWithFormat:@"%zd",_page],
                                    @"pageSize":PAGESIZE.stringValue};
        
        [ShareBusinessManager.userManager postMyClubJoinedListWithParameters:parameter success:^(id responObject) {
            //遍历数据模型数组
            for (MyClubItemModel *model in responObject) {
                [self.dataList addObject:model];
            }
            
            if (self.dataList.count > 0) {
                self.page ++;
            }
            
            if (self.dataList.count < PAGESIZE.integerValue) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
            
            [self.tableView reloadData];
            
        } failure:^(NSInteger errCode, NSString *errorMsg) {
            [SVProgressHUD showErrorWithStatus:errorMsg];
            [self.tableView.mj_footer endRefreshing];
        }];

    }else{
        //参数字段
        NSDictionary *parameter = @{@"currentPage":[NSString stringWithFormat:@"%zd",_page],
                                    @"pageSize":PAGESIZE.stringValue};
        
        [ShareBusinessManager.userManager postMyClubCreatedListWithParameters:parameter success:^(id responObject) {
            //遍历数据模型数组
            for (MyClubItemModel *model in responObject) {
                [self.dataList addObject:model];
            }
            
            [self.tableView reloadData];
            
             NSLog(@"----------内部列表已创建----------%@",self.dataList);
            
            if (self.dataList.count > 0) {
                self.page ++;
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
    
    
    
}

#pragma mark - 空白页代理
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return EmptyImage;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyClubItemModel *model;
    if (self.dataList.count >0) {
        model = self.dataList[indexPath.row];
    }
    MyClubViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cellid forIndexPath:indexPath];
    
    //设置cell的代理
    cell.delegate = self;
    cell.pageColumn = self.pageColumn;
    cell.model = model;
    return cell;
}

#pragma mark - cell的点击事件
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //取出对应cell的模型数据
    MyClubItemModel *model = self.dataList[indexPath.row];
    
    if (self.pageColumn == 0) {
        //跳转
        TSOClubHomePageViewController *vc = [[TSOClubHomePageViewController alloc] initWithClubID:model.clubId];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        MyClubDetailViewController *vc = [[MyClubDetailViewController alloc] init];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }

}

#pragma mark - 按钮点击的代理方法
-(void)MyClubViewCell:(MyClubViewCell *)cell btnDidClickWithClubId:(NSString *)clubId btnTag:(NSInteger)btnTag{
    
        NSLog(@"接收到按钮的点击%ld,%@",btnTag,clubId);
        
        NSString *message = (btnTag==0) ? @"您确认退出该俱乐部吗？" : @"您确认解散该俱乐部吗？";
        
        [STL_CommonIdea alertWithTarget:self Title:nil message:message action_0:@"确定" action_1:@"取消" block_0:^{
            
            if (btnTag == 0) {
                
                //退出俱乐部
                NSDictionary *Parameter = @{@"clubId": clubId};
                
                [ShareBusinessManager.userManager postMyClubExitWithParameters:Parameter success:^(id responObject) {
                    [SVProgressHUD showSuccessWithStatus:responObject];
                    [self.tableView.mj_header beginRefreshing];
                    [self.tableView reloadData];
                } failure:^(NSInteger errCode, NSString *errorMsg) {
                    [SVProgressHUD showSuccessWithStatus:@"退出失败"];
                }];
                
            }else{
                //解散俱乐部
                NSDictionary *Parameter = @{@"clubId": clubId};
                
                [ShareBusinessManager.userManager postMyClubDismissWithParameters:Parameter success:^(id responObject) {
                    [SVProgressHUD showSuccessWithStatus:responObject];
                    //更新首页俱乐部列表
                    [self.tableView.mj_header beginRefreshing];
                    [self.tableView reloadData];
                    [GOLFNotificationCenter postNotificationName:@"updateCreatedClubList" object:nil userInfo:nil];
                } failure:^(NSInteger errCode, NSString *errorMsg) {
                    [SVProgressHUD showSuccessWithStatus:@"解散失败"];
                }];
                
            }
            
        } block_1:^{
            [SVProgressHUD showSuccessWithStatus:@"取消操作"];
        }];
}

#pragma mark - 控件懒加载

- (NSMutableArray *)dataList{
    if (_dataList == nil) {
        _dataList = [[NSMutableArray alloc] init];
        
    }
    return _dataList;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, NaviBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        _tableView.backgroundColor = GRAYCOLOR;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        
        _tableView.rowHeight = 68;
        _tableView.separatorColor = GRAYCOLOR;
        _tableView.showsVerticalScrollIndicator = NO;
        //register
        [_tableView registerClass:[MyClubViewCell class] forCellReuseIdentifier:Cellid];
        
        self.page = 1;
        
        
        //添加上啦刷新和下拉加载
        weak(self);
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf requestData];
            
        }];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 1;
            [weakSelf requestData];
            
            [weakSelf.tableView.mj_header endRefreshing];
        }];
        
        _tableView.mj_footer.automaticallyHidden = YES;
    }
    return _tableView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
