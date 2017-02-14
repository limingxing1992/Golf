//
//  TSOClubNoticeDetailViewController.m
//  GolfIOS
//
//  Created by yangbin on 16/11/9.
//  Copyright © 2016年 zzz. All rights reserved.
//公告详情

#import "TSOClubNoticeDetailViewController.h"
#import "TSOClubInfoView.h"
#import "TSOTopicCommentCell.h"
#import <WebKit/WebKit.h>
#import "TSOClubHomePageViewController.h"
#import "ClubArticleDetailModel.h"
#import "ClubArticle.h"
#import "YB_UITextField.h"
#import "CommunityArticleCommentModel.h"
#import "ClubArticleCommentModel.h"
#import "SDTimeLineCellModel.h"
#import "TSOClubArticleDetailCell.h"

@interface TSOClubNoticeDetailViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
TSOCommentInputViewDelegate
>

{
    CGFloat _lastScrollViewOffsetY;
    CGFloat _totalKeybordHeight;
}


/**俱乐部信息info*/
@property (nonatomic, strong) TSOClubInfoView *clubView;
/**公告webView*/
@property (nonatomic, strong) UIView *articleDetailView;
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**最新评论*/
@property (nonatomic, strong) UIView *commentView;
/**帖子或公告ID*/
@property (nonatomic, strong) NSString *articleId;

/**请求到的俱乐部模型*/
@property (nonatomic, strong) ClubArticleDetailModel *clubModel;

/**page*/
@property (nonatomic, assign) NSInteger page;
/**dataList*/
@property (nonatomic, strong) NSMutableArray *dataList;
/**底部回复*/
@property (nonatomic, strong) TSOCommentInputView *inputView;
/**当前正在编辑的cell*/
@property (nonatomic, strong) NSIndexPath *currentEditingIndexthPath;

@property (nonatomic, assign) BOOL isReplayingComment;
/**是否直接回复评论 或者是回复 评论的评论*/
@property (nonatomic, assign) BOOL isDirectReComment;
/**第几条评论的评论*/
@property (nonatomic, assign) NSInteger commentRow;
/**收藏*/
@property (nonatomic, strong) UIButton *likeBtn;
@end

static NSString *const kTSOTopicCommentCell = @"kTSOTopicCommentCell";
static NSString *const kTSOClubArticleDetailCell = @"kTSOClubArticleDetailCell";
static CGFloat textFieldH = 50;
@implementation TSOClubNoticeDetailViewController

- (void)dealloc{
   
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.page = 1;

    
    [self.view addSubview:self.clubView];
    
    [self.clubView nameLabelAddTarget:self action:@selector(toClubHomePage)];
    [self.clubView iconImageAddTarget:self action:@selector(toClubHomePage)];
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 152, SCREEN_WIDTH, SCREEN_HEIGHT - 152);
    [self.view addSubview:self.inputView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardNotification:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
}

- (void)setupNav{
    [super setupNav];
    
    self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.likeBtn setBackgroundImage:[UIImage imageNamed:@"classify47"] forState:UIControlStateNormal];
    [self.likeBtn setBackgroundImage:[UIImage imageNamed:@"classify46"] forState:UIControlStateSelected];
    UIBarButtonItem *likeBtnItem = [[UIBarButtonItem alloc] initWithCustomView:self.likeBtn];
    [self.likeBtn sizeToFit];
    [self.likeBtn addTarget:self action:@selector(addLike:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = likeBtnItem;
    
    UIBarButtonItem *reportBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"classify86"] style:UIBarButtonItemStylePlain target:self action:@selector(reportAction)];
    reportBtn.tintColor = GLOBALCOLOR;
    
    self.navigationItem.rightBarButtonItems = @[reportBtn,likeBtnItem];
    
    
    
    
    
}

- (instancetype)initWithArticleID:(NSString *)ID{
    if (self = [super init]) {
        self.articleId = ID;
    }
    return self;
}


