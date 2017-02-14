//
//  MyFriendAddGroupViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/21.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyFriendAddGroupViewController.h"
#import "MyFfriendGroupSearchViewController.h"

@interface MyFriendAddGroupViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    UISearchResultsUpdating
>


/** search*/
@property (nonatomic, strong) UISearchController *searchController;

/** 添加按钮*/
@property (nonatomic, strong) UIButton *addBtn;


/** 列表页*/
@property (nonatomic, strong) UITableView *tableView;

/** 数据源*/
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) NSMutableArray *titleData;

/** 选中添加好友*/
@property (nonatomic, strong) NSMutableArray *selectData;


@end

@implementation MyFriendAddGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"好友";
    self.isAutoBack = NO;
    [self.view addSubview:self.tableView];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.addBtn];
    _addBtn.enabled = NO;
    self.navigationItem.rightBarButtonItem = item;
    self.searchController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    [self loadData];
    [GOLFNotificationCenter addObserver:self selector:@selector(selectFriendFication:) name:@"selectFriend" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = YES;
}


/** 初始化数据*/
- (void)initData{
    _data = [[NSMutableArray alloc] init];
    _titleData = [[NSMutableArray alloc] init];
    _selectData = [[NSMutableArray alloc] init];
    
}

- (void)loadData{
    [SVProgressHUD showWithStatus:@"努力加载中"];
    GOLFWeakObj(self);
    [ShareBusinessManager.userManager postMyFriendListWithParameters:nil
                                                             success:^(id responObject) {
                                                                 [SVProgressHUD dismiss];
                                                                 [weakself sortNameWithAry:responObject];
                                                             }
                                                             failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                 [SVProgressHUD showErrorWithStatus:errorMsg];
                                                             }];
    
}
/** 数据处理好友排序*/
- (void)sortNameWithAry:(NSArray *)responObject{
    //第一步摘出没有昵称的用户放到#数组里
    NSMutableArray *ary = [[NSMutableArray alloc] init];
    NSMutableArray *ary_no = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < responObject.count; i++) {
        FriendUserModel *itemModel = responObject[i];
        if ([itemModel.nickName length]) {
            [ary addObject:itemModel];
        }else{
            [ary_no addObject:itemModel];
        }
    }
    //第二步对剩下用户进行排序
    NSMutableArray *data = [BMChineseSort sortObjectArray:ary Key:@"nickName"];
    NSMutableArray *titleData = [BMChineseSort IndexWithArray:ary Key:@"nickName"];
    if (ary_no.count) {
        [data addObject:ary_no];
        [titleData addObject:@"#"];
    }
    //第三步刷新列表
    [_data removeAllObjects];
    [_titleData removeAllObjects];
    [_data addObjectsFromArray:data];
    [_titleData addObjectsFromArray:titleData];
    //首先初始化模型状态
    for (NSArray *listData in _data) {
        for (FriendUserModel *model in listData) {
            model.isGroupItem = NO;
        }
    }
    //已选择好友无法再次选择
    for (FriendUserModel *itemModel in _selectedData) {
        for (NSArray *listData in _data) {
            for (FriendUserModel *model in listData) {
                if ([model.userId isEqualToString:itemModel.userId]) {
                    if (itemModel.isSelected) {
                        model.isSelected = YES;
                    }
                    model.isGroupItem = YES;
                }
            }
        }
    }
    

    [self.tableView reloadData];
}


#pragma mark ----------------界面逻辑
/** 点击添加*/
- (void)addAction{
    if (self.block) {
        self.block(self.selectData);
        [self.navigationController popViewControllerAnimated:YES];
    }
}


/** 通知改变数组*/
- (void)selectFriendFication:(NSNotification *)notification{
    
    NSDictionary *info = notification.userInfo;
    BOOL ret = [info[@"isSelect"] boolValue];
    FriendUserModel *model = info[@"model"];
    if (ret) {
        [self.selectData addObject:model];
    }else{
        [self.selectData removeObject:model];
    }
    
//    _addBtn.enabled = _selectData.count ? YES:NO;
    _addBtn.enabled = YES;
    
}


