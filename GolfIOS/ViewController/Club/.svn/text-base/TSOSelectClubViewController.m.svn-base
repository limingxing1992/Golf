//
//  TSOSelectClubViewController.m
//  GolfIOS
//
//  Created by yangbin on 16/11/9.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOSelectClubViewController.h"
#import "TSOSelectClubTableViewCell.h"
#import "YB_ToolBtn.h"
#import "UIImage+Image.h"
#import "Club.h"

@interface TSOSelectClubViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**底部视图*/
@property (nonatomic, strong) UIView *bottomView;
///**底部全选*/
//@property (nonatomic, strong) YB_ToolBtn *allBtn;
/**确定按钮*/
@property (nonatomic, strong) UIButton *makeSureBtn;
/**dataList*/
@property (nonatomic, strong) NSMutableArray *dataList;
/**page*/
@property (nonatomic, assign) NSInteger page;


@end

static NSString *const kTSOSelectClubTableViewCell = @"kTSOSelectClubTableViewCell";
static NSString *const kCreateGroupCell = @"kCreateGroupCell";

@implementation TSOSelectClubViewController

- (void)viewDidLoad {
    self.page = 1;
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupNav{
    [super setupNav];
    self.navTitle = @"选择俱乐部";
}

- (void)setupUI{
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
  
    [self.bottomView addSubview:self.makeSureBtn];
    
    self.makeSureBtn.sd_layout
    .topEqualToView(self.bottomView)
    .rightEqualToView(self.bottomView)
    .bottomEqualToView(self.bottomView)
    .leftEqualToView(self.bottomView);
    

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 请求数据

- (void)requestMyClub{
    if (self.page == 1) {
        [self.dataList removeAllObjects];
    }
    NSDictionary *parameters = @{@"currentPage":[NSString stringWithFormat:@"%zd",_page],
                                 @"pageSize":PAGESIZE.stringValue};
    
    [ShareBusinessManager.clubManager getMyAllClubListWithParameters:parameters success:^(id responObject) {
        NSArray *array = (NSArray *)responObject;
        if (array.count > 0) {
             
            [self.dataList addObjectsFromArray:array];
            self.page ++;
            [self.tableView reloadData];
        }
        if (array.count < PAGESIZE.integerValue) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        NSInteger cellCount = self.tableView.frame.size.height /44;
        if (array.count < cellCount +1) {
            self.tableView.mj_footer.hidden = YES;
        }else{
            self.tableView.mj_footer.hidden = NO;
            [_tableView.mj_footer setState:MJRefreshStateIdle];
        }
        
        
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataList.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Club *model;
    if (self.dataList.count > 0) {
        model = self.dataList[indexPath.row];
    }
    TSOSelectClubTableViewCell *selCell = [tableView dequeueReusableCellWithIdentifier:kTSOSelectClubTableViewCell];
    selCell.model = model;
    weak(self);
    selCell.callBack = ^{

        [weakSelf.dataList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Club *model = obj;
            if (idx == indexPath.row) {
                
            }else{
                model.isSelected = NO;
            }
        }];
       
        
        model.isSelected = !model.isSelected;
        
        [weakSelf.tableView reloadData];
    };
    
    
    return selCell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

#pragma mark - Action



- (void)selAllClub:(UIButton *)button{
    button.selected = !button.selected;
    for (Club *model in self.dataList) {
        model.isSelected = button.selected;
    }
    [self.tableView reloadData];
}

- (void)makeSure{
    
        
    NSMutableArray *selClubIDs = [[NSMutableArray alloc] init];
    for (Club *model in self.dataList) {
        if (model.isSelected) {
            [selClubIDs addObject:model.clubId.stringValue];
        }
    }
    
    if (selClubIDs.count > 0) {
        if ([self.delegate respondsToSelector:@selector(selectClubViewControllerSelectedClubs:)]) {
            [self.delegate selectClubViewControllerSelectedClubs:selClubIDs];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        [SVProgressHUD showErrorWithStatus:@"请选择俱乐部"];
        
    }
    
}

#pragma mark - Setter&Getter

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,SCREEN_HEIGHT  - TabBar_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[TSOSelectClubTableViewCell class] forCellReuseIdentifier:kTSOSelectClubTableViewCell];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCreateGroupCell];
        
        weak(self);
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf requestMyClub];
            
        }];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 1;
            [weakSelf requestMyClub];
            
            [weakSelf.tableView.mj_header endRefreshing];
            
        }];
    }
    return _tableView;
}

- (UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
        _bottomView.backgroundColor = WHITECOLOR;
    }
    return _bottomView;
}

//- (YB_ToolBtn *)allBtn{
//    if (_allBtn == nil) {
//        _allBtn = [YB_ToolBtn selectButton];
//        [_allBtn setTitle:@"    全选" forState:UIControlStateNormal];
//        [_allBtn addTarget:self action:@selector(selAllClub:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _allBtn;
//}



- (UIButton *)makeSureBtn{
    if (_makeSureBtn == nil) {
        _makeSureBtn = [[UIButton alloc] init];
        [_makeSureBtn setBackgroundImage:[UIImage imageWithColor:GLOBALCOLOR] forState:UIControlStateNormal];
        [_makeSureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_makeSureBtn addTarget:self action:@selector(makeSure) forControlEvents:UIControlEventTouchUpInside];
    }
    return _makeSureBtn;
}

//- (UITableViewCell *)setupCell:(UITableViewCell *)cell title:(NSString *)title image:(NSString *)imgStr{
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;//消除选中样式
//    cell.textLabel.font = FONT(12);//设置标题大小
//    cell.textLabel.textColor = SHENTEXTCOLOR;//设置标题颜色
//    cell.accessoryView = [[UIImageView alloc] initWithImage:IMAGE(@"classify8")];//设置指示图
//    cell.detailTextLabel.textColor = LIGHTTEXTCOLOR;//设置详请字体颜色
//    cell.detailTextLabel.font = FONT(12);//设置详情字体大小
//    cell.imageView.image = IMAGE(imgStr);
//    cell.textLabel.text = title;
//    cell.textLabel.textColor = SHENTEXTCOLOR;
//    return cell;
//}



- (NSMutableArray *)dataList{
    if (_dataList == nil) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}

@end
