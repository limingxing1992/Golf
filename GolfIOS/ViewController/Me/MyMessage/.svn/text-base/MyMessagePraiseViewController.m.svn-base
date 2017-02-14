//
//  MyMessagecommentViewController.m
//  GolfIOS
//
//  Created by mac mini on 16/11/17.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyMessagePraiseViewController.h"
#import "MyMessageSendPraiseCell.h"
#import "MymessageGetPraiseViewController.h"
#import "MymessageSendPraiseViewController.h"


@interface MyMessagePraiseViewController ()
/**容器*/
@property (nonatomic, strong) UIScrollView *contentScrollView;
/**我发出的赞*/
@property (nonatomic, strong) MymessageSendPraiseViewController *MymessageSendPraiseVc;
/**我收到的赞*/
@property (nonatomic, strong) MymessageGetPraiseViewController *MymessageGetPraiseVc;


@end

@implementation MyMessagePraiseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"我的赞";
    //显示分栏控制器
    self.isShowSegmentedControl = true;
    //设置分栏items
    self.SegmentedcontrolItems = [NSArray arrayWithObjects:@"我收到的赞",@"我发出的赞", nil];
    [self setUI];

}

-(void)setUI{
    //设置顶部视图
    [self setBaseUI];
    [self.view addSubview:self.contentScrollView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentScrollView.frame = CGRectMake(0, NaviBar_HEIGHT + 65, SCREEN_WIDTH, SCREEN_HEIGHT - NaviBar_HEIGHT -65);
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, SCREEN_HEIGHT - NaviBar_HEIGHT -65);


    
    //创建详细视图子控制器
    [self addChildViewController:self.MymessageGetPraiseVc];
    [self.contentScrollView addSubview:self.MymessageGetPraiseVc.tableView];
    //位置
    self.MymessageGetPraiseVc.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.contentScrollView.mj_h);
    //notice the sys done
    [self.MymessageGetPraiseVc didMoveToParentViewController:self];

    
    [self addChildViewController:self.MymessageSendPraiseVc];
    [self.contentScrollView addSubview:self.MymessageSendPraiseVc.tableView];
    self.MymessageSendPraiseVc.tableView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.contentScrollView.mj_h);
    [self.MymessageSendPraiseVc didMoveToParentViewController:self];
    
}

#pragma mark - 重写父类的点击方法
-(void)controlBtnClick:(UISegmentedControl *)control{
    
    NSLog(@"点击第%ld个按钮",control.selectedSegmentIndex);
    [UIView animateWithDuration:.2 animations:^{
        switch (control.selectedSegmentIndex) {
            case 0:
                 [self.contentScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
                break;
            case 1:
                 [self.contentScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
                break;
            default:
                break;
        }
    }];

}

#pragma mark - 懒加载
- (UIScrollView *)contentScrollView{
    if (_contentScrollView == nil) {
        _contentScrollView = [[UIScrollView alloc] init];
        _contentScrollView.backgroundColor = BACKGROUNDCOLOR;
        _contentScrollView.scrollEnabled = NO;
        _contentScrollView.pagingEnabled = YES;
        
    }
    return _contentScrollView;
}

-(MymessageGetPraiseViewController *)MymessageGetPraiseVc{
    if (!_MymessageGetPraiseVc) {
        _MymessageGetPraiseVc = [[MymessageGetPraiseViewController alloc] init];
    }
    return _MymessageGetPraiseVc;
}
-(MymessageSendPraiseViewController *)MymessageSendPraiseVc{
    if (!_MymessageSendPraiseVc) {
        _MymessageSendPraiseVc = [[MymessageSendPraiseViewController alloc] init];
    }
    return _MymessageSendPraiseVc;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
