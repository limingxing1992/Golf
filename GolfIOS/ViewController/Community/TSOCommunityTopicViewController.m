//
//  TSOCommunityTopicViewController.m
//  GolfIOS
//
//  Created by yangbin on 16/11/4.
//  Copyright © 2016年 zzz. All rights reserved.
//  在线社区帖子与评论

#import "TSOCommunityTopicViewController.h"

#import "TSOCommunityUserInfoViewController.h"

#import "CommunityArticleModel.h"
#import "CommunityArticleCommentModel.h"
#import "SeverStatus.h"
#import "YB_UITextField.h"


#import "TSOTopicCommentCell.h"
#import "SDTimeLineCellModel.h"


@interface TSOCommunityTopicViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate,
TSOHomeCommunityTableViewCellDelegate
>

{
    CGFloat _lastScrollViewOffsetY;
    CGFloat _totalKeybordHeight;
}

/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**底部输入框*/
@property (nonatomic, strong) UIView *editView;
/**底部输入框TextField*/
@property (nonatomic, strong) YB_UITextField *inputTF;
/**回复按钮*/
@property (nonatomic, strong) UIButton *addCommentBtn;
/**帖子模型*/
@property (nonatomic, strong) CommunityArticle *communityArticleModel;
/**最新评论*/
@property (nonatomic, strong) UIView *commentView;

/**当前正在编辑的cell*/
@property (nonatomic, strong) NSIndexPath *currentEditingIndexthPath;

@property (nonatomic, assign) BOOL isReplayingComment;
/**是否直接回复评论 或者是回复 评论的评论*/
@property (nonatomic, assign) BOOL isDirectReComment;
/**第几条评论的评论*/
@property (nonatomic, assign) NSInteger commentRow;

/**page*/
@property (nonatomic, assign) NSInteger page;
/**dataList*/
@property (nonatomic, strong) NSMutableArray *dataList;

/**帖子id*/
@property (nonatomic, strong) NSString *articleId;

@end
static CGFloat textFieldH = 50;
@implementation TSOCommunityTopicViewController

static  NSString *const kTSOTopicCommentCell = @"kTSOTopicCommentCell";
static  NSString *const kTSOHomeCommunityTableViewCell = @"kTSOHomeCommunityTableViewCell";


#pragma mark - LifeCycle

- (instancetype)initWithCommunityArticleID:(NSString *)articleId{
    if (self = [super init]) {
        self.articleId = articleId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.page = 1;
}

- (void)setupUI{
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.editView];
    //注册键盘出现的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //注册键盘消失的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)setupNav{
    [super setupNav];

    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"classify86"] style:UIBarButtonItemStylePlain target:self action:@selector(reportAction)];
    rightBtn.tintColor = GLOBALCOLOR;
    
    self.navigationItem.rightBarButtonItem = rightBtn;
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestArticleDetail];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 请求数据
//请求帖子详情

