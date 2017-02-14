//
//  MyInviteViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/8.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "MyInviteViewController.h"
#import "SDTimeLineCellModel.h"
#import "MyInviteCommentCell.h"
#import "MyInviteCommentView.h"


#define kMyInviteCommentCellId @"MyInviteCommentCell"
static CGFloat textFieldH = 40;
@interface MyInviteViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
MyInviteCommentCellDelegate,
UITextFieldDelegate

>

@property (nonatomic, strong) UITextField *textFieldTEST;
@property (nonatomic, assign) BOOL isReplayingComment;
@property (nonatomic, strong) NSIndexPath *currentEditingIndexthPath;
@property (nonatomic, copy) NSString *commentToUser;
/**yb 当前评论的id*/
@property (nonatomic, strong) NSString *commentID;
/**page*/
@property (nonatomic, assign) NSInteger page;

@end

@implementation MyInviteViewController

{
//    SDTimeLineRefreshFooter *_refreshFooter;
//    SDTimeLineRefreshHeader *_refreshHeader;
    CGFloat _lastScrollViewOffsetY;
    CGFloat _totalKeybordHeight;
}

#pragma mark - Lifecycle

- (void)dealloc{
    [_textFieldTEST removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self setupUI];
    [self setupTextField];
}



- (void)setupUI{
   
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = BACKGROUNDCOLOR;
    [self.tableView registerClass:[MyInviteCommentCell class] forCellReuseIdentifier:kMyInviteCommentCellId];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    weak(self);
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestData];
        
    }];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        [weakSelf requestData];
        
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardNotification:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
}

