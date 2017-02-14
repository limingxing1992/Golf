//
//  MyFavoriteViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/8.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "MyFavoriteViewController.h"

@interface MyFavoriteViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    DZNEmptyDataSetSource,
    DZNEmptyDataSetDelegate
>
/** 顶部分页*/
//@property (nonatomic, strong) UIView *topView;
/** segement*/
//@property (nonatomic, strong) UISegmentedControl *control;

/** 顶部切换条*/
@property (nonatomic, strong) MyFavoriteMenuView *topView;


/** 收藏列表*/
@property (nonatomic, strong) UITableView *placeTable;

/** 球场数据源*/
@property (nonatomic, strong) NSMutableArray *placeData;
/** 俱乐部数据源*/
@property (nonatomic, strong) NSMutableArray *clubData;

@property (nonatomic, assign) NSInteger currentSelectIndex;//当前收藏模式 0 == 球场 1==公告


@end

@implementation MyFavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"我的收藏";
    self.isAutoBack = NO;
    self.view.backgroundColor  = BACKGROUNDCOLOR;
    [self.view addSubview:self.topView];
    [self.view addSubview:self.placeTable];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    _placeTable.sd_layout
    .topSpaceToView(_topView, 10)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
}

- (void)initData{
    _placeData = [[NSMutableArray alloc] init];
    _clubData = [[NSMutableArray alloc] init];
}

- (void)loadData{
    GOLFWeakObj(self);
    [SVProgressHUD showWithStatus:@"努力加载中"];
    switch (_currentSelectIndex) {
        case 0:
        {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            NSString *longt = LongTi;
            NSString *lat = LatTi;
            if (longt.length &&  lat.length) {
                [dict setValue:longt forKey:@"longitude"];
                [dict setValue:lat forKey:@"latitude"];
            }
            [ShareBusinessManager.userManager postMyFavoritePlaceListWithParameters:dict success:^(id responObject) {
                [SVProgressHUD dismiss];
                [weakself.placeData removeAllObjects];
                [weakself.placeData addObjectsFromArray:responObject];
                [weakself.placeTable reloadData];
            } failure:^(NSInteger errCode, NSString *errorMsg) {
                [SVProgressHUD showErrorWithStatus:errorMsg];
            }];
        }
            break;
        case 1:
        {
            [ShareBusinessManager.userManager postMyFavoriteClubListWithParameters:nil success:^(id responObject) {
                [SVProgressHUD dismiss];
                [weakself.clubData removeAllObjects];
                [weakself.clubData addObjectsFromArray:responObject];
                [weakself.placeTable reloadData];

            } failure:^(NSInteger errCode, NSString *errorMsg) {
                [SVProgressHUD showErrorWithStatus:errorMsg];

            }];
        }
        default:
            break;
    }
}

#pragma mark ----------------界面逻辑

- (void)changeFavoriteStyle:(NSInteger)index{
    _currentSelectIndex = index;
    [self loadData];
}


#pragma mark ----------------table代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (_currentSelectIndex) {
        case 0:
        {
            return _placeData.count;
        }
            break;
        case 1:
        {
            return _clubData.count;
        }
        default:
        {
            return 0;
        }
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (_currentSelectIndex) {
        case 0:
        {
            AppointPlaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"placeCell"];
            cell.model = _placeData[indexPath.row];
            return cell;
        }
            break;
        case 1:
        {
            TSOClubTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"clubCell"];
            cell.model = _clubData[indexPath.row];
            return cell;
        }
        default:
        {
            return nil;
        }
            break;
    }

}
#pragma mark ----------------左滑删除好友

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *collectId;
    switch (_currentSelectIndex) {
        case 0:
        {//删除球场
            PlaceItemModel *model = _placeData[indexPath.row];
            collectId = model.collectId;
            [_placeData removeObjectAtIndex:indexPath.row];
        }
            break;
        case 1:
        {
            ClubArticle *model = _clubData[indexPath.row];
            collectId = model.collectId;
            [_clubData removeObjectAtIndex:indexPath.row];
        }
        default:
            break;
    }
    
    [tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationLeft];
    
    //静默删除
    [ShareBusinessManager.userManager postMyFavoriteDeleteWithParameters:@{@"collectId":collectId}
                                                                 success:^(id responObject) {
                                                                     
                                                                 } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                     
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



#pragma mark ----------------实例化


- (MyFavoriteMenuView *)topView{
    if (!_topView) {
        GOLFWeakObj(self);
        _topView = [[MyFavoriteMenuView alloc] initWithFrame:CGRectMake(0, NaviBar_HEIGHT, SCREEN_WIDTH, 41.5)];
        _topView.block = ^(NSInteger index){
            [weakself changeFavoriteStyle:index];
        };
    }
    return _topView;
}

//- (UISegmentedControl *)control{
//    if (!_control) {
//        _control = [[UISegmentedControl alloc] initWithItems:@[@"球场", @"俱乐部"]];
//        _control.tintColor = GLOBALCOLOR;
//        [_control addTarget:self action:@selector(changeFavoriteStyle:) forControlEvents:UIControlEventValueChanged];
//        [_control setSelectedSegmentIndex:0];
//    }
//    return _control;
//}

- (UITableView *)placeTable{
    if (!_placeTable) {
        _placeTable = [[UITableView alloc] init];
        _placeTable.separatorColor = GRAYCOLOR;
        _placeTable.separatorInset = UIEdgeInsetsZero;
        _placeTable.delegate = self;
        _placeTable.dataSource = self;
        _placeTable.emptyDataSetSource = self;
        _placeTable.emptyDataSetDelegate = self;
        _placeTable.tableFooterView = [UIView new];
        [_placeTable registerClass:[AppointPlaceTableViewCell class] forCellReuseIdentifier:@"placeCell"];
        [_placeTable registerClass:[TSOClubTableViewCell class] forCellReuseIdentifier:@"clubCell"];
    }
    return _placeTable;

}

@end
