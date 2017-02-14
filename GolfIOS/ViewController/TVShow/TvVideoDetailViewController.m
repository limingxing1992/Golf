//
//  TvVideoDetailViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2017/1/5.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import "TvVideoDetailViewController.h"

#import "TSOTopicCommentCell.h"
#import "YB_UITextField.h"

#import "ClubArticleCommentModel.h"
#import "SDTimeLineCellModel.h"

@interface TvVideoDetailViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    TSOCommentInputViewDelegate
    
>
{
    XLVideoPlayer *_player;
    
    CGFloat _lastScrollViewOffsetY;
    CGFloat _totalKeybordHeight;
    
}


@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) UIImageView *headIv;

@property (nonatomic, strong) UILabel *titleLb;

/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**底部回复*/
@property (nonatomic, strong) TSOCommentInputView *inputView;
/**评论列表*/
@property (nonatomic, strong) NSMutableArray *dataList;
/**当前正在编辑的cell*/
@property (nonatomic, strong) NSIndexPath *currentEditingIndexthPath;
/** */
@property (nonatomic, assign) BOOL isReplayingComment;
/**是否直接回复评论 或者是回复 评论的评论*/
@property (nonatomic, assign) BOOL isDirectReComment;
/**第几条评论的评论*/
@property (nonatomic, assign) NSInteger commentRow;

@end

static NSString *const CommentCellReuseID = @"kTSOTopicCommentCell";

@implementation TvVideoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"小鸟视频";
    self.isAutoBack = NO;
    [self.view setBackgroundColor:BACKGROUNDCOLOR];
    [self.view addSubview:self.headView];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.inputView];
    
    self.tableView.sd_layout
    .topSpaceToView(self.headView, 10)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomSpaceToView(self.inputView, 0);
    

    [self requestCommetList];
}



- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_player destroyPlayer];
    _player = nil;

}

