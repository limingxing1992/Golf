//
//  MyAddFirendViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/18.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyAddFirendViewController.h"
#import "MyFriendAddSearchViewController.h"

#import <AddressBook/AddressBook.h>
@interface MyAddFirendViewController ()
<
    UITableViewDelegate,
    UISearchResultsUpdating,
    UITableViewDataSource
>
/** search*/
@property (nonatomic, strong) UISearchController *searchController;

/** 通讯录*/
@property (nonatomic, strong) UITableView *tableView;
/** 背景图*/
@property (nonatomic, strong) UIView *placeholderView;
/** 图标*/
@property (nonatomic, strong) UIImageView *placeIv;
/** 同步*/
@property (nonatomic, strong) UIButton *synchronizeBtn;
/** 用户通讯录数据*/
@property (nonatomic, strong) NSMutableArray *userPhoneData;


/** 数据*/
@property (nonatomic, strong) NSMutableArray *data;

/** 当前点击添加的手机号*/
@property (nonatomic, copy) NSString *cellPhoneNumber;


@end

@implementation MyAddFirendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"添加好友";
    self.isAutoBack = NO;
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self.view addSubview:self.tableView];
    self.searchController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = YES;
}

- (void)initData{
    _data = [[NSMutableArray alloc] init];
    _userPhoneData = [[NSMutableArray alloc] init];
}

#pragma mark ----------------界面逻辑

/** 判断是否已经获取过通讯录权限*/
- (void)letAccess{
    NSString *let = [GOLFUserDefault objectForKey:@"friendAccess"];
    
    _tableView.backgroundView.hidden = [let isEqualToString:@"12"]? YES: NO;//展示或者消失背景视图
    if (_tableView.backgroundView.isHidden) {
        //已经获取过了
        //直接获取通讯录权限
        [self loadPerson];
    }else{
        //没获取过
        //等待点击获取按钮获取
    }
}
/** 获取通讯录权限*/
- (void)loadPerson
{
    //存储权限保存
    [GOLFUserDefault setObject:@"12" forKey:@"friendAccess"];
    
    [SVProgressHUD showWithStatus:@"加载中"];
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error){
            
            CFErrorRef *error1 = NULL;
            ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error1);
            [self copyAddressBook:addressBook];
        });
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        CFErrorRef *error = NULL;
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
        [self copyAddressBook:addressBook];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            [SVProgressHUD showErrorWithStatus:@"没有获取通讯录权限"];
        });
    }

}
/** 读取通讯录数据*/
- (void )copyAddressBook:(ABAddressBookRef)addressBook
{
    [SVProgressHUD showWithStatus:@"匹配通讯录中"];
    CFIndex numberOfPeople = ABAddressBookGetPersonCount(addressBook);
    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    NSMutableArray *phoneData = [[NSMutableArray alloc] init];
    for ( int i = 0; i < numberOfPeople; i++){
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        ABRecordRef person = CFArrayGetValueAtIndex(people, i);
        
        NSString *firstName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));//名
        NSString *lastName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));//姓
        NSMutableString *name = [[NSMutableString alloc] init];
        if (lastName.length) {
            [name appendString:lastName];
        }
        if (firstName.length) {
            [name appendString:firstName];
        }
        [dict setValue:name forKey:@"name"];
        //读取电话多值
        NSMutableArray *phoneAry = [[NSMutableArray alloc] init];
        ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
        for (int k = 0; k<ABMultiValueGetCount(phone); k++)
        {
            NSString *phoneA;
            //获取該Label下的电话值
            phoneA = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phone, k);//手机
            NSArray *aryA = [phoneA componentsSeparatedByString:@"-"];
            phoneA = [aryA componentsJoinedByString:@""];
            
            //只有手机格式号码才能作为通讯录数据
            //同一个通讯录姓名下可能会出现多个可使用手机号
            if ([phoneA validateMobile]) {
                [phoneAry addObject:phoneA];
            }
        }
        
        //以第一个有效手机号默认为当前用户手机号
        [dict setValue:phoneAry.firstObject forKey:@"phone"];
        [dict setValue:@0 forKey:@"isMyFriend"];
        //存储当前用户所有有效手机号
        [dict setValue:phoneAry forKey:@"phoneAry"];
        [phoneData addObject:dict];
    }
    
    [_userPhoneData removeAllObjects];
    [_userPhoneData addObjectsFromArray:phoneData];
    
    
    //与我的好友数据匹配
    for (NSInteger i = 0; i < _userPhoneData.count; i++) {
        //遍历当前通讯录数据
        NSMutableDictionary *dict = _userPhoneData[i];
        //获取当前通讯录数据名下的手机所有号码
        NSArray *phoneAry = dict[@"phoneAry"];
        //遍历我的所有平台好友数据
        for (NSInteger l = 0; l < _myFriendListData.count; l++) {
            FriendUserModel *itemModel = _myFriendListData[l];
            for (NSInteger i = 0; i < phoneAry.count; i++) {
                NSString *phone = phoneAry[i];
                if ([phone isEqualToString:itemModel.userName]) {
                    //匹配到当前好友数据存在于我的通讯录
                    [dict setValue:@1 forKey:@"isMyFriend"];
                    [dict setValue:itemModel.headUrl forKey:@"headUrl"];
                    [dict setValue:itemModel.nickName forKey:@"nickName"];
                    [dict setValue:itemModel.userName forKey:@"phone"];
                }
            }
            if ([dict[@"isMyFriend"] isEqualToNumber:@1]) {
                break;
            }
        }
        [_userPhoneData replaceObjectAtIndex:i withObject:dict];
    }
    [self.tableView reloadData];
    //返回数据刷新界面
    [SVProgressHUD dismiss];
}


