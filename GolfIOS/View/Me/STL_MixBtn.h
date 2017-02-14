//
//  STL_MixBtn.h
//  GolfIOS
//
//  Created by 李明星 on 2016/11/1.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STL_MixBtn : UIButton
/** 文字*/
@property (nonatomic, strong) UILabel *lb;

/** 创建图文混合按钮*/
- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title;

@end
