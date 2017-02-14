//
//  TSOPublishTopicViewController.m
//  GolfIOS
//
//  Created by yangbin on 16/11/7.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOPublishTopicViewController.h"
#import "HX_AddPhotoView.h"
#import "MenuView.h"
#import "YB_ToolBtn.h"
#import <AssetsLibrary/AssetsLibrary.h>

#import "UIImage+Image.h"
#import "SeverStatus.h"

@interface TSOPublishTopicViewController ()
<
UITextFieldDelegate,
UITextViewDelegate,
HX_AddPhotoViewDelegate
>

/**是否展示popMenu*/
@property (nonatomic,assign) BOOL flag;

/**帖子内容*/
@property (nonatomic, strong) UITextView *topicTextView;
/**发帖或者公告*/
@property (nonatomic, strong) UIButton *publishBtn;
/**底部按钮*/
@property (nonatomic, strong) YB_ToolBtn *bottomBtn;
/**选中的图片*/
@property (nonatomic, strong) NSMutableArray *imageAry;
/**选择照片视图*/
@property (nonatomic, strong) HX_AddPhotoView *addPhotoView;
/**上传成功后返回的图片url*/
@property (nonatomic, strong) NSArray *imageUrlArray;

/**是否是二级页面*/
@property (nonatomic, assign) BOOL isSecondLevealPage;

@end

@implementation TSOPublishTopicViewController

#pragma mark - LifeCycle


- (instancetype)initSecondLevelPage{
    if (self = [super init]) {
        
        _isSecondLevealPage = YES;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupPublishBtn];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MenuView hidden];
}

- (void)setupNav{
    [super setupNav];
//    self.publishBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 15)];
//    self.publishBtn.titleLabel.font = FONT(14);
//    
//    //    publishBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0); // 距离左边
//    //    publishBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
//    
//    [self.publishBtn setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
//    [self.publishBtn setTitle:@"发帖" forState:UIControlStateNormal];
//    [self.publishBtn addTarget:self action:@selector(popMenu) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.publishBtn];
//    self.navigationItem.rightBarButtonItem = rightItem;
    
    
//    if (_isSecondLevealPage) {
//        
//        
//        self.navigationItem.leftBarButtonItem = nil;
//    }
}

- (void)setupUI{
    self.navTitle = @"发帖";
    self.flag = YES;
    [self.view addSubview:self.topicTextView];
    [self.view addSubview:self.addPhotoView];
    [self.view addSubview:self.bottomBtn];
    
    self.addPhotoView.sd_layout
    .topSpaceToView(self.topicTextView, 10)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(93*(SCREEN_WIDTH / 320));

    
    UIToolbar * topView = [[UIToolbar alloc]init];
    topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    UIBarButtonItem *fixspace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray * buttonsArray = [NSArray arrayWithObjects:fixspace,doneButton,nil];
    [topView setItems:buttonsArray];
    [self.topicTextView setInputAccessoryView:topView];
    
    
    
}



- (void)setupPublishBtn{
    NSArray *dataArray = @[@{@"itemName" : @"公告"},@{@"itemName" : @"帖子"}];
    
    CGFloat x = self.view.bounds.size.width / 3 * 2;
    CGFloat y = 64 - 10;
    CGFloat width = self.view.bounds.size.width * 0.3;
    CGFloat height = dataArray.count * 40;  // 40 -> tableView's RowHeight
    __weak __typeof(&*self)weakSelf = self;
    
    [MenuView createMenuWithFrame:CGRectMake(x, y, width, height) target:self.navigationController dataArray:dataArray itemsClickBlock:^(NSString *str, NSInteger tag) {
        // do something
        NSLog(@"点击了按钮%@",str);
        [self.publishBtn setTitle:str forState:UIControlStateNormal];
        [MenuView hidden];  // 隐藏菜单
        self.flag = YES;
    } backViewTap:^{
        // 点击背景遮罩view后的block，可自定义事件
        // 这里的目的是，让rightButton点击，可再次pop出menu
        weakSelf.flag = YES;
    }];
}


#pragma mark - Action
-(void)dismissKeyBoard
{
    [self.topicTextView resignFirstResponder];
}

- (void)publishTopic{
    
    if (self.imageAry.count > 0) {
        [SVProgressHUD showWithStatus:@"正在上传图片"];
        NSDictionary *parameter = @{@"file":@".png",
                                    @"menu":@"club"};
        [ShareBusinessManager.clubManager upLoadImageWith:self.imageAry parameters:parameter success:^(id responObject) {
            
            NSDictionary *dict = (NSDictionary *)responObject;
            [SVProgressHUD showSuccessWithStatus:dict[@"showMessage"]];
            self.imageUrlArray = [dict[@"data"] copy];
            [self publishArticle];
            
        } failure:^(NSInteger errCode, NSString *errorMsg) {
            
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }];
    }else{
        [self publishArticle];
    }
}