//MARK: - 获取评论列表
- (void)requestCommetList{
    
    NSDictionary *parameter = @{@"videoId":self.model.ID};
    [ShareBusinessManager.tvManager postTvVideoCommentListWithParameters:parameter success:^(id responObject) {
        
        NSLog(@"===视频评论列表===%@",responObject);
        ClubArticleCommentModel *commentMmodel = [ClubArticleCommentModel mj_objectWithKeyValues:responObject];
        
        if (commentMmodel.errorCode.integerValue == 1) {
            
            self.dataList = commentMmodel.data;
            
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:commentMmodel.errorMsg];
        }
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}

//    commentId	评论id
//    content	评论内容	string	必填
//    videoId	视频id	number
//添加评论 如果评论视频 需要传视频id 如果回复评论 传评论id
- (void)addCommentWithcommentId:(NSString *)commentId content:(NSString *)content videoId:(NSString *)videoId{
    
    [SVProgressHUD showWithStatus:@"正在回复中……"];
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    
    if (commentId) {
        [parameter setObject:commentId forKey:@"commentId"];
    }
    
    if (videoId) {
        [parameter setObject:videoId forKey:@"videoId"];
    }
    
    if (content) {
        [parameter setObject:content forKey:@"content"];
    }
 
    NSLog(@"====%@",parameter);
    [ShareBusinessManager.tvManager postTvVideoAddCommentWithParameters:parameter success:^(id responObject) {
        [SVProgressHUD showSuccessWithStatus:responObject];
        [self.inputView endEditing:YES];
        self.inputView.inputTF.placeholder = @"写评论";
        [self requestCommetList];
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
        [self.inputView endEditing:YES];
        self.inputView.inputTF.placeholder = @"写评论";
    }];
}

//MARK: - TSOCommentInputViewDelegate

- (void)commentInputViewCommentButtonDidClick:(TSOCommentInputView *)inputView{
    //test
    if (_isReplayingComment) {//回复评论
        ClubArticleComment *commentModel = self.dataList[_currentEditingIndexthPath.row];
        if (_isDirectReComment) {//直接回复评论
           
            [self addCommentWithcommentId:commentModel.ID.stringValue content:inputView.text videoId:nil];
        }else{//回复评论的评论
            SDTimeLineCellCommentItemModel *item = commentModel.commentItemsArray[_commentRow];
            [self addCommentWithcommentId:item.ID.stringValue content:inputView.text videoId:nil];
        }
    }else{
        //回复视频
        [self addCommentWithcommentId:nil content:inputView.text videoId:_model.ID];
    }
    
}

- (BOOL)commentInputViewShouldReturn:(TSOCommentInputView *)inputView{
    if (_isReplayingComment) {//回复评论
        ClubArticleComment *commentModel = self.dataList[_currentEditingIndexthPath.row];
        if (_isDirectReComment) {//直接回复评论
            
            [self addCommentWithcommentId:commentModel.ID.stringValue content:inputView.text videoId:nil];
        }else{//回复评论的评论
            SDTimeLineCellCommentItemModel *item = commentModel.commentItemsArray[_commentRow];
            [self addCommentWithcommentId:item.ID.stringValue content:inputView.text videoId:nil];
        }
    }else{
        //回复视频
        [self addCommentWithcommentId:nil content:inputView.text videoId:_model.ID];
    }
    return YES;
}

//MARK: - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClubArticleComment *model;
    if (self.dataList.count >0) {
        model = self.dataList[indexPath.row];
    }
    TSOTopicCommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:CommentCellReuseID];
    commentCell.model = model;
    
    commentCell.indexPath = indexPath;
    weak(self);
    [commentCell setDidClickCommentLabelBlock:^(NSString *commentId,NSString *commentName, CGRect rectInWindow, NSIndexPath *indexPath,NSInteger commentRow) {
        
        //yb判断commentID 和 当前用户id是否相等
        if ([commentName isEqualToString:[UserModel sharedUserModel].nickName]) {
            
        }else{
      
            weakSelf.inputView.inputTF.placeholder = @"";
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

    return commentCell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight = [tableView cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:tableView];
    return cellHeight;
}


//MARK: - Action
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

- (void)showVideoPlayer:(UITapGestureRecognizer *)tapGesture {
    
    
    [_player destroyPlayer];
    _player = nil;
    _player = [[XLVideoPlayer alloc] init];
    _player.videoUrl = [NSString stringWithFormat:@"https://tsoudingdan.oss-cn-hangzhou.aliyuncs.com/%@", _model.videoUrl];
    
    _player.frame = CGRectMake(0, NaviBar_HEIGHT, SCREEN_WIDTH, 210 *KHeight_Scale);
    
    [self.view addSubview:_player];
    
    _player.completedPlayingBlock = ^(XLVideoPlayer *player) {
        [player destroyPlayer];
        _player = nil;
    };
}


#pragma mark ----------------实例

- (UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, NaviBar_HEIGHT, SCREEN_WIDTH, 250 *KHeight_Scale)];
        [_headView setBackgroundColor:WHITECOLOR];
        [_headView addSubview:self.headIv];
        [_headView addSubview:self.titleLb];
        
        _titleLb.sd_layout
        .topSpaceToView(_headIv, 12)
        .leftSpaceToView(_headView, 15)
        .rightSpaceToView(_headView, 15)
        .autoHeightRatio(0);
        
    }
    return _headView;
}

- (UIImageView *)headIv{
    if (!_headIv) {
        _headIv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210 *KHeight_Scale)];
        [_headIv sd_setImageWithURL:FULLIMGURL(_model.pictureUrl) placeholderImage:Placeholder_big];
        UIImageView *playIv = [[UIImageView alloc] init];
        playIv.image = IMAGE(@"play");
        [_headIv addSubview:playIv];
        playIv.sd_layout
        .centerYEqualToView(_headIv)
        .centerXEqualToView(_headIv)
        .heightIs(60 *KHeight_Scale)
        .widthEqualToHeight();
        _headIv.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showVideoPlayer:)];
        [_headIv addGestureRecognizer:tap];

    }
    return _headIv;
}

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font= FONT(16);
        _titleLb.textColor = BLACKTEXTCOLOR;
        _titleLb.text = _model.name;
    }
    return _titleLb;
}

#pragma mark - lazt loading

- (XLVideoPlayer *)player {
    if (!_player) {
        _player = [[XLVideoPlayer alloc] init];
        _player.frame = CGRectMake(0, 0, self.view.frame.size.width, 210);
    }
    return _player;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[TSOTopicCommentCell class] forCellReuseIdentifier:CommentCellReuseID];
    }
    return _tableView;
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
