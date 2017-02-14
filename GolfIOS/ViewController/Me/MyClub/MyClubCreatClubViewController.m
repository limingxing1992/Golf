//  CreatClubViewController.m
//  GolfIOS
//  Created by wyao on 2016/11/15.
//  Copyright © 2016年 TSou. All rights reserved.
//
#import "MyClubCreatClubViewController.h"
/** 自定义箭头视图cell的标识*/
static NSString* CreatClubViewCellId = @"CreatClubViewCellId";
/** 俱乐部介绍cell的标识*/
static NSString* ClubInfoViewCellId = @"ClubInfoViewCellId";
@interface MyClubCreatClubViewController ()<
UITableViewDelegate,
UITableViewDataSource,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
UIActionSheetDelegate,
UITextViewDelegate,
UITextFieldDelegate,
STL_NumPickerViewDelegate
>

@property(nonatomic,strong) UITableView *tableView;
/** 上传头像视图*/
@property(nonatomic,strong) UIView *iconView;
/** 上传头像按钮*/
@property(nonatomic,strong) UIButton *iconBtn;
/** 创建按钮*/
@property(nonatomic,strong) UIButton *creatBtn;
/** 俱乐部描述TextView*/
@property (nonatomic, strong) UITextView *introductionView;
/** 公开按钮*/
@property(nonatomic,strong) UIButton *openBtn;
/** 不公开按钮*/
@property(nonatomic,strong) UIButton *closeBtn;
/** 选择公开的视图*/
@property (nonatomic, strong) UIView *openView;
/** 俱乐部名称输入框*/
@property(nonatomic,strong) UITextField *clubNameTf;
/** 创始人输入框*/
@property(nonatomic,strong) UITextField *contactNameTf;
/** 联系人方式*/
@property(nonatomic,strong) UITextField *contactPhoneTf;
/** 会员等级选择弹窗*/
@property (nonatomic, strong) STL_NumPickerView *limitGradePickView;
/** 人数选择弹窗*/
@property (nonatomic, strong) STL_NumPickerView *limitNumPickView;

/** 相册选择提示框*/
@property (strong, nonatomic) UIActionSheet *actionSheet;
/** 选中的图片*/
@property (nonatomic, strong) UIImage *iconImage;
/** 选中的图片数组*/
@property (nonatomic, strong) NSMutableArray *imageAry;
/** 选中的图片的url*/
@property (nonatomic, copy) NSString *logoUrl;
/** 图片上传成功标志*/
@property (nonatomic, assign) BOOL logoFlag;
/**上传成功后的图片路径数组*/
@property (nonatomic, strong) NSArray *imageUrlArray;
/** 按钮点击的逻辑*/
@property(nonatomic,copy) NSString *isOpen;
/** 等级限制的选择*/
@property(nonatomic,copy) NSString *limitGradeNum;
/** 人数的限制*/
@property(nonatomic,copy) NSString *limitNum;

/** 动态获取的键盘高度*/
@property(nonatomic,assign) CGFloat  kbHeight;
/** 动态获取的键盘高度*/
@property(nonatomic,assign) double  duration;


@end
@implementation MyClubCreatClubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.name = @"创建俱乐部";
    self.isAutoBack = NO;
    self.view.backgroundColor = GRAYCOLOR;
    self.kbHeight = 216.0f;
    [self initUI];
    
    // 为UITextView的输入法界面添加一个工具栏
    UIToolbar * toolbarView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [toolbarView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * spaceBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * closeBtn = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(closeKeyBoard)];
    NSArray * btnsArr = [NSArray arrayWithObjects:spaceBtn, closeBtn, nil];
    [toolbarView setItems:btnsArr];
    [self.introductionView setInputAccessoryView:toolbarView];
    
    [GOLFNotificationCenter addObserver:self selector:@selector(keyBoardShowAction:) name:UIKeyboardWillShowNotification object:nil];
    [GOLFNotificationCenter addObserver:self selector:@selector(keyBoardHideAction:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc{
    [GOLFNotificationCenter removeObserver:self];
}


#pragma mark - 初始化UI
-(void)initUI{
    [self.view addSubview:self.tableView];
    
    UIView *footerview = [[UIView alloc] init];
    footerview.backgroundColor = WHITECOLOR;
    [self.view addSubview:footerview];
    //布局
    [footerview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(60);
    }];
    [footerview addSubview:self.creatBtn];

    [self.creatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(footerview).offset(10);
        make.left.equalTo(footerview).offset(18);
        make.bottom.equalTo(footerview).offset(-10);
        make.right.equalTo(footerview).offset(-18);;
    }];

}