- (void)publishArticle{
    
    NSString *images = [self.imageUrlArray componentsJoinedByString:@","];
    if (!images) {
        images = @"";
    }
    NSDictionary *parameter = @{@"content":self.topicTextView.text,
                                @"images":images};
    [ShareBusinessManager.communityManager addCommunityArticleWithParameters:parameter success:^(id responObject) {
        
        SeverStatus *status = (SeverStatus *)responObject;
        if (status.errorCode.integerValue == 1) {
            
            [SVProgressHUD showSuccessWithStatus:status.errorMsg];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [SVProgressHUD showErrorWithStatus:status.errorMsg];
        }
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}

- (void)refreshPhotoViewFrame{
    NSInteger count = self.imageAry.count;
    
    NSUInteger line = 1;
    for (int i = 1; i<=count; i++) {
        if (i % 4 == 0) {
            line ++;
        }
    }
    self.addPhotoView.sd_resetLayout
    .topSpaceToView(self.topicTextView, 10)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs((93*(SCREEN_HEIGHT / 568) -23) *line + 23);
}


#pragma mark - UITextViewDelegate

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"请输入发帖内容"]) {
        textView.text = @"";
    }
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"请输入发帖内容";
    }
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)popMenu{
    
    if (self.flag) {
        [MenuView showMenuWithAnimation:self.flag];
        self.flag = NO;
    }else{
        [MenuView showMenuWithAnimation:self.flag];
        self.flag = YES;
    }
}

#pragma mark - Setter&Getter



- (UITextView *)topicTextView{
    if (_topicTextView == nil) {
        _topicTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _topicTextView.delegate = self;
        _topicTextView.contentSize = CGSizeMake(SCREEN_WIDTH - 30, 170);
        
        _topicTextView.contentOffset = CGPointMake( -11, -5);
        _topicTextView.text = @"请输入发帖内容";
        _topicTextView.textColor = SHENTEXTCOLOR;
    }
    return _topicTextView;
}




- (UITableViewCell *)setupCell:(UITableViewCell *)cell title:(NSString *)title image:(NSString *)imgStr{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//消除选中样式
    cell.textLabel.font = FONT(12);//设置标题大小
    cell.textLabel.textColor = SHENTEXTCOLOR;//设置标题颜色
    cell.accessoryView = [[UIImageView alloc] initWithImage:IMAGE(@"classify8")];//设置指示图
    cell.detailTextLabel.textColor = LIGHTTEXTCOLOR;//设置详请字体颜色
    cell.detailTextLabel.font = FONT(12);//设置详情字体大小
    cell.imageView.image = IMAGE(imgStr);
    cell.textLabel.text = title;
    cell.textLabel.textColor = SHENTEXTCOLOR;
    return cell;
}

- (YB_ToolBtn *)bottomBtn{
    if (_bottomBtn == nil) {
        _bottomBtn = [[YB_ToolBtn alloc] initBottomButton];
        [_bottomBtn setTitle:@"发布" forState:UIControlStateNormal];
        [_bottomBtn addTarget:self action:@selector(publishTopic) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}

- (NSMutableArray *)imageAry{
    if (!_imageAry) {
        _imageAry = [NSMutableArray array];
    }
    return _imageAry;
}

- (HX_AddPhotoView *)addPhotoView{
    if (_addPhotoView == nil) {
        GOLFWeakObj(self);
        self.addPhotoView = [[HX_AddPhotoView alloc] initWithMaxPhotoNum:9 WithSelectType:SelectPhoto];
        // 每行最大个数  不设置默认为4
        _addPhotoView.lineNum = 4;
        
        // collectionView 距离顶部的距离  底部与顶部一样  不设置,默认为0
        _addPhotoView.margin_Top = 12;
        
        // 距离左边的距离  右边与左边一样  不设置,默认为0
        _addPhotoView.margin_Left = 15;
        
        // 每个item间隔的距离  如果最小不能小于5   不设置,默认为5
        _addPhotoView.lineSpacing = 10;
        
        // 录制视频时最大多少秒   默认为60;
        _addPhotoView.videoMaximumDuration = 60.f;
        
        _addPhotoView.delegate = self;
        _addPhotoView.backgroundColor = [UIColor whiteColor];
        
        
        
        [self.view addSubview:_addPhotoView];
        
        //    addPhotoView.selectNum;
        
        [_addPhotoView setSelectPhotos:^(NSArray *photos, BOOL iforiginal) {
            
            [weakself.imageAry removeAllObjects];
            
            [photos enumerateObjectsUsingBlock:^(ALAsset *asset, NSUInteger idx, BOOL * _Nonnull stop) {
                UIImage *img;
                
                if (iforiginal) {
                    
                    CGImageRef fullImage = [[asset defaultRepresentation] fullResolutionImage];
                    img = [UIImage imageWithCGImage:fullImage];
                }else{
                    img = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
                }
                [weakself.imageAry addObject:img];
                
                
            }];
            [weakself refreshPhotoViewFrame];
        }];
    }
    return _addPhotoView;
}


@end