- (instancetype)initWithDisableArticleID:(NSString *)ID{
    if (self = [super init]) {
        self.articleId = ID;
        self.clubView.userInteractionEnabled = NO;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestClubArticleDetail];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 网络请求
//帖子或公告详情
- (void)requestClubArticleDetail{
    NSDictionary *parameters;
    if (IsLogin) {
        parameters = @{@"articleId":self.articleId,
                       @"userId":[UserModel sharedUserModel].ID};
    }else{
        parameters = @{@"articleId":self.articleId};
    }
    NSLog(@"papapap%@",parameters);
    [ShareBusinessManager.clubManager getCubArticleDetailWithParameters:parameters Success:^(id responObject) {
        ClubArticleDetailModel *model = (ClubArticleDetailModel *)responObject;
        if (model.errorCode.integerValue == 1) {
            self.clubModel = model;
            [self.tableView reloadData];
        }
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        
    }];
    
    
}
//帖子或公告的最新评论
- (void)requestArticleComment{
    
    if (self.page == 1) {
        [self.dataList removeAllObjects];
    }
    
    NSDictionary *parameters = @{@"currentPage":[NSString stringWithFormat:@"%zd",_page],
                                 @"pageSize":PAGESIZE.stringValue,
                                 @"articleId":self.articleId};
    
    [ShareBusinessManager.clubManager getClubArticleCommentListWithParameters:parameters success:^(id responObject) {
        ClubArticleCommentModel *model = (ClubArticleCommentModel *)responObject;
        
        if (model.errorCode.integerValue == 1) {
            
            if (model.data.count > 0) {
                
                [self.dataList addObjectsFromArray:model.data];
                self.page ++;
                [self.tableView reloadData];
            }
            if (model.data.count < PAGESIZE.integerValue) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
            
            //test 因为webView目前高度无法计算 暂时估计可以显示3行评论
            NSInteger cellCount = 3;
            if (self.dataList.count < cellCount) {
                self.tableView.mj_footer.hidden = YES;
            }else{
                self.tableView.mj_footer.hidden = NO;
                [_tableView.mj_footer setState:MJRefreshStateIdle];
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:model.errorMsg];
        }
        
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
    
}

- (void)addClubArticleComment{
    
    if (IsLogin) {
        NSDictionary *parameter;
        if (_isReplayingComment) {
            
            ClubArticleComment *model = self.dataList[_currentEditingIndexthPath.row];
            if (_isDirectReComment) {
                NSLog(@"=====%zd",_currentEditingIndexthPath);
                parameter = @{@"commentId":model.ID.stringValue,
                              @"content":self.inputView.inputTF.text};
            }else{
                
                SDTimeLineCellCommentItemModel *commentItem = model.commentItemsArray[self.commentRow];
                parameter = @{@"commentId":commentItem.ID.stringValue,
                              @"content":self.inputView.inputTF.text};
            }
            
        }else{
            parameter = @{@"articleId":self.clubModel.data.ID.stringValue,
                          @"content":self.inputView.text};
        }
        
        NSLog(@"====parameter==%@",parameter);
        [ShareBusinessManager.clubManager addClubArticleCommentWithParameters:parameter success:^(id responObject) {
            
            self.inputView.inputTF.text = nil;
            [self.view endEditing:YES];
            [self.tableView.mj_header beginRefreshing];
            [SVProgressHUD showSuccessWithStatus:@"回复成功"];
            
        } failure:^(NSInteger errCode, NSString *errorMsg) {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }];
    }else{
        [self presentViewController:LoginNavi animated:YES completion:nil];
    }
    
    
}


//俱乐部帖子举报
- (void)reportArticleWithString:(NSString *)string{
    NSString *type;
    if ([string isEqualToString:@"政治违规"]) {
        type = @"1";
    }else if ([string isEqualToString:@"不健康图文"]) {
        type = @"2";
    }else if ([string isEqualToString:@"广告"]) {
        type = @"3";
    }else if ([string isEqualToString:@"其他"]) {
        type = @"4";
    }
    NSDictionary *parameter = @{@"postType":@"20",//俱乐部帖子
                                @"postId":self.articleId,
                                @"reasonType":type};
    [ShareBusinessManager.userManager postReportWithParameters:parameter success:^(id responObject) {
        [SVProgressHUD showSuccessWithStatus:@"举报已受理"];
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showSuccessWithStatus:errorMsg];
    }];
}

#pragma mark - Action

//举报
//FIXME: 只有UI 需要添加举报接口
- (void)reportAction{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"举报" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"政治违规" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self reportArticleWithString:@"政治违规"];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"不健康图文" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self reportArticleWithString:@"不健康图文"];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"广告" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self reportArticleWithString:@"广告"];
    }];
    
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"其他" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self reportArticleWithString:@"其他"];
    }];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    [alertVC addAction:action3];
    [alertVC addAction:action4];
    [alertVC addAction:actionCancel];
    
    [self presentViewController:alertVC animated:YES completion:nil];
    
}

//添加搜藏
- (void)addLike:(UIButton *)button{
    if (IsLogin) {
        NSDictionary *parameters = @{@"collectType":@"20",
                                     @"linkId":_clubModel.data.ID.stringValue};
        [ShareBusinessManager.userManager postMyFavoriteAddWithParameters:parameters success:^(id responObject) {
            button.selected = !button.selected;
            [SVProgressHUD showSuccessWithStatus:responObject];
        } failure:^(NSInteger errCode, NSString *errorMsg) {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }];
    }else{
        [STL_CommonIdea alertWithTarget:self Title:@"未登录"
                                message:@"请登录后刷新"
                               action_0:nil
                               action_1:@"知道了"
                                block_0:^{
                                    
        } block_1:^{
            
        }];
    }
    
}


- (void)addFocuse:(UIButton *)button{
    
}

//MARK: - TSOCommentInputViewDelegate

- (void)commentInputViewCommentButtonDidClick{

    [self addClubArticleComment];
    self.isDirectReComment = NO;
    
}

