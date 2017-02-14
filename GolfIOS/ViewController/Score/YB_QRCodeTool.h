//
//  YB_QRCodeTool.h
//  GolfIOS
//
//  Created by Rock on 2016/12/25.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YB_QRCodeTool : NSObject

// 设置是否需要描绘二维码边框
@property (nonatomic, assign) BOOL isDrawQRCodeRect;


+ (instancetype)shareInstance;

// 开始扫描
- (void)beginScanInView:(UIView *)view result:(void(^)(NSArray<NSString *> *resultStrs))resultBlock;

// 停止扫描
- (void)stopScan;

// 设置兴趣点
- (void)setInsteretRect:(CGRect)originRect;


/**
 根据字符串生成二维码

 @param string 字符串
 @return 二维码图片
 */
+ (UIImage *)createQRCodeWithString:(NSString *)string;

@end
