//
//  WYAlertView.h
//  test
//
//  Created by wyao on 2016/11/23.
//  Copyright © 2016年 wyao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertResult)(NSInteger index);

@interface WYAlertView : UIView

@property (nonatomic,copy) AlertResult resultIndex;

- (instancetype)initWithTitle:(NSString *)title
                    titleFont:(CGFloat)titleFont
                    titleBold:(BOOL)titleIsBold
                   titleColor:(UIColor*)titleColor
                      message:(NSString *)message
                  messageFont:(CGFloat)messageFont
                  messageBold:(BOOL)messageIsBold
                 messageColor:(UIColor*)messageColor
                     rightBtn:(NSString *)rightTitle
           rightBtnTitleColor:(UIColor *)rightBtnTitleColor
            rightBtnTitleFont:(CGFloat)rightBtnTitleFont
                      leftBtn:(NSString *)leftTitle
            leftBtnTitleColor:(UIColor *)leftBtnTitleColor
             leftBtnTitleFont:(CGFloat)leftBtnTitleFont;

- (void)showAlertView:(void (^)(NSInteger index))completion;

@end