- (BOOL)commentInputViewShouldReturn:(TSOCommentInputView *)inputView{
    
    
    [self addClubArticleComment];
    self.isDirectReComment = NO;
    [inputView endEditing:YES];
    return YES;
}

- (void)commentInputViewBeginEditing{
//    _isReplayingComment = NO;
}

//MARK: - scrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.inputView endEditing:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return self.dataList.count;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [UIView new];
    }else{
        return self.commentView;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClubArticleComment *model;
    if (self.dataList.count > 0) {
        model = self.dataList[indexPath.row];
    }
    
    if (indexPath.section == 0) {
        TSOClubArticleDetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:kTSOClubArticleDetailCell];
        detailCell.model = self.clubModel.data;
        
        return detailCell;
//        return [UITableViewCell new];
    }
    
    TSOTopicCommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:kTSOTopicCommentCell];
    commentCell.indexPath = indexPath;
    weak(self);
    [commentCell setDidClickCommentLabelBlock:^(NSString *commentId,NSString *commentName, CGRect rectInWindow, NSIndexPath *indexPath,NSInteger commentRow) {
        
        //yb判断commentID 和 当前用户id是否相等
        if ([commentName isEqualToString:[UserModel sharedUserModel].nickName]) {
            
        }else{
            weakSelf.inputView.inputTF.placeholder = [NSString stringWithFormat:@"  回复：%@", commentName];
            weakSelf.currentEditingIndexthPath = indexPath;
            weakSelf.commentRow = commentRow;
            [weakSelf.inputView.inputTF becomeFirstResponder];
            weakSelf.isReplayingComment = YES;
            weakSelf.isDirectReComment = NO;
            [weakSelf adjustTableViewToFitKeyboard];
        }
        
    }];
    
    [commentCell setDidClickContentLabelBlock:^{
        weakSelf.isDirectReComment = YES;
        weakSelf.isReplayingComment = YES;
       
        weakSelf.currentEditingIndexthPath = indexPath;
        weakSelf.inputView.inputTF.placeholder = [NSString stringWithFormat:@"  回复："];
        
        [weakSelf.inputView.inputTF becomeFirstResponder];
    }];
    commentCell.model = model;
    return commentCell;
}

//MARK: - function

- (void)keyboardNotification:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    CGRect rect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    CGRect textFieldRect = CGRectMake(0, rect.origin.y - textFieldH, rect.size.width, textFieldH);
    if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
        textFieldRect = rect;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        _inputView.frame = textFieldRect;
    }];
    
    CGFloat h = rect.size.height + textFieldH;
    if (_totalKeybordHeight != h) {
        _totalKeybordHeight = h;
        [self adjustTableViewToFitKeyboard];
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
    CGFloat delta = CGRectGetMaxY(rect) - (SCREEN_HEIGHT - _totalKeybordHeight);

    CGPoint offset = self.tableView.contentOffset;
    offset.y += delta;
    if (offset.y < 0) {
        offset.y = 0;
    }

    [self.tableView setContentOffset:offset animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }else{
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight = [tableView cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:tableView];
    return cellHeight;
}

- (void)toClubHomePage{

    if (self.clubModel.data.from.integerValue == 0) {//平台
        
    }else{
        TSOClubHomePageViewController *clubHomePageVC = [[TSOClubHomePageViewController alloc] initWithClubID:self.clubModel.data.clubId.stringValue];
        clubHomePageVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:clubHomePageVC animated:YES];
    }
}


- (TSOClubInfoView *)clubView{
    if (_clubView == nil) {
        _clubView = [[TSOClubInfoView alloc] init];
        _clubView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 85);
        _clubView.backgroundColor = WHITECOLOR;
    }
    return _clubView;
}



- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[TSOTopicCommentCell class] forCellReuseIdentifier:kTSOTopicCommentCell];
        [_tableView registerClass:[TSOClubArticleDetailCell class] forCellReuseIdentifier:kTSOClubArticleDetailCell];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        weak(self);
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf requestArticleComment];
            
        }];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 1;
            [weakSelf requestArticleComment];
            [weakSelf.tableView.mj_header endRefreshing];
        }];
    }
    return _tableView;
}

- (UIView *)commentView{
    if (_commentView == nil) {
        _commentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _commentView.backgroundColor = WHITECOLOR;
        UILabel *tempLb = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 16)];
        tempLb.textColor = BLACKTEXTCOLOR;
        tempLb.font = FONT(14);
        tempLb.text = @"最新评论";
        [_commentView addSubview:tempLb];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, SCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = GRAYCOLOR;
        [_commentView addSubview:lineView];
    }
    return _commentView;
}

- (void)setClubModel:(ClubArticleDetailModel *)clubModel{
    _clubModel = clubModel;
    
    _clubView.model = _clubModel;
    [_likeBtn setSelected:_clubModel.data.collectStatus];

}

- (NSMutableArray *)dataList{
    if (_dataList == nil) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}

- (TSOCommentInputView *)inputView{
    if (_inputView == nil) {
        _inputView = [[TSOCommentInputView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
        _inputView.delegate = self;
    }
    return _inputView;
}




@end