- (void)setupTextField
{
    _textFieldTEST = [UITextField new];
    _textFieldTEST.backgroundColor = WHITECOLOR;
    _textFieldTEST.returnKeyType = UIReturnKeyDone;
    _textFieldTEST.delegate = self;
    _textFieldTEST.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8].CGColor;
    _textFieldTEST.layer.borderWidth = 1;
    
    _textFieldTEST.textColor = BLACKTEXTCOLOR;
    //为textfield添加背景颜色 字体颜色的设置 还有block设置 , 在block中改变它的键盘样式 (当然背景颜色和字体颜色也可以直接在block中写)
    _textFieldTEST.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.view.width_sd, textFieldH);
    [[UIApplication sharedApplication].keyWindow addSubview:_textFieldTEST];
    
    [_textFieldTEST becomeFirstResponder];
    [_textFieldTEST resignFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated{
    [_textFieldTEST resignFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

//MARK: - 请求数据
- (void)requestData{
    if (self.page == 1) {
        [self.dataArray removeAllObjects];
    }
    
    NSDictionary *parameter = @{@"currentPage":[NSString stringWithFormat:@"%zd",self.page],
                                @"pageSize":PAGESIZE};
    [ShareBusinessManager.appointmentFriendManager postAppointmentFriendMyInviteListWithParameters:parameter success:^(id responObject) {
        NSMutableArray *array = [SDTimeLineCellModel mj_objectArrayWithKeyValuesArray:responObject[@"data"]];
        if (array.count > 0) {
            [self.dataArray addObjectsFromArray:array];
            
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
            UIImageView *placeHoderImageView = [[UIImageView alloc] initWithFrame:self.tableView.bounds];
            placeHoderImageView.image = EmptyImage;
            self.tableView.tableFooterView = placeHoderImageView;
        }else{
            self.tableView.tableFooterView = [UIView new];
        }
        
        [self.tableView reloadData];
    
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
        if (self.dataArray.count == 0) {
            UIImageView *placeHoderImageView = [[UIImageView alloc] initWithFrame:self.tableView.bounds];
            placeHoderImageView.image = EmptyImage;
            self.tableView.tableFooterView = placeHoderImageView;
        }else{
            self.tableView.tableFooterView = [UIView new];
        }
    }];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_textFieldTEST endEditing:YES];
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
        NSLog(@"回复帖子错误信息%@===",errorMsg);
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
    
}

#pragma mark - MyInviteCommentCellDelegate
- (void)didClickLikeButtonInCell:(UITableViewCell *)cell{
    [SVProgressHUD showSuccessWithStatus:@"打电话"];
}
- (void)didClickcCommentButtonInCell:(UITableViewCell *)cell{
    [_textFieldTEST becomeFirstResponder];
     _textFieldTEST.placeholder = @"回复：帖子";
    _currentEditingIndexthPath = [self.tableView indexPathForCell:cell];
    [self adjustTableViewToFitKeyboard];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length) {
        [_textFieldTEST resignFirstResponder];
        
        SDTimeLineCellModel *model = self.dataArray[_currentEditingIndexthPath.row];
        NSMutableArray *temp = [NSMutableArray new];
        [temp addObjectsFromArray:model.commentItemsArray];
//        SDTimeLineCellCommentItemModel *commentItemModel = [SDTimeLineCellCommentItemModel new];
        
        NSDictionary *dict;
        
        if (self.isReplayingComment) {
            //yb 评论其他评论
            
            dict = @{@"commentId":self.commentID,
                       @"content":textField.text};

            self.isReplayingComment = NO;
        } else {
            dict = @{@"content":textField.text,
                      @"articleId":model.articleId.stringValue};
            //yb 评论自己

        }
        [self addCommentWithDict:dict];//发送评论网络请求
        _textFieldTEST.text = @"";
        _textFieldTEST.placeholder = nil;
        
        return YES;
    }
    return NO;
}


#pragma mark - UITableViewDelegate



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyInviteCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:kMyInviteCommentCellId];
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
        
        [cell setDidClickCommentLabelBlock:^(NSString *commentId,NSString *commentName, CGRect rectInWindow, NSIndexPath *indexPath) {
            
            //yb判断commentID 和 当前用户id是否相等  
            if ([commentName isEqualToString:[UserModel sharedUserModel].nickName]) {
                
            }else{
//                weakSelf.textField.placeholder = [NSString stringWithFormat:@"  回复：%@", commentName];
//                weakSelf.currentEditingIndexthPath = indexPath;
//                [weakSelf.textField becomeFirstResponder];
//                weakSelf.isReplayingComment = YES;
//                weakSelf.commentToUser = commentName;
//                weakSelf.commentID = commentId;
//                [weakSelf adjustTableViewToFitKeyboardWithRect:rectInWindow];
    
                weakSelf.textFieldTEST.placeholder = [NSString stringWithFormat:@"  回复：%@", commentName];
                weakSelf.currentEditingIndexthPath = indexPath;
                [weakSelf.textFieldTEST becomeFirstResponder];
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
    
    cell.pressBlock = ^(){
  
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否删除当前邀请" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击取消");
            
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击确认");
            
        }]];
        
        [weakSelf presentViewController:alert animated:YES completion:nil];
        
    };
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    ///////////////////////////////////////////////////////////////////////
    
    cell.model = model;
    return cell;

}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 6;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    id model;
    if (self.dataArray.count > 0) {
        model = self.dataArray[indexPath.row];
    }
    
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[MyInviteCommentCell class] contentViewWidth:[self cellContentViewWith]];
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

#pragma mark - function

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

- (void)keyboardNotification:(NSNotification *)notification
{
    
    if (self.isShowing) {
        NSDictionary *dict = notification.userInfo;
        CGRect rect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
        
        CGRect textFieldRect = CGRectMake(0, rect.origin.y - textFieldH, rect.size.width, textFieldH);
        if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
            textFieldRect = rect;
        }
        [UIView animateWithDuration:0.25 animations:^{
            _textFieldTEST.frame = textFieldRect;
        }];
        CGFloat h = rect.size.height + textFieldH;
        if (_totalKeybordHeight != h) {
            _totalKeybordHeight = h;
            [self adjustTableViewToFitKeyboard];
        }
    }
    
}

#pragma mark - Setter&Getter



- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}



@end
