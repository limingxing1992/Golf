//
//  TSOClubIntroductionViewController.m
//  GolfIOS
//
//  Created by yangbin on 16/11/10.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOClubIntroductionViewController.h"
#import "ClubIntroModel.h"
#import <WebKit/WebKit.h>

@interface TSOClubIntroductionViewController ()

/**俱乐部id*/
@property (nonatomic, strong) NSString *clubId;
/**webView*/
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation TSOClubIntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    self.webView.frame = self.view.bounds;
    [self requestClubIntroduction];
}

- (void)setupUI{
    self.navTitle = @"俱乐部简介";
}

- (instancetype)initWithClubId:(NSString *)clubId{
    if (self = [super init]) {
        self.clubId = clubId;
    }
    return self;
}

#pragma mark - 请求数据

-(void)requestClubIntroduction{
    
    NSDictionary *parameter = @{@"clubId":self.clubId};
    [ShareBusinessManager.clubManager getClubIntroWithParameters:parameter success:^(id responObject) {
        ClubIntroModel *model = (ClubIntroModel *)responObject;
        if (model.errorCode.integerValue == 1) {
            
//            NSURLRequest *request = [NSURLRequest requestWithURL:<#(nonnull NSURL *)#>]
//            self.webView loadRequest:<#(nonnull NSURLRequest *)#>
        }else{
            [SVProgressHUD showErrorWithStatus:model.errorMsg];
        }
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
    
    
}


- (WKWebView *)webView{
    if (_webView == nil) {
        _webView = [[WKWebView alloc] init];
    }
    return _webView;
}
@end