#pragma mark ----------------监听输入框弹出和隐藏

- (void)keyBoardShowAction:(NSNotification *)notification{
    
    self.kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    self.duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
}

- (void)keyBoardHideAction:(NSNotification *)notify{
    GOLFWeakObj(self);
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        weakself.tableView.transform = CGAffineTransformIdentity;
    }];
    
}


#pragma mark - 选择相片的照片
-(void)addBtnClick:(UIButton*)sender{
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    }else{
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    
    self.actionSheet.tag = 1000;
    [self.actionSheet showInView:self.view];
}

#pragma mark - 判断并跳转
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1000) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0://来源:相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1://来源:相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    return;
            }
        }
        else {
            if (buttonIndex == 1) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
    }
}

#pragma mark - 选择相册的代理方法 - 结束时的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.iconBtn setImage:image forState:UIControlStateNormal];
    self.iconImage = image;
    
    //上传头像获取url
    [self upLoadIconWithImage:self.iconImage];
}

#pragma mark - 点击相册取消按钮所执行的方法
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    //这是捕获点击右上角cancel按钮所触发的事件
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - 创建俱乐部按钮点击事件
-(void)creatCLubClick:(UIButton*)sender{
    
    if (self.logoUrl.length == 0) {[SVProgressHUD showErrorWithStatus:@"图片上传失败请重新操作"]; return;}

    //判断俱乐部名称
    if (self.clubNameTf.text.length == 0) { [SVProgressHUD showErrorWithStatus:@"请输入俱乐部名称"];return;}
    //判断俱乐部简介
    if (self.introductionView.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写俱乐部简介"];
        return;
    }else{
        if ([self.introductionView.text isEqualToString:@"请填写俱乐部简介"]) {
            [SVProgressHUD showErrorWithStatus:@"请填写俱乐部简介"];
            return;
        }
    }
    //等级限制
    if (!self.limitGradeNum) {[SVProgressHUD showErrorWithStatus:@"请选择等级"];return;}
    
    //人数限制
    if (!self.limitNum) {[SVProgressHUD showErrorWithStatus:@"请选择人数限制"];return;}
    //等级限制
    NSString *limitGradeString;
    if (!self.limitGradeNum) {[SVProgressHUD showErrorWithStatus:@"请选择等级"];return;}
    
    if ([self.limitGradeNum isEqualToString:@"男爵"]) {
        limitGradeString  = [NSString stringWithFormat:@"1"];
    }else if([self.limitGradeNum isEqualToString:@"子爵"]){
        limitGradeString  = [NSString stringWithFormat:@"2"];
    }else if ([self.limitGradeNum isEqualToString:@"伯爵"]){
        limitGradeString  = [NSString stringWithFormat:@"3"];
    }else if ([self.limitGradeNum isEqualToString:@"侯爵"]){
        limitGradeString  = [NSString stringWithFormat:@"4"];
    }else if ([self.limitGradeNum isEqualToString:@"公爵"]){
        limitGradeString  = [NSString stringWithFormat:@"5"];
    }
    

    
    //是否公开
    if (!self.isOpen) {[SVProgressHUD showErrorWithStatus:@"请选择是否公开"];return;}
    
    //判断联系人
    if (self.contactNameTf.text.length ==  0) {[SVProgressHUD showErrorWithStatus:@"请输入创始人名称"];return;}
    //判断联系人号码
    if (self.contactPhoneTf.text.length == 0 || self.contactPhoneTf.text == nil) {
        [SVProgressHUD showErrorWithStatus:@"请输入联系人手机号"];
        return;
    }else{
        if (![self.contactPhoneTf.text validateMobile]) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
            return;
        }
    }


        NSDictionary *Parameter = @{@"clubName":self.clubNameTf.text,
                                    @"contactName":self.contactNameTf.text,
                                    @"contactPhone":self.contactPhoneTf.text,
                                    @"introduction":self.introductionView.text,
                                    @"limitGrade":limitGradeString,
                                    @"limitNum":self.limitNum,
                                    @"logoUrl":  self.logoUrl,
                                    @"open":self.isOpen
                                    };
    
        [ShareBusinessManager.userManager postMyClubCreateNewWithParameters:Parameter success:^(id responObject) {
                [SVProgressHUD showSuccessWithStatus:responObject];
                //更新首页俱乐部列表
                [self.navigationController popViewControllerAnimated:YES];
                [GOLFNotificationCenter postNotificationName:@"updateCreatedClubList" object:nil userInfo:nil];
            
        } failure:^(NSInteger errCode, NSString *errorMsg) {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }];

    
}