#pragma mark ----------------tableview代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _data.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_data[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 27;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = BACKGROUNDCOLOR;
    UILabel *lv = [[UILabel alloc] init];
    lv.font = FONT(10);
    lv.textColor = BLACKTEXTCOLOR;
    lv.text = _titleData[section];
    [view addSubview:lv];
    lv.sd_layout
    .centerYEqualToView(view)
    .leftSpaceToView(view, 15)
    .rightSpaceToView(view, 15)
    .autoHeightRatio(0);
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyAddGroupFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendCell"];
    FriendUserModel *itemModel = _data[indexPath.section][indexPath.row];
    cell.model = itemModel;
    return cell;


}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    return _titleData;
}

#pragma mark ----------------搜索代理

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *text = _searchController.searchBar.text;
    MyFfriendGroupSearchViewController *resultVc = (MyFfriendGroupSearchViewController *)searchController.searchResultsController;
    [resultVc.dataArray removeAllObjects];
    for (NSArray *listData in _data) {
        for (FriendUserModel *itemModel in listData) {
            if ([itemModel.nickName containsString:text]) {
                [resultVc.dataArray addObject:itemModel];
            }
        }
    }
    [resultVc.tableView reloadData];
    
//    for (NSDictionary *dict in _data) {
//        NSArray *values = dict[dict.allKeys.firstObject];
//        NSMutableDictionary *newDic = [[NSMutableDictionary alloc] init];
//        NSMutableArray *newAr = [[NSMutableArray alloc] init];
//        for (NSString *title in values) {
//            if ([title containsString:text]) {
//                [newAr addObject:title];
//            }
//        }
//        
//        if (newAr.count) {
//            [newDic setValue:newAr forKey:dict.allKeys.firstObject];
//            [resultVc.dataArray addObject:newDic];
//        }
//    }
//    
//    [resultVc.tableView reloadData];
}


#pragma mark ----------------实例

- (UISearchController *)searchController{
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:[MyFfriendGroupSearchViewController new]];
        _searchController.view.backgroundColor = BACKGROUNDCOLOR;
        _searchController.searchResultsUpdater = self;
        _searchController.hidesNavigationBarDuringPresentation = NO;//
        self.definesPresentationContext = YES;//
        UISearchBar *bar = self.searchController.searchBar;
        bar.barStyle = UIBarStyleDefault;
        
        bar.placeholder = @"搜索";
//        NSLog(@"%@", [[bar.subviews objectAtIndex:0] subviews]);
        UIImageView *view = [[[bar.subviews objectAtIndex:0] subviews] firstObject];
        view.layer.borderColor = BACKGROUNDCOLOR.CGColor;
        view.layer.borderWidth = 1;
        
        UITextField *tf = [[[bar.subviews objectAtIndex:0] subviews] lastObject];
        tf.layer.borderColor = GRAYCOLOR.CGColor;
        tf.layer.borderWidth = 0.5;
        
        bar.translucent = YES;
        bar.barTintColor = WHITECOLOR;
        bar.tintColor = GLOBALCOLOR;
        CGRect rect = bar.frame;
        rect.size.height = 45;
        bar.frame = rect;
        self.tableView.tableHeaderView = bar;
    }
    return _searchController;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH, SCREEN_HEIGHT )];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        _tableView.sectionIndexColor = LIGHTTEXTCOLOR;
        [_tableView registerClass:[MyAddGroupFriendTableViewCell class] forCellReuseIdentifier:@"friendCell"];
    }
    return _tableView;
}

- (UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        _addBtn.titleLabel.font = FONT(14);
        [_addBtn setTitle:@"添加" forState:UIControlStateNormal];
        [_addBtn setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
        [_addBtn setTitleColor:LIGHTTEXTCOLOR forState:UIControlStateDisabled];
        [_addBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
@end
