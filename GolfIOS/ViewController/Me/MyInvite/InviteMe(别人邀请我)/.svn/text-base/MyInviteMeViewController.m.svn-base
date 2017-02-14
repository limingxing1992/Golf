//
//  MyInviteMeViewController.m
//  GolfIOS
//
//  Created by yangbin on 16/12/13.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyInviteMeViewController.h"
#import "SDTimeLineCellModel.h"
#import "MyInviteCommentView.h"
#import "MyInviteMeTableViewCell.h"
#import "MyInviteViewController.h"





#define kMyInviteMeTableViewCellId @"MyInviteMeTableViewCell"
static CGFloat textFieldH = 40;
@interface MyInviteMeViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
MyInviteMeTableViewCellDelegate,
UITextFieldDelegate,
YB_SliderBtnViewDelegate
>

/**tableView*/
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, assign) BOOL isReplayingComment;
@property (nonatomic, strong) NSIndexPath *currentEditingIndexthPath;
@property (nonatomic, copy) NSString *commentToUser;
/**yb 当前评论的id*/
@property (nonatomic, strong) NSString *commentID;

/**page*/
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataArray;

/**滑动选择*/
@property (nonatomic, strong) YB_SliderBtnView *btnView;
/**容器*/
@property (nonatomic, strong) UIScrollView *contentScrollView;
/**我邀请的控制器*/
@property (nonatomic, strong) MyInviteViewController *subVC;
/**是否正在显示左边控制器*/
@property (nonatomic, assign) BOOL isShowingLeftVC;

/**右侧清空按钮*/
@property (nonatomic, strong) UIBarButtonItem *cleanBtnItem;

@end

@implementation MyInviteMeViewController
{
    CGFloat _lastScrollViewOffsetY;
    CGFloat _totalKeybordHeight;
}

- (void)dealloc{
    [_textField removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//MARK: - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"我的邀请";
//    self.rightStr_0 = @"清空";
    self.isAutoBack = NO;
    self.isShowingLeftVC = YES;
    self.subVC.isShowing = NO;
    self.page = 1;
    [self setupUI];
    [self setupTextField];
    [self setupNav];
}

- (void)setupNav{
    self.cleanBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"清空" style:UIBarButtonItemStylePlain target:self action:@selector(cleanList)];
    self.navigationItem.rightBarButtonItem = _cleanBtnItem;
    
     [_cleanBtnItem setTitleTextAttributes:@{NSFontAttributeName:FONT(14), NSForegroundColorAttributeName:GLOBALCOLOR} forState:UIControlStateNormal];
}

- (void)setupUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.btnView];
    [self.view addSubview:self.contentScrollView];
    [self.contentScrollView addSubview:self.tableView];
    
    self.contentScrollView.frame = CGRectMake(0, 64 + 45, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 45);
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, SCREEN_HEIGHT - 64 - 45);
    self.tableView.frame = self.contentScrollView.bounds;
    
    [self.contentScrollView addSubview:self.tableView];
    self.subVC.tableView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.contentScrollView.frame.size.height);

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardNotification:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
}

- (void)setupTextField
{
    _textField = [UITextField new];
    _textField.backgroundColor = WHITECOLOR;
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = self;
    _textField.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8].CGColor;
    _textField.layer.borderWidth = 1;
    
    //为textfield添加背景颜色 字体颜色的设置 还有block设置 , 在block中改变它的键盘样式 (当然背景颜色和字体颜色也可以直接在block中写)
    _textField.frame = CGRectMake(0, SCREEN_HEIGHT, self.view.width_sd, textFieldH);
    [[UIApplication sharedApplication].keyWindow addSubview:_textField];
//    [self.view addSubview:_textField];
    [_textField becomeFirstResponder];
    [_textField resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.textField endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textField endEditing:YES];
}

//MARK: - 请求数据
- (void)requestData{
    if (self.page == 1) {
        [self.dataArray removeAllObjects];
    }
    
    NSDictionary *parameter = @{@"currentPage":[NSString stringWithFormat:@"%zd",self.page],
                                @"pageSize":PAGESIZE};
    [ShareBusinessManager.appointmentFriendManager postAppointmentFriendInviteListWithParameters:parameter success:^(id responObject) {
        NSMutableArray *array = [SDTimeLineCellModel mj_objectArrayWithKeyValuesArray:responObject[@"data"]];
        if (array.count > 0) {
            [self.dataArray addObjectsFromArray:array];
//            [self.tableView reloadData];
            
            _page ++;
        }
        if (array.count < PAGESIZE.integerValue) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        NSInteger cellCount = self.tableView.frame.size.height / 70;
        if (self.dataArray.count < cellCount +1) {
            self.tableView.mj_footer.hidden = YES;
        }else{
            self.tableView.mj_footer.hidden = NO;
        }
        
        if (self.dataArray.count == 0) {
            
            UIImageView *placeHoderImageView = [[UIImageView alloc] initWithFrame:self.contentScrollView.bounds];
            placeHoderImageView.image = EmptyImage;
            self.tableView.tableFooterView = placeHoderImageView;
        }else{
            self.tableView.tableFooterView = [UIView new];
        }
        
        if (self.dataArray.count == 0) {
            self.cleanBtnItem.enabled = YES;
        }else{
            self.cleanBtnItem.enabled = NO;
        }
        
        
        [self.tableView reloadData];
        
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
        
        if (self.dataArray.count == 0) {
            UIImageView *placeHoderImageView = [[UIImageView alloc] initWithFrame:self.contentScrollView.bounds];
            placeHoderImageView.image = EmptyImage;
            self.tableView.tableFooterView = placeHoderImageView;
        }else{
            self.tableView.tableFooterView = [UIView new];
        }
        
    }];
    
}