- (void)requestArticleDetail{
    
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:self.articleId forKey:@"articleId"];
    if ([UserModel sharedUserModel].ID) {
        [parameter setObject:[UserModel sharedUserModel].ID forKey:@"userId"];
    }
    
    [ShareBusinessManager.communityManager getCommunityArticleDetailWithParameters:parameter success:^(id responObject) {
        CommunityArticle *model = (CommunityArticle *)responObject;
        self.communityArticleModel = model;
        [self.tableView reloadData];
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}

//请求评论列表
- (void)requestData{
    if (self.page == 1) {
        [self.dataList removeAllObjects];
    }
    
    NSDictionary *parameter = @{@"currentPage":[NSString stringWithFormat:@"%zd",_page],
                                @"pageSize":PAGESIZE.stringValue,
                                @"articleId":self.articleId};
    
    [ShareBusinessManager.communityManager getCommunityArticleCommentListWithParameters:parameter success:^(id responObject) {
        CommunityArticleCommentModel *model = (CommunityArticleCommentModel *)responObject;
        if (model.errorCode.integerValue == 1) {
            
            if (model.data.dataList.count > 0) {
                
                [self.dataList addObjectsFromArray:model.data.dataList];
                self.page ++;
                [self.tableView reloadData];
            }
            if (model.data.dataList.count < PAGESIZE.integerValue) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
            NSInteger cellCount = self.tableView.frame.size.height /100;//test
            if (self.dataList.count < cellCount) {
                self.tableView.mj_footer.hidden = YES;
            }else{
                self.tableView.mj_footer.hidden = NO;
            }
        }else{
            [SVProgressHUD showErrorWithStatus:model.errorMsg];
            [self.tableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
        [self.tableView.mj_footer endRefreshing];
    }];

}
//回复帖子
- (void)addCommunityArticleComment{
    
    if (IsLogin) {
        NSDictionary *parameter;
        if (_isReplayingComment) {
            
            CommunityArticleComment *model = self.dataList[_currentEditingIndexthPath.row];
            if (_isDirectReComment) {
                parameter = @{@"commentId":model.ID,
                              @"content":self.inputTF.text};
            }else{
                SDTimeLineCellCommentItemModel *commentItem = model.commentItemsArray[self.commentRow];
                parameter = @{@"commentId":commentItem.ID.stringValue,
                              @"content":self.inputTF.text};
            }
            
        }else{
            parameter = @{@"articleId":self.communityArticleModel.ID.stringValue,
                          @"content":self.inputTF.text};
        }
        
        NSLog(@"====parameter==%@",parameter);
        [ShareBusinessManager.communityManager addCommunityArticleCommentWithParameters:parameter success:^(id responObject) {
//            self.communityArticleModel.commentNum = (NSNumber *) responObject[@"data"][@"commentNum"];
            self.inputTF.text = nil;
            [self.view endEditing:YES];
            [self.tableView.mj_header beginRefreshing];
            [SVProgressHUD showSuccessWithStatus:@"发帖成功"];
            
        } failure:^(NSInteger errCode, NSString *errorMsg) {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }];
    }else{
        [self presentViewController:LoginNavi animated:YES completion:nil];
    }

    
}

//帖子举报
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
    NSDictionary *parameter = @{@"postType":@"10",//社区帖子
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

- (void)keyboardWasShown:(NSNotification*)aNotification{
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.editView.frame = CGRectMake(0, SCREEN_HEIGHT - keyBoardFrame.size.height - 50, SCREEN_WIDTH , 50);
    }];
}

-(void)keyboardWillBeHidden:(NSNotification*)aNotification{
    _inputTF.placeholder = @"写评论";
    [UIView animateWithDuration:0.25 animations:^{
        self.editView.frame = CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50);
    }];
    
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
        _inputTF.frame = textFieldRect;
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

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommunityArticleComment *model;
    if (self.dataList.count > 0) {
        model = self.dataList[indexPath.row];
    }
    if (indexPath.section == 0) {
        
        TSOHomeCommunityTableViewCell *communityCell = [tableView dequeueReusableCellWithIdentifier:kTSOHomeCommunityTableViewCell];
        
        if (self.communityArticleModel) {//如果为空 模型使用nsdate分类格式化时间时候有一个函数会报错
            communityCell.model = self.communityArticleModel;
        }

        communityCell.delegate = self;
        return communityCell;
    }else{
        TSOTopicCommentCell *topicCommentCell = [tableView dequeueReusableCellWithIdentifier:kTSOTopicCommentCell];
        
        topicCommentCell.indexPath = indexPath;
        weak(self);
        [topicCommentCell setDidClickCommentLabelBlock:^(NSString *commentId,NSString *commentName, CGRect rectInWindow, NSIndexPath *indexPath, NSInteger commentRow) {
            //回复的回复
            //yb判断commentID 和 当前用户id是否相等
            if ([commentName isEqualToString:[UserModel sharedUserModel].nickName]) {
                
            }else{
                
                weakSelf.inputTF.placeholder = [NSString stringWithFormat:@"  回复：%@", commentName];
                weakSelf.currentEditingIndexthPath = indexPath;
                weakSelf.commentRow = commentRow;
                [weakSelf.inputTF becomeFirstResponder];
                weakSelf.isReplayingComment = YES;
                weakSelf.isDirectReComment = NO;
                [weakSelf adjustTableViewToFitKeyboard];
            }
            
        }];
        
        [topicCommentCell setDidClickContentLabelBlock:^{
            //直接回复帖子
            weakSelf.isDirectReComment = YES;
            weakSelf.isReplayingComment = YES;
            weakSelf.currentEditingIndexthPath = indexPath;
            weakSelf.inputTF.placeholder = [NSString stringWithFormat:@"  回复："];
            [weakSelf.inputTF becomeFirstResponder];
        }];
        
        topicCommentCell.communityModel = model;
        return topicCommentCell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight = [tableView cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:tableView];
    return cellHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return self.commentView;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 44;
    }else{
        return 0.01;
    }
}

//MARK: - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];

    [self addCommunityArticleComment];
    self.isReplayingComment = NO;
    return YES;
}

