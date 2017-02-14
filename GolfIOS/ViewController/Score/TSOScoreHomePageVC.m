//
//  TSOScoreHomePageVC.m
//  GolfIOS
//
//  Created by yangbin on 16/12/26.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TSOScoreHomePageVC.h"
#import "TSOScoreQRCodeVC.h"
#import "TSOScoreSelectHoleCell.h"
#import "TSOQRCodeCell.h"
#import "TSOScoreAddPlayerCell.h"
#import "UIImage+Image.h"
#import "TSOScoringViewController.h"
#import "ScoreUserModel.h"
#import "StandardHoleListModel.h"
#import "SeverStatus.h"
#import "ScoreInfo.h"
#import "ScoreUser.h"
#import "TSOPersonalScoreRecordViewController.h"
#import "TSOScoreSelectCourtVC.h"
@interface TSOScoreHomePageVC ()

<
UITableViewDelegate,
UITableViewDataSource
>
{
    NSString *_beforeField;
    NSString *_afterField;
    NSInteger _topNineHoleIndex;//前9杆的index
    NSInteger _bottomNineHoleIndex;//后9杆的index
    NSString *_courtName;//选中球场的名字
    NSString *_courtID; //球场id
    
}
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**出发*/
@property (nonatomic, strong) UIButton *goBtn;
/**组队信息*/
@property (nonatomic, strong) NSMutableArray *userList;
/**标准杆信息*/
@property (nonatomic, strong) StandardHoleListModel *standardHolesModel;

/**timer*/
@property (nonatomic, strong) NSTimer *timer;

@end
static NSString *const kTSOScoreSelectHoleCell = @"kTSOScoreSelectHoleCell";
static NSString *const kTSOQRCodeCell = @"kTSOQRCodeCell";
static NSString *const kTSOScoreAddPlayerCell = @"kTSOScoreAddPlayerCell";
@implementation TSOScoreHomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.goBtn];
    
    self.goBtn.sd_layout
    .bottomSpaceToView(self.view, 69)
    .widthIs(SCREEN_WIDTH * 0.9)
    .centerXEqualToView(self.view)
    .heightIs(40);
    
    self.tableView.sd_layout
    .topSpaceToView(self.view, 64)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomSpaceToView(self.goBtn, 20);
    
    _beforeField = @"A场";
    _afterField = @"B场";
    _courtName = @"请选择球场";
    _topNineHoleIndex = 0;
    _bottomNineHoleIndex = 1;

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestStandardHoleList];
    [self requestUserGroupList];
    [self.tableView reloadData];
    
    self.tabBarController.tabBar.hidden = NO;
    if (IsLogin) {
        weak(self);
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [weakSelf requestUserGroupList];
            NSLog(@"=====请求组队信息========");
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"未登录"];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.timer invalidate];
}

- (void)setupNav{
    [super setupNav];
    self.navTitle = @"计分";
    self.navigationItem.leftBarButtonItem = nil;
    UIBarButtonItem *scanBtnItem = [UIBarButtonItem itemWithImage:IMAGE(@"classify235") selImage:nil targer:self action:@selector(toScanQR)];
    self.navigationItem.rightBarButtonItem = scanBtnItem;
    
    UIBarButtonItem *recordBtnItem = [UIBarButtonItem itemWithImage:IMAGE(@"classify236") selImage:nil targer:self action:@selector(toRecordVC)];
    self.navigationItem.leftBarButtonItem = recordBtnItem;

}

//MARK: - 测试方法
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self requestUserGroupList];
//    [self requestStandardHoleList];
//}