//MARK: - 添加评论
//commentId	评论Id	number	与postId 二选一
//content	评论内容	string
//postId    帖子Id
- (void)addCommentWithDict:(NSDictionary *)parameter{
    
    NSLog(@"回复帖子：%@",parameter);
    [ShareBusinessManager.appointmentFriendManager postAppointmentFriendAddCommentWithParameters:parameter success:^(id responObject) {
        
        NSString *status = (NSString *)responObject;
        [SVProgressHUD showSuccessWithStatus:status];
        [self.tableView.mj_header beginRefreshing];//评论成功后重新请求评论数据
        
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
    
}

//MARK: - YB_SliderBtnViewDelegate

- (void)yb_SliderBtnView:(YB_SliderBtnView *)view buttonDidClicked:(UIButton *)button{
    [self.textField resignFirstResponder];
    if (button.tag == 0) {//推荐
        self.isShowingLeftVC = YES;
        self.subVC.isShowing = NO;
        [self.contentScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if (button.tag == 1){//已加入
        self.isShowingLeftVC = NO;
        self.subVC.isShowing = YES;
        
        [self addChildViewController:self.subVC];
        [self.contentScrollView addSubview:self.subVC.tableView];
        [self.contentScrollView setContentOffset:CGPointMake(SCREEN_WIDTH , 0) animated:YES];
    }
}




//MARK: - MyInviteMeTableViewCellDelegate


- (void)didClickcCommentButtonInCell:(UITableViewCell *)cell{
    [_textField becomeFirstResponder];
    _textField.placeholder = @"回复：帖子";
    _currentEditingIndexthPath = [self.tableView indexPathForCell:cell];
    [self adjustTableViewToFitKeyboard];
}

#pragma mark - UITextFieldDelegate




- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length) {
        [_textField resignFirstResponder];
        
        SDTimeLineCellModel *model = self.dataArray[_currentEditingIndexthPath.row];
        NSMutableArray *temp = [NSMutableArray new];
        [temp addObjectsFromArray:model.commentItemsArray];
        
        NSDictionary *dict;
        
        if (self.isReplayingComment) {
            //yb 评论其他评论
            
            dict = @{@"commentId":self.commentID,
                     @"content":textField.text};
            
            self.isReplayingComment = NO;
        } else {
            dict = @{@"content":textField.text,
                     @"articleId":model.articleId.stringValue};
        }
        [self addCommentWithDict:dict];//发送评论网络请求
        
        _textField.text = @"";
        _textField.placeholder = nil;
        
        return YES;
    }
    
    [textField endEditing:YES];
    return NO;
}



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.textField endEditing:YES];
}

#pragma mark - UITableViewDelegate




#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    return self.dataArray.count;
 
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyInviteMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMyInviteMeTableViewCellId];
    SDTimeLineCellModel *model;
    if (self.dataArray.count > 0) {
        model = self.dataArray[indexPath.row];
    }
    
    cell.indexPath = indexPath;
    __weak typeof(self) weakSelf = self;
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
            SDTimeLineCellModel *model = weakSelf.dataArray[indexPath.row];
            model.isOpening = !model.isOpening;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
        
        [cell setDidClickCommentLabelBlock:^(NSString *commentId,NSString *commentName, CGRect rectInWindow, NSIndexPath *indexPath,NSInteger commentRow) {
            
            //yb判断commentID 和 当前用户id是否相等
            if ([commentName isEqualToString:[UserModel sharedUserModel].nickName]) {
                
            }else{
                weakSelf.textField.placeholder = [NSString stringWithFormat:@"  回复：%@", commentName];
                weakSelf.currentEditingIndexthPath = indexPath;
                [weakSelf.textField becomeFirstResponder];
                weakSelf.isReplayingComment = YES;
                weakSelf.commentToUser = commentName;
                weakSelf.commentID = commentId;
                
                _currentEditingIndexthPath = [tableView indexPathForCell:cell];
//                [weakSelf adjustTableViewToFitKeyboardWithRect:rectInWindow];
                [weakSelf adjustTableViewToFitKeyboard];
            }
            
        }];
        
        cell.delegate = self;
    }
    
    
    //长按删除
    cell.pressBlock = ^(){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否删除当前邀请" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击取消");
            
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSDictionary *dict = @{@"inviteBallId":model.ID.stringValue};
            [ShareBusinessManager.appointmentFriendManager postAppointmentFriendInviteDeleteWithParameters:dict success:^(id responObject) {
                
                [SVProgressHUD showSuccessWithStatus:@"邀请已经删除"];
                [tableView.mj_header beginRefreshing];
            } failure:^(NSInteger errCode, NSString *errorMsg) {
                [SVProgressHUD showErrorWithStatus:errorMsg];
            }];
            
        }]];
        
        [weakSelf presentViewController:alert animated:YES completion:nil];
        
    };
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    ///////////////////////////////////////////////////////////////////////
    
    cell.model = model;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    id model;
    if (self.dataArray.count > 0) {
        model = self.dataArray[indexPath.row];
    }
    
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[MyInviteMeTableViewCell class] contentViewWidth:[self cellContentViewWith]];
}



- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

//MARK: - action
- (void)cleanList{
    if (_isShowingLeftVC) {//清空邀请我的 列表
        [SVProgressHUD showInfoWithStatus:@"正在清空邀请列表…"];
        [ShareBusinessManager.appointmentFriendManager postAppointmentFriendInviteClearWithParameterss:nil success:^(id responObject) {
            [SVProgressHUD showSuccessWithStatus:responObject];

            [self.tableView.mj_header beginRefreshing];
        } failure:^(NSInteger errCode, NSString *errorMsg) {
            [SVProgressHUD showSuccessWithStatus:errorMsg];
        }];
        
    }else{//清空我的邀请列表
        [SVProgressHUD showInfoWithStatus:@"正在清空我邀请的列表…"];
       [ShareBusinessManager.appointmentFriendManager postAppointmentFriendMyInviteClearWithParameters:nil success:^(id responObject) {
           [SVProgressHUD showSuccessWithStatus:responObject];
           [self.subVC.tableView.mj_header beginRefreshing];
       } failure:^(NSInteger errCode, NSString *errorMsg) {
           [SVProgressHUD showSuccessWithStatus:errorMsg];
       }];
    }
}

//MARK: - function
- (void)keyboardNotification:(NSNotification *)notification
{
    
    if (_isShowingLeftVC) {
        NSDictionary *dict = notification.userInfo;
        CGRect rect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
        
        CGRect textFieldRect = CGRectMake(0, rect.origin.y - textFieldH, rect.size.width, textFieldH);
        if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
            textFieldRect = rect;
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            _textField.frame = textFieldRect;
        }];
        
        CGFloat h = rect.size.height + textFieldH;
        if (_totalKeybordHeight != h) {
            _totalKeybordHeight = h;
            [self adjustTableViewToFitKeyboard];
        }
    }
    
}

- (void)adjustTableViewToFitKeyboard
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:_currentEditingIndexthPath];
    CGRect rect = [cell.superview convertRect:cell.frame toView:window];
    [self adjustTableViewToFitKeyboardWithRect:rect];
}

- (void)adjustTableViewToFitKeyboardWithRect:(CGRect)rect
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGFloat delta = CGRectGetMaxY(rect) - (window.bounds.size.height - _totalKeybordHeight);
    
    CGPoint offset = self.tableView.contentOffset;
    offset.y += delta;
    if (offset.y < 0) {
        offset.y = 0;
    }
    
    [self.tableView setContentOffset:offset animated:YES];
}


#pragma mark - Setter&Getter

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        [_tableView registerClass:[MyInviteMeTableViewCell class] forCellReuseIdentifier:kMyInviteMeTableViewCellId];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        weak(self);
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf requestData];
            
        }];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 1;
            [weakSelf requestData];
            
            [weakSelf.tableView.mj_header endRefreshing];
        }];
        
    }
    return _tableView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (YB_SliderBtnView *)btnView{
    if (_btnView == nil) {
        _btnView = [[YB_SliderBtnView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 45)];
        [_btnView setButtonTitleArray:@[@"邀请我的",@"我邀请的"]];
        _btnView.delegate = self;
    }
    return _btnView;
}

- (UIScrollView *)contentScrollView{
    if (_contentScrollView == nil) {
        _contentScrollView = [[UIScrollView alloc] init];
        _contentScrollView.backgroundColor = WHITECOLOR;
        _contentScrollView.scrollEnabled = NO;
        _contentScrollView.pagingEnabled = YES;
        
    }
    return _contentScrollView;
}

- (MyInviteViewController *)subVC{
    if (_subVC == nil) {
        _subVC = [[MyInviteViewController alloc] init];
    }
    return _subVC;
}

@end
