//
//  LoginTieViewController.h
//  GolfIOS
//
//  Created by 李明星 on 2016/12/21.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "STL_BaseViewController.h"

@class UMSocialUserInfoResponse;

@interface LoginTieViewController : STL_BaseViewController

@property (nonatomic, strong) UMSocialUserInfoResponse *response;

@property (nonatomic, copy) NSString *type;


@end
