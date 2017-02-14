//
//  MyMessagecommentViewController.m
//  GolfIOS
//  Created by mac mini on 16/11/17.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyMessageCommentViewController.h"
#import "MyMessageCommentCell.h"
#import "MyMessageGetCommentViewController.h"
#import "MyMessageSendCommentViewController.h"


@interface MyMessageCommentViewController ()
/**容器*/
@property (nonatomic, strong) UIScrollView *contentScrollView;
/**我发出的评论*/
@property (nonatomic, strong) MyMessageSendCommentViewController *MymessageSendCommentVc;
/**我收到的评论*/
@property (nonatomic, strong) MyMessageGetCommentViewController *MymessageGetCommentVc;


@end

@implementation MyMessageCommentViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"我的评论";
    //显示分栏控制器
    self.isShowSegmentedControl = true;
    //设置分栏items
    self.SegmentedcontrolItems = [NSArray arrayWithObjects:@"我收到的评论",@"我发出的评论", nil];
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
    [self addChildViewController:self.MymessageGetCommentVc];
    [self.contentScrollView addSubview:self.MymessageGetCommentVc.tableView];
    //位置
    self.MymessageGetCommentVc.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.contentScrollView.mj_h);
    //notice the sys done
    [self.MymessageGetCommentVc didMoveToParentViewController:self];
    
    
    [self addChildViewController:self.MymessageSendCommentVc];
    [self.contentScrollView addSubview:self.MymessageSendCommentVc.tableView];
    self.MymessageSendCommentVc.tableView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.contentScrollView.mj_h);
    [self.MymessageSendCommentVc didMoveToParentViewController:self];
    
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


-(MyMessageSendCommentViewController *)MymessageSendCommentVc{
    if (!_MymessageSendCommentVc) {
        _MymessageSendCommentVc = [[MyMessageSendCommentViewController alloc] init];
    }
    return _MymessageSendCommentVc;

}
-(MyMessageGetCommentViewController *)MymessageGetCommentVc{
    if (!_MymessageGetCommentVc) {
        _MymessageGetCommentVc = [[MyMessageGetCommentViewController alloc] init];
    }
    return _MymessageGetCommentVc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