#pragma mark ----------------tableview代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _userPhoneData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyAddFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addFriendCell"];
    NSDictionary *dict = _userPhoneData[indexPath.row];
    cell.model = dict;
    GOLFWeakObj(self);
    cell.block = ^(id responObject){
        MyAddFriendSendViewController *sendVc = [[MyAddFriendSendViewController alloc] init];
        
        sendVc.userPhone = responObject[@"phone"];
        [weakself.navigationController pushViewController:sendVc animated:YES];
    };
    return cell;
}


#pragma mark ----------------搜索代理

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    MyFriendAddSearchViewController *resultVc = (MyFriendAddSearchViewController *)searchController.searchResultsController;
    [resultVc.dataArray removeAllObjects];
    NSString *text = searchController.searchBar.text;
    if ([text validateNumber]) {
        //如果是数字就搜手机号
        for (NSDictionary *dict in _userPhoneData) {
            NSString *phone = dict[@"phone"];
            if ([phone containsString:text]) {
                [resultVc.dataArray addObject:dict];
            }
        }
    }else{
        //输入非数字就搜索名字
        for (NSDictionary *dict in _userPhoneData) {
            NSString *name = dict[@"name"];
            if ([name containsString:text]) {
                [resultVc.dataArray addObject:dict];
            }
        }
    }
    
    [resultVc.tableView reloadData];

}

#pragma mark ----------------实例化

- (UISearchController *)searchController{
    if (!_searchController) {
        MyFriendAddSearchViewController *addVc = [[MyFriendAddSearchViewController alloc] init];
        GOLFWeakObj(self);
        addVc.block = ^(id responObject){
            MyAddFriendSendViewController *sendVc = [[MyAddFriendSendViewController alloc] init];
            sendVc.userPhone = responObject[@"phone"];
            [weakself.navigationController pushViewController:sendVc animated:YES];
 
        };
        
        _searchController = [[UISearchController alloc] initWithSearchResultsController:addVc];
        _searchController.view.backgroundColor = BACKGROUNDCOLOR;
        _searchController.searchResultsUpdater = self;
        _searchController.hidesNavigationBarDuringPresentation = YES;//
        self.definesPresentationContext = YES;//
        UISearchBar *bar = _searchController.searchBar;
        bar.barStyle = UIBarStyleDefault;
        bar.placeholder = @"搜索名称或手机号";
        UIImageView *view = [[[bar.subviews objectAtIndex:0] subviews] firstObject];
        view.layer.borderColor = BACKGROUNDCOLOR.CGColor;
        view.layer.borderWidth = 1;
        bar.translucent = YES;
        bar.barTintColor = BACKGROUNDCOLOR;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundView = self.placeholderView;
        [self letAccess];
        [_tableView registerClass:[MyAddFriendTableViewCell class] forCellReuseIdentifier:@"addFriendCell"];
    }
    return _tableView;

}

- (UIView *)placeholderView{
    if (!_placeholderView) {
        _placeholderView = [[UIView alloc] init];
        _placeholderView.backgroundColor = WHITECOLOR;
        [_placeholderView addSubview:self.placeIv];
        [_placeholderView addSubview:self.synchronizeBtn];
        
        _placeIv.sd_layout
        .topSpaceToView(_placeholderView, 0)
        .bottomSpaceToView(_placeholderView, 0)
        .leftSpaceToView(_placeholderView, 0)
        .rightSpaceToView(_placeholderView, 0);
        
        _synchronizeBtn.sd_layout
        .topSpaceToView(_placeholderView, SCREEN_HEIGHT / 2 + 50)
        .centerXEqualToView(_placeholderView)
        .widthIs(220)
        .heightIs(45);
        [_synchronizeBtn setSd_cornerRadius:@5];
    }
    return _placeholderView;
}

- (UIImageView *)placeIv{
    if (!_placeIv) {
        _placeIv = [[UIImageView alloc] init];
        _placeIv.image = IMAGE(@"empty");
    }
    return _placeIv;
}

- (UIButton *)synchronizeBtn{
    if (!_synchronizeBtn) {
        _synchronizeBtn = [[UIButton alloc] init];
        _synchronizeBtn.backgroundColor= GLOBALCOLOR;
        _synchronizeBtn.titleLabel.font = FONT(14);
        [_synchronizeBtn setTitle:@"同步通讯录" forState:UIControlStateNormal];
        [_synchronizeBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_synchronizeBtn addTarget:self action:@selector(loadPerson) forControlEvents:UIControlEventTouchUpInside];
    }
    return _synchronizeBtn;

}


@end
