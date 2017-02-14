//
//  TSOScoreQRCodeVC.m
//  GolfIOS
//
//  Created by Rock on 2016/12/25.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TSOScoreQRCodeVC.h"
#import "YB_QRCodeTool.h"
#import "ScoreUserModel.h"
#import "TSOGroupingViewController.h"
#define Lance 260 *KHeight_Scale
@interface TSOScoreQRCodeVC ()

/** 背景框*/
@property (nonatomic, strong) UIImageView *frameIv;
/** 上条*/
@property (nonatomic, strong) UIImageView *upIv;
/** 下条*/
@property (nonatomic, strong) UIImageView *downIv;

@end

@implementation TSOScoreQRCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle= @"扫一扫";
    
    [self.view addSubview:self.frameIv];

    self.frameIv.size = CGSizeMake(260 *KHeight_Scale, 260 *KHeight_Scale);
    self.frameIv.center =  self.view.center;
    [self.frameIv addSubview:self.upIv];
    [self.frameIv addSubview:self.downIv];
    //设置起始位置
    self.upIv.frame = CGRectMake(0, 0, Lance, 15);
    
    [self upAnimation];
    [self beginScan];
}

- (void)viewDidDisappear:(BOOL)animated{
     [[YB_QRCodeTool shareInstance] stopScan];
}

// 开始扫描
- (void)beginScan{
    
    [YB_QRCodeTool shareInstance].isDrawQRCodeRect = NO;
    CGFloat x = self.frameIv.frame.origin.x / SCREEN_WIDTH;
    CGFloat y = self.frameIv.frame.origin.y / SCREEN_HEIGHT;
    CGFloat width = self.frameIv.frame.size.width / SCREEN_WIDTH;
    CGFloat height = self.frameIv.frame.size.height / SCREEN_HEIGHT;

    [[YB_QRCodeTool shareInstance] setInsteretRect:CGRectMake(y, x, height, width)];
    
    [[YB_QRCodeTool shareInstance] beginScanInView:self.view result:^(NSArray<NSString *> *resultStrs) {
        if (resultStrs) {
            [[YB_QRCodeTool shareInstance] stopScan];
           NSLog(@"=======resultStrs=====%@",resultStrs[0]);
            [self requestAddGroupWithUserID:resultStrs[0]];
        
        }
    }];

}
     
- (void)requestAddGroupWithUserID:(NSString*)userId{
    [ShareBusinessManager.scoreManager scanAddWithParameters:@{@"userId":userId} success:^(id responObject) {
        ScoreUserModel *model = (ScoreUserModel *)responObject;
        if (model.errorCode.integerValue == 1) {
            
            TSOGroupingViewController *groupIngVC = [[TSOGroupingViewController alloc]initWithUser:model];
            groupIngVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:groupIngVC animated:YES];
            
        }else{
            [SVProgressHUD showErrorWithStatus:model.errorMsg];
        }
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}

- (void)upAnimation{
    self.upIv.image = IMAGE(@"greenbar1");
    [UIView animateWithDuration:3.0f animations:^{
        self.upIv.frame = CGRectMake(0, Lance - 17, Lance, 15);
    } completion:^(BOOL finished) {
        [self downAnimaiton];
    }];
}

- (void)downAnimaiton{
    self.upIv.image = IMAGE(@"greenbar2");
    [UIView animateWithDuration:3.0f animations:^{
        self.upIv.frame = CGRectMake(0, 0, Lance, 15);
    } completion:^(BOOL finished) {
        [self upAnimation];
    }];
}

- (UIImageView *)frameIv{
    if (!_frameIv) {
        _frameIv = [[UIImageView alloc] init];
        _frameIv.image = IMAGE(@"yb_frame");
    }
    return _frameIv;
}

- (UIImageView *)upIv{
    if (!_upIv) {
        _upIv = [[UIImageView alloc] init];
        _upIv.image = IMAGE(@"greenbar2");
    }
    return _upIv;
}

- (UIImageView *)downIv{
    if (!_downIv) {
        _downIv = [[UIImageView alloc] init];
        _downIv.image = IMAGE(@"greenbar1");
    }
    return _downIv;
}

@end