#pragma mark - TSOHomeCommunityTableViewCellDelegate

- (void)tSOHomeCommunityTableViewCell:(TSOHomeCommunityTableViewCell *)cell nameLabelDidClick:(NSString *)name{
    
    if ([self.communityArticleModel.userId.stringValue isEqualToString:[UserModel sharedUserModel].ID]) {
        TSOCommunityMySpaceViewController *mySpaceVC = [[TSOCommunityMySpaceViewController alloc] init];
        mySpaceVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mySpaceVC animated:YES];
        
    }else{
        TSOCommunityUserInfoViewController *userInfoVC = [[TSOCommunityUserInfoViewController alloc] initWithUserID:self.communityArticleModel.userId.stringValue];
        userInfoVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:userInfoVC animated:YES];
    }
    
}

- (void)tSOHomeCommunityTableViewCell:(TSOHomeCommunityTableViewCell *)cell focusBtnDidClick:(NSString *)userId{
    if (IsLogin) {

        if (cell.model.isfollow == YES) {
            [ShareBusinessManager.userManager postMyAttentionRemoveWithParameters:@{@"userId":userId} success:^(id responObject) {
                [SVProgressHUD showSuccessWithStatus:responObject];
                
                [self requestArticleDetail];
            } failure:^(NSInteger errCode, NSString *errorMsg) {
                [SVProgressHUD showErrorWithStatus:errorMsg];
            }];
        }else{
            [ShareBusinessManager.userManager postMyAttentionAddWithParameters:@{@"userId":userId} success:^(id responObject) {
                [SVProgressHUD showSuccessWithStatus:responObject];
               [self requestArticleDetail];
            } failure:^(NSInteger errCode, NSString *errorMsg) {
                [SVProgressHUD showErrorWithStatus:errorMsg];
            }];
        }
    }else{
        [self presentViewController:LoginNavi animated:YES completion:nil];
    }
}

#pragma mark - Setter&Getter

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,SCREEN_HEIGHT - 50) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[TSOTopicCommentCell class] forCellReuseIdentifier:kTSOTopicCommentCell];
        [_tableView registerClass:[TSOHomeCommunityTableViewCell class] forCellReuseIdentifier:kTSOHomeCommunityTableViewCell];
        
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

- (YB_UITextField *)inputTF{
    if (_inputTF == nil) {
        _inputTF = [[YB_UITextField alloc] initWithFrame:CGRectMake(15, 6, SCREEN_WIDTH  -  73, 38)];
        _inputTF.layer.borderColor = GLOBALCOLOR.CGColor;
        _inputTF.font = FONT(14);
        _inputTF.layer.borderWidth = 0.5;
        _inputTF.layer.cornerRadius = 4;
        _inputTF.placeholder = @"写评论";
        _inputTF.delegate = self;
        _inputTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        
    }
    return _inputTF;
}

- (UIView *)editView{
    if (_editView == nil) {
        _editView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
        _editView.backgroundColor = [UIColor whiteColor];
        UIView *topLine = [[UIView alloc] init];
        topLine.backgroundColor = BACKGROUNDCOLOR;
        topLine.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
        [_editView addSubview:topLine];
        [_editView addSubview:self.addCommentBtn];
        [_editView addSubview:self.inputTF];
   
    }
    return _editView;
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

- (NSMutableArray *)dataList{
    if (_dataList == nil) {
        _dataList = [[NSMutableArray  alloc] init];
    }
    return _dataList;
}

- (UIButton *)addCommentBtn{
    if (_addCommentBtn == nil) {
        _addCommentBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH  - 65, 6, 70, 40)];
        [_addCommentBtn setImage:IMAGE(@"classify216") forState:UIControlStateNormal];
        [_addCommentBtn addTarget:self action:@selector(addCommunityArticleComment) forControlEvents:UIControlEventTouchUpInside];
        [_addCommentBtn setTitleColor:LIGHTTEXTCOLOR forState:UIControlStateNormal];

    }
    return _addCommentBtn;
}

@end