//MARK: - 网络请求
//请求加入这场比赛的用户
- (void)requestUserGroupList{
    [ShareBusinessManager.scoreManager getGroupListWithParameters:nil success:^(id responObject) {
        
        ScoreUserModel *model = (ScoreUserModel *)responObject;
        if (model.errorCode.integerValue == 1) {
            self.userList = [model.data mutableCopy];
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:model.errorMsg];
        }
        
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}

//请求当前球场的标准杆数
- (void)requestStandardHoleList{
    [ShareBusinessManager.scoreManager getStandatdHoleListWithParameters:nil success:^(id responObject) {
        StandardHoleListModel *model = (StandardHoleListModel *)responObject;
        if (model.errorCode.integerValue == 1) {
            self.standardHolesModel = model;
        }else{
            [SVProgressHUD showErrorWithStatus:model.errorMsg];
        }
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}
//请求比赛开始
- (void)requestBeginGame{
//    afterField	后9洞场次名称半场	string
//    ballplaceId	球场id	number
//    beforeField	前9洞场次名称	string
//    joingUserIdList	加入用户id	string	多个,分隔
    
    //获取joinUserIDlist
    
    if (IsLogin) {
        
        [SVProgressHUD showWithStatus:@"开始比赛中"];
        NSMutableArray *userIds = [[NSMutableArray alloc] init];
        for (ScoreUser *user in self.userList) {
            [userIds addObject:user.userId];
        }
        NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
        NSString *joinUserIdList = [[userIds componentsJoinedByString:@","] copy];
        
        if (_afterField) {
            [parameter setObject:_afterField forKey:@"afterField"];
        }
        if (_beforeField) {
            [parameter setObject:_beforeField forKey:@"beforeField"];
        }
        if (_courtID) {
            [parameter setObject:_courtID forKey:@"ballplaceId"];
        }
        if (joinUserIdList) {
            [parameter setObject:joinUserIdList forKey:@"joingUserIdList"];
        }
        
        NSLog(@"开始比赛参数%@",parameter);
        [ShareBusinessManager.scoreManager beginScoreWithParameters:parameter success:^(id responObject) {
            ScoreInfo *model = (ScoreInfo *)responObject;
            if (model.errorCode.integerValue == 1) {
                [SVProgressHUD dismiss];
                [self beginGameWithScoreInfo:model];
            }else{
                [SVProgressHUD showErrorWithStatus:model.errorMsg];
            }
        } failure:^(NSInteger errCode, NSString *errorMsg) {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }];

    }else{
        [SVProgressHUD showWithStatus:@"未登录"];
    }
    
}

//MARK: - Action

- (void)beginGameWithScoreInfo:(ScoreInfo *)info{
    GroupInfo *groupInfo = [[GroupInfo alloc] init];
    groupInfo.beforeField = _beforeField;
    groupInfo.afterField = _afterField;
    groupInfo.ballPlaceName = @"test";
    groupInfo.createTime = @"testCreateTime";
    info.data.groupInfo = groupInfo;
    
    TSOScoringViewController *scoringVC =[[TSOScoringViewController alloc] initWithScoreInfo:info];
    scoringVC.hidesBottomBarWhenPushed = YES;
 
    [self.navigationController pushViewController:scoringVC animated:YES];
    
}

- (void)selectHole:(UISegmentedControl *)segmentControl{
    NSLog(@"%zd",segmentControl.selectedSegmentIndex);
    if (segmentControl.tag == 1) {//前9场
        if (segmentControl.selectedSegmentIndex == 0) {
            _beforeField = @"A场";
        }else{
            _beforeField = @"B场";
        }
        _topNineHoleIndex = segmentControl.selectedSegmentIndex;
    }else{//后9场
        if (segmentControl.selectedSegmentIndex == 0) {
            _afterField = @"A场";
        }else{
            _afterField = @"B场";
        }
        _bottomNineHoleIndex = segmentControl.selectedSegmentIndex;
    }
}

//跳转历史比赛记录
- (void)toRecordVC{
    TSOPersonalScoreRecordViewController *recordVC = [[TSOPersonalScoreRecordViewController alloc] init];
    recordVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:recordVC animated:YES];
}

//跳转扫描二维码页面
- (void)toScanQR{
    TSOScoreQRCodeVC *qrCodeVC = [[TSOScoreQRCodeVC alloc] init];
    qrCodeVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:qrCodeVC animated:YES];
    
}

//MARK: - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        //跳转球场选择页面
        TSOScoreSelectCourtVC *selectCourtVC = [[TSOScoreSelectCourtVC alloc] init];
        selectCourtVC.hidesBottomBarWhenPushed = YES;
        selectCourtVC.selectCourtBlock = ^(id model){
            PlaceItemModel *courtModel = (PlaceItemModel *)model;
            _courtName = courtModel.name;
            _courtID = courtModel.ID.stringValue;
            
        };
        [self.navigationController pushViewController:selectCourtVC animated:YES];
    }
}
//主动添加队友
- (void)requestAddFriendWith:(NSArray *)friendsList{
        NSString *friends = [friendsList componentsJoinedByString:@","];
    NSDictionary *dict = @{@"friendUserIds":friends};
    
    [SVProgressHUD showWithStatus:@"正在添加队友"];
    [ShareBusinessManager.scoreManager addFriendsWithParameters:dict success:^(id responObject) {
        ScoreUserModel *model = (ScoreUserModel *)responObject;
        if (model.errorCode.integerValue == 1) {
            [self.userList removeAllObjects];
            self.userList = [model.data mutableCopy];
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        }else{
            [SVProgressHUD showErrorWithStatus:model.errorMsg];
        }
        
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}

//MARK: - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [UITableViewCell new];
        cell.accessoryView = [[UIImageView alloc] initWithImage:IMAGE(@"classify8")];//设置指示图
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = _courtName;
        cell.textLabel.font = FONT(14);
        cell.textLabel.textColor = BLACKTEXTCOLOR;
        return cell;
    }
    
    if (indexPath.section == 1) {
        TSOScoreSelectHoleCell *selCell = [tableView dequeueReusableCellWithIdentifier:kTSOScoreSelectHoleCell];

        if (indexPath.row == 0) {
            selCell.holeLabel.text = @"前9场";
            selCell.selHole.tag = 1;
            selCell.selHole.selectedSegmentIndex = _topNineHoleIndex;
            _beforeField = @"A场";
        }else{
            selCell.holeLabel.text = @"后9场";
            selCell.selHole.tag = 2;
            selCell.selHole.selectedSegmentIndex = _bottomNineHoleIndex;
            _afterField = @"B场";
        }
        
        [selCell.selHole addTarget:self action:@selector(selectHole:) forControlEvents:UIControlEventValueChanged];
        return selCell;
    }
    
    if (indexPath.section == 2 && indexPath.row == 0){
        TSOScoreAddPlayerCell *addPlayerCell = [tableView dequeueReusableCellWithIdentifier:kTSOScoreAddPlayerCell];
        addPlayerCell.players = self.userList;
        addPlayerCell.addPlayer = ^(){
            MyFriendAddGroupViewController *addVc = [[MyFriendAddGroupViewController alloc] init];
            
            addVc.block = ^(id responObject){
                
                NSArray *array = (NSArray *)responObject;
                NSMutableArray *friendList = [[NSMutableArray alloc] init];
                for (FriendUserModel *model in array) {
                    
                    [friendList addObject:model.userId];
                }
                [self requestAddFriendWith:friendList];
                
            };
            [self.navigationController pushViewController:addVc animated:YES];
        };
        addPlayerCell.playBtnDidClick = ^(UIButton *button){
            weak(self);
            [_userList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                ScoreUser *user = (ScoreUser *)obj;
                if ([user.userId isEqualToString:[UserModel sharedUserModel].ID]) {
    
                }else{
                    
                    [STL_CommonIdea alertWithTarget:weakSelf Title:@"是否移出队友" message:@""  action_0:@"否" action_1:@"是" block_0:^{
 
                    } block_1:^{
                        [ShareBusinessManager.scoreManager removeUserWithParameters:@{@"joinUserId":user.userId} success:^(id responObject) {
                            SeverStatus *model = (SeverStatus *)responObject;
                            if (model.errorCode.integerValue == 1) {
                                [SVProgressHUD showSuccessWithStatus:@"已退出"];
                            }else{
                                [SVProgressHUD showErrorWithStatus:model.errorMsg];
                            }
                        } failure:^(NSInteger errCode, NSString *errorMsg) {
                            [SVProgressHUD showErrorWithStatus:errorMsg];
                        }];
                        
                    }];
                    
                }
                
            }];
            
            
        };
        return addPlayerCell;
    }
    
    if (indexPath.section == 2 && indexPath.row == 1) {
        TSOQRCodeCell *qrCodeCell = [tableView dequeueReusableCellWithIdentifier:kTSOQRCodeCell];
        [qrCodeCell refresh];
        return qrCodeCell;
    }

    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2 && indexPath.row == 1){//二维码
        if (SCREEN_HEIGHT == 568) {
            return 127;
        }
        return 226.5 * KHeight_Scale ;
    }else if (indexPath.section == 2 && indexPath.row == 0){//添加好友
        return 85;
    }else{
        return 44;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

//MARK: - Getter&Setter
- (UITableView *)tableView{
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] init];
//        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, (SCREEN_HEIGHT  - 80) * KHeight_Scale) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        [_tableView registerClass:[TSOScoreSelectHoleCell class] forCellReuseIdentifier:kTSOScoreSelectHoleCell];
        [_tableView registerClass:[TSOQRCodeCell class] forCellReuseIdentifier:kTSOQRCodeCell];
        [_tableView registerClass:[TSOScoreAddPlayerCell class] forCellReuseIdentifier:kTSOScoreAddPlayerCell];
    }
    return _tableView;
}

- (UIButton *)goBtn{
    if (_goBtn == nil) {
        
        _goBtn = [[UIButton alloc] init];
//        _goBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, CGRectGetMaxY(self.view.frame) - 49 - 40 - 20, SCREEN_WIDTH * 0.9, 40)];
        [_goBtn setBackgroundImage:[UIImage imageWithColor:GLOBALCOLOR] forState:UIControlStateNormal];
        [_goBtn setTitle:@"出发" forState:UIControlStateNormal];
        [_goBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_goBtn addTarget:self action:@selector(requestBeginGame) forControlEvents:UIControlEventTouchUpInside];
        _goBtn.layer.cornerRadius = 3;
        _goBtn.layer.masksToBounds = YES;
    }
    return _goBtn;
}

- (NSMutableArray *)userList{
    if (_userList == nil) {
        _userList = [[NSMutableArray alloc] init];
    }
    return _userList;
}

@end