#pragma mark - 上传头像
-(void)upLoadIconWithImage:(UIImage*) image{
    
    if (image == nil) {
        [SVProgressHUD showInfoWithStatus:@"请添加图片"];
        return;
    }
    
        NSDictionary *parameter = @{@"file":@".png",
                                    @"menu":@"club"};
        [ShareBusinessManager.clubManager upLoadImageWith:@[image] parameters:parameter success:^(id responObject) {
            
            NSDictionary *dict = (NSDictionary *)responObject;
            self.imageUrlArray = [dict[@"data"] copy];
            self.logoUrl = self.imageUrlArray.firstObject;
            
        } failure:^(NSInteger errCode, NSString *errorMsg) {
            
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }];
    }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate
/** cell点击事件弹出选择器*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 1:
        {   //点击选等级限制
            [self alertViewNum:self.limitGradePickView];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [GOLFNotificationCenter postNotificationName:@"firstNumSelect" object:nil];
            });
        }
            break;
        case 2:
        {  //点击选择人数限制
            [self alertViewNum:self.limitNumPickView];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [GOLFNotificationCenter postNotificationName:@"firstNumSelect" object:nil];
            });
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 4;
    }else if(section == 1 || section == 2 || section == 3){
        return 1;
    }
        return 2;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CreatClubViewCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = FONT(12);
    cell.textLabel.textColor = SHENTEXTCOLOR;
    cell.accessoryView = [[UIImageView alloc] initWithImage:IMAGE(@"classify8")];
    cell.detailTextLabel.textColor = LIGHTTEXTCOLOR;
    cell.detailTextLabel.font = FONT(12);
    
    
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"俱乐部头像";
                cell.accessoryView = self.iconView;
            }else if(indexPath.row == 1){
                cell.textLabel.text = @"俱乐部名称";
                cell.accessoryView = self.clubNameTf;
            }else if(indexPath.row == 2){
                cell.textLabel.text = @"俱乐部简介";
                cell.accessoryView = nil;
            }else{
                [cell.contentView addSubview:self.introductionView];
                self.introductionView.frame = CGRectMake(11, 0, SCREEN_WIDTH-11, 90);
                cell.accessoryView = nil;
            }

        }
            break;
        case 1:{
            cell.textLabel.text = @"会员等级要求";
            cell.detailTextLabel.text = self.limitGradeNum;
        }
            break;
        case 2:{
            
            cell.textLabel.text = @"人数限制";
            cell.detailTextLabel.text = self.limitNum;
        }
            break;
        case 3:{
            
            cell.textLabel.text = @"公开俱乐部";
            cell.accessoryView = self.openView;
        }
            break;
        case 4:{
            
            if (indexPath.row == 0) {
                cell.textLabel.text = @"创始人";
                cell.accessoryView = self.contactNameTf;
            }else if (indexPath.row == 1) {
                cell.textLabel.text = @"联系方式";
                cell.accessoryView = self.contactPhoneTf;
            }

        }
            break;
            
        default:
            break;
    }
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 3) {
        return 90;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else{
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

#pragma mark - 弹窗选择器
- (void)alertViewNum:(STL_NumPickerView *)customView{
    STL_AlertCustomView *alert = [[STL_AlertCustomView alloc] initWithFrame:[UIScreen mainScreen].bounds customView:customView];
    customView.delegate = alert;
    [alert show];
}
#pragma mark - 选择器输出的选择数字
- (void)sureWithCount:(id)count andSelectedTag:(NSInteger)tag{
    
    switch (tag) {
        case 1:
            self.limitGradeNum = count;
            break;
        case 2:
            self.limitNum = [NSString stringWithFormat:@"%ld",[count integerValue]];
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

- (void)cancel{
    NSLog(@"取消选择");
}


#pragma mark - UITextViewDelegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:@"请填写俱乐部简介"]) {
        textView.text = @"";
    }
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    [self.introductionView resignFirstResponder];  //取消第一响应者
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"请填写俱乐部简介";
    }
}


#pragma mark - 点击UITextView的完成按钮
- (void) closeKeyBoard
{
    [self.introductionView resignFirstResponder];
}


#pragma mark - UITextFieldDelegate
#pragma mark - 键盘输入处理
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    GOLFWeakObj(self);
    NSLog(@"键盘高度%f",self.kbHeight);
    if (textField == self.contactNameTf || textField == self.contactPhoneTf) {
        [UIView animateWithDuration:_duration animations:^{
            weakself.tableView.transform = CGAffineTransformMakeTranslation(0, -self.kbHeight + 60);
        }];
    }
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger MAX_STARWORDS_LENGTH = 0;   //最大的字数限制
    UITextField *titleField = [[UITextField alloc] init];
    
    switch (textField.tag) {
        case 1://名称
            titleField = self.clubNameTf;
            MAX_STARWORDS_LENGTH = 15;
            break;
        case 4://创始人
            titleField = self.contactNameTf;
            MAX_STARWORDS_LENGTH = 20;
            break;
        case 5://联系人
            titleField = self.contactPhoneTf;
            MAX_STARWORDS_LENGTH = 11;
            break;
            
        default:
            break;
    }
    
    
    if (textField == titleField) {
        if (string.length == 0) return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > MAX_STARWORDS_LENGTH) {
            return NO;
        }
    }
    
    return YES;
}

- (void)textfieldTextDidChange:(UITextField *)textField
{
    NSInteger MAX_STARWORDS_LENGTH = 0; //最大的字数限制
    UITextField *titleField = [[UITextField alloc] init];
    
    switch (textField.tag) {
        case 1://名称
            titleField = self.clubNameTf;
            MAX_STARWORDS_LENGTH = 15;
            break;
        case 4://创始人
            titleField = self.contactNameTf;
            MAX_STARWORDS_LENGTH = 20;
            break;
        case 5://联系人
            titleField = self.contactPhoneTf;
            MAX_STARWORDS_LENGTH = 11;
            break;
            
        default:
            break;
    }
    if (textField == titleField) {
        if (textField.text.length > MAX_STARWORDS_LENGTH) {
            textField.text = [textField.text substringToIndex:MAX_STARWORDS_LENGTH];
            }
            
        }
}

//完成按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - 不符合输入规范的提示
-(void)textFieldDidEndEditing:(UITextField *)textField{
//    if (textField == self.contactPhoneTf) {
//        if (![self.contactPhoneTf.text validateMobile]) {
//            [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
//        }
//    }
}


#pragma mark - 触摸屏幕取消编辑
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - 重写高亮方法
- (void)setHighlighted:(BOOL)highlighted {
    
}
#pragma mark - 按钮切换
- (void)buttonClick:(UIButton *)button {
    
    if (button.selected) {
        return;
    }

    button.selected = !button.selected;
    
    if (button.tag == 100) {
        self.closeBtn.selected = false;
        self.isOpen = @"1";
    }else{
        self.openBtn.selected = false;
        self.isOpen = @"0";
    }
}

#pragma mark -懒加载控件
-(UIButton *)iconBtn{
    if (!_iconBtn) {
        _iconBtn = [[UIButton alloc] init];
        [_iconBtn setBackgroundColor:WHITECOLOR];
        [_iconBtn setBackgroundImage:Placeholder_small forState:UIControlStateNormal];
        [_iconBtn.layer setMasksToBounds:YES];
        [_iconBtn.layer setCornerRadius:18.0];//设置矩形四个圆角半径
        [_iconBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _iconBtn;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        _tableView.separatorColor = GRAYCOLOR;;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = YES;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.frame = CGRectMake(0, NaviBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NaviBar_HEIGHT - 60);
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CreatClubViewCellId];
    }
    return _tableView;
}

- (NSMutableArray *)imageAry{
    if (!_imageAry) {
        _imageAry = [NSMutableArray array];
    }
    return _imageAry;
}

-(NSString *)logoUrl{
    if (!_logoUrl) {
        _logoUrl = [NSString string];
    }
    return _logoUrl;
}

- (NSArray *)imageUrlArray{
    if (_imageUrlArray == nil) {
        _imageUrlArray = [[NSArray alloc] init];
    }
    return _imageUrlArray;
}


-(UIView *)iconView{
    if (!_iconView) {
        _iconView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 45)];
        self.iconBtn.frame = CGRectMake(105, 5, 35, 35);
        [_iconView addSubview:self.iconBtn];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:IMAGE(@"classify8")];
        [_iconView addSubview:imageView];
        imageView.sd_layout
        .centerYEqualToView(self.iconBtn)
        .leftSpaceToView(self.iconBtn,7)
        .widthIs(7)
        .heightIs(13);
    }
    return _iconView;
}
-(UIButton *)openBtn{
    if (!_openBtn) {
        _openBtn = [[UIButton alloc] init];
        [_openBtn setTitle:@"是" forState:UIControlStateNormal];
        _openBtn.tag = 100;
        _openBtn.titleLabel.font = FONT(12);
        [_openBtn setTitleColor:LIGHTTEXTCOLOR forState:UIControlStateNormal];
        [_openBtn setImage:IMAGE(@"classify167") forState:UIControlStateNormal];
        [_openBtn setImage:IMAGE(@"classify167") forState:UIControlStateHighlighted];
        [_openBtn setImage:IMAGE(@"classify166") forState:UIControlStateSelected];
        [_openBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_openBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
        [_openBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];

    }
    return _openBtn;
}

-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn= [[UIButton alloc] init];
        [_closeBtn setTitle:@"否" forState:UIControlStateNormal];
        _closeBtn.tag = 101;
        _closeBtn.titleLabel.font = FONT(12);
        [_closeBtn setTitleColor:LIGHTTEXTCOLOR forState:UIControlStateNormal];
        [_closeBtn setImage:IMAGE(@"classify167") forState:UIControlStateNormal];
        [_closeBtn setImage:IMAGE(@"classify167") forState:UIControlStateHighlighted];
        [_closeBtn setImage:IMAGE(@"classify166") forState:UIControlStateSelected];
        [_closeBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_closeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
        [_closeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];

    }
    return _closeBtn;
}

- (UITextField *)clubNameTf{
    if (!_clubNameTf) {
        _clubNameTf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 150, 45)];
        _clubNameTf.placeholder = @"请填写俱乐部名称";
        _clubNameTf.textColor = BLACKTEXTCOLOR;
        _clubNameTf.font = FONT(12);
        _clubNameTf.delegate = self;
        _clubNameTf.textAlignment =NSTextAlignmentRight;
        _clubNameTf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _clubNameTf.returnKeyType = UIReturnKeyDone;
        _clubNameTf.tag = 1;
        [_clubNameTf addTarget:self action:@selector(textfieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _clubNameTf;
}

- (UITextField *)contactNameTf{
    if (!_contactNameTf){
        _contactNameTf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 150, 45)];
        _contactNameTf.placeholder = @"请填写创始人";
        _contactNameTf.textColor = BLACKTEXTCOLOR;
        _contactNameTf.font = FONT(12);
        _contactNameTf.delegate = self;
        _contactNameTf.textAlignment =NSTextAlignmentRight;
        _contactNameTf.returnKeyType = UIReturnKeyDone;
        _contactNameTf.tag = 4;
        [_contactNameTf addTarget:self action:@selector(textfieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _contactNameTf;
}

- (UITextField *)contactPhoneTf{
    if (!_contactPhoneTf) {
        _contactPhoneTf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 150, 45)];
        _contactPhoneTf.placeholder = @"请填写联系方式";
        _contactPhoneTf.textColor = BLACKTEXTCOLOR;
        _contactPhoneTf.font = FONT(12);
        _contactPhoneTf.delegate = self;
        _contactPhoneTf.textAlignment =NSTextAlignmentRight;
        _contactPhoneTf.returnKeyType = UIReturnKeyDone;
        _contactPhoneTf.tag = 5;
        [_contactPhoneTf addTarget:self action:@selector(textfieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _contactPhoneTf;
}



- (UITextView *)introductionView{
    if (_introductionView== nil) {
        _introductionView = [[UITextView alloc] init];
        _introductionView.delegate = self;
        _introductionView.text = @"请填写俱乐部简介";
        _introductionView.textColor = LIGHTTEXTCOLOR;
        _introductionView.returnKeyType = UIReturnKeyDone;
        _introductionView.scrollEnabled = YES;//是否可以拖动
    }
    return _introductionView;
}


-(UIButton *)creatBtn{
    if (!_creatBtn) {
        _creatBtn = [[UIButton alloc] init];
        [_creatBtn setTitle:@"创建俱乐部" forState:UIControlStateNormal];
        [_creatBtn setBackgroundColor:[UIColor colorWithHex:0x2aa344]];
        [_creatBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        _creatBtn.titleLabel.font = FONT(15);
        [_creatBtn addTarget:self action:@selector(creatCLubClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _creatBtn;
}

-(UIView *)openView{
    if (!_openView) {
        _openView = [[UIView alloc] init];
        _openView.backgroundColor = WHITECOLOR;
        _openView.size = CGSizeMake(75, 45);
        self.openBtn.frame = CGRectMake(0, 0, _openView.bounds.size.width*0.5, _openView.bounds.size.height);
        [_openView addSubview:self.openBtn];
        self.closeBtn.frame = CGRectMake(CGRectGetMaxX(self.openBtn.frame), 0, _openView.bounds.size.width*0.5, _openView.bounds.size.height);
        [_openView addSubview: self.closeBtn];
    }
    return _openView;
}

- (STL_NumPickerView *)limitGradePickView{
    if (!_limitGradePickView) {
        NSMutableArray *Arys = [NSMutableArray arrayWithObjects:@"男爵",@"子爵",@"伯爵",@"侯爵",@"公爵",nil];
        _limitGradePickView = [[STL_NumPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 30, 350) title:@"选择限制等级" ary:@[Arys] tag:1];
        _limitGradePickView.delegate_2 = self;
    }
    return _limitGradePickView;
}

-(STL_NumPickerView *)limitNumPickView{
    if (!_limitNumPickView) {
        NSMutableArray *Arys = [NSMutableArray arrayWithObjects:@"50", @"100",@"150",@"200",nil];
        _limitNumPickView = [[STL_NumPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 30, 350) title:@"选择限制人数" ary:@[Arys] tag:2];
        _limitNumPickView.delegate_2 = self;
    }
    return _limitNumPickView;
}


@end
