//
//  AppDelegate.m
//  GolfIOS
//
//  Created by 张永亮 on 2016/10/24.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "AppDelegate.h"
#import "TSOTabBarController.h"
#import <MJExtension.h>
#import <UMSocialWechatHandler.h>
#import <UMSocialQQHandler.h>

@interface AppDelegate ()
<
    BMKLocationServiceDelegate,
    WXApiDelegate,
    JPUSHRegisterDelegate
>
@property (nonatomic, strong) BMKLocationService *locService;//定位工具类

@end

@implementation AppDelegate

/** 进入主界面*/
- (void)entoMainUI{
    TSOTabBarController *tabBar = [[TSOTabBarController alloc] init];
    self.window.rootViewController = tabBar;
}
/** 设置SVProgessHUD*/
- (void)settingSVProgressHUD{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0.000 green:0.020 blue:0.059 alpha:0.85]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
}
/** 设置程序API*/
- (void)settingAPI{
    //初始化服务器，默认为正式服务器
    if (![GOLFUserDefault objectForKey:@"currentAPI"]) {
        [GOLFUserDefault setObject:RealAPI forKey:@"currentAPI"];
    }
}
/** 读取用户资料*/
- (void)readUserInfo{
    NSDictionary *data = [GOLFUserDefault objectForKey:@"userInfo"];
    if (data) {
        [[UserModel sharedUserModel] mj_setKeyValues:data];
        [[UserModel sharedUserModel] setIsLogin:NO];//初始化登录状态
        //利用缓存数据。做一次登录请求刷新用户数据
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:@{@"deviceType":@1,@"userName":[UserModel sharedUserModel].userName, @"password":[UserModel sharedUserModel].password}];
        [ShareBusinessManager.loginManager postLoginWithParameters:dict success:^(id responObject) {
            [[UserModel sharedUserModel] setIsLogin:YES];//修改登录状态
        } failure:^(NSInteger errCode, NSString *errorMsg) {
            [SVProgressHUD showErrorWithStatus:errorMsg];
            [UserModel attempDealloc];
        }];
    }
}


#pragma mark ----------------locationServiceDelegate

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    [self.locService stopUserLocationService];//停止定位
    NSString * longti = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
    NSString * lanti = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
    //存储到userDefault
    [GOLFUserDefault setObject:longti forKey:@"longti"];
    [GOLFUserDefault setObject:lanti forKey:@"latti"];
    //定位成功
    _locService.delegate = nil;
}

- (void)didFailToLocateUserWithError:(NSError *)error{
    //定位失败进行数据获取。（根据上次定位位置）
    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"定位失败：%@",error.description]];
    _locService.delegate = nil;
}

- (BMKLocationService *)locService{
    if (_locService == nil) {
        _locService = [[BMKLocationService alloc] init];
        _locService.distanceFilter = 100;
        _locService.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _locService;
    
}
/** 开始定位*/
- (void)startLoacation{
    [self.locService startUserLocationService];
    _locService.delegate = self;
}
/** 友盟设置*/
- (void)settingUMAPI{
    [[UMSocialManager defaultManager] openLog:NO];
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5857438faed179424e00273b"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105863021" appSecret:nil redirectURL:nil];
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAppID appSecret:WXSercret redirectURL:nil];//如果项目中单独集成微信支付，那么友盟需要注销对微信注册。否则会引起冲突，并且在登录的时候友盟包会先使用code，导致微信sdk无法正常走通
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformType:UMSocialPlatformType_WechatFavorite];
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformType:UMSocialPlatformType_Sina];
}
/** 注册微信支付*/
- (void)setWxApiPay{
    [WXApi registerApp:@"wx7a25750ee0abd6de"];
}
/** 设置引导页*/
- (void)appVersionSelect{
    
    
    NSString *appVersion = [GOLFUserDefault valueForKey:@"appVersion"];
    
    if (appVersion == nil || ![appVersion isEqualToString:GOLF_VERSIONString]) {
        NSLog(@"第一次启动或者版本更新");
        [GOLFUserDefault setValue:GOLF_VERSIONString forKey:@"appVersion"];
        GuideViewController *guidevc = [[GuideViewController alloc] init];
        GOLFWeakObj(self);
        guidevc.block = ^(){
            [weakself entoMainUI];
        };
        self.window.rootViewController = guidevc;
    }else{
        [self entoMainUI];
    }
}
/** 注册极光*/
- (void)settingJPushWith:(NSDictionary *)options{
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:options appKey:@"a54e00ec6651ed22b279dfb8" channel:nil apsForProduction:YES];
    [GOLFNotificationCenter addObserver:self selector:@selector(jPushLoginSuccess:) name:kJPFNetworkDidLoginNotification object:nil];//监听极光登录成功
    [GOLFNotificationCenter addObserver:self selector:@selector(jPushLoginSuccess:) name:LoginSuccess object:nil];//监听登录成功
    [JPUSHService resetBadge];//清空角标
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];//清空本地角标
}

#pragma mark ----------------主程序

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = BACKGROUNDCOLOR;
    [self appVersionSelect];                                       //进行版本判断。是否初次启动或更新版本
    [self settingSVProgressHUD];//设置HUD
    [self settingAPI];          //设置API
    [self setWxApiPay];         //注册微信支付
    //注册用户资料刷新
    [GOLFNotificationCenter addObserver:self selector:@selector(readUserInfo) name:UserInfoUpdate object:nil];
    [self readUserInfo];        //读取用户资料
    [self startLoacation];        //开启定位读取用户位置
    [self settingUMAPI];            //设置友盟
    [self settingJPushWith:launchOptions];//设置极光推送
    [CommonUncaughtExceptionHandler setDefaultHandler];//异常捕捉

    
    [self.window makeKeyAndVisible];
    return YES;


}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

/** 极光推送回调注册token*/
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}


/** 获取token失败*/
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)jPushLoginSuccess:(NSNotification *)fication{
    
    if (IsLogin) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [JPUSHService setAlias:[UserModel sharedUserModel].ID callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
        });
    }
}


/** 设置别名回调*/
-(void)tagsAliasCallback:(int)iResCode
                    tags:(NSSet*)tags
                   alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

#pragma mark ----------------支付。微信登录回调

//9.0前的方法，为了适配低版本 保留
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
}


// 仅支持iOS9以上系统，iOS8及以下系统不会回调
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    
    [WXApi handleOpenURL:url delegate:self];

    if (!result) {
        if ([url.host isEqualToString:@"safepay"]) {
            
            // 支付跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                [GOLFNotificationCenter postNotificationName:PayResult object:nil userInfo:@{@"code":resultDic[@"resultStatus"]}];
            }];
            
            // 授权跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
                // 解析 auth code
                NSString *result = resultDic[@"result"];
                NSString *authCode = nil;
                if (result.length>0) {
                    NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                    for (NSString *subResult in resultArr) {
                        if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                            authCode = [subResult substringFromIndex:10];
                            break;
                        }
                    }
                }
            }];
        }
        return  YES;
    }

    return result;
}

- (void)onResp:(BaseResp*)resp
{
    //启动微信支付的response
    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case 0:
                payResoult = @"支付结果：成功！";
                break;
            case -1:
                payResoult = @"支付结果：失败！";
                break;
            case -2:
                payResoult = @"用户已经退出支付！";
                break;
            default:
                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                break;
        }
        [GOLFNotificationCenter postNotificationName:PayResult object:nil userInfo:@{@"code":[NSNumber numberWithInt:resp.errCode]}];
    }else{
        [GOLFNotificationCenter postNotificationName:@"wxLoginName" object:nil userInfo:@{@"wxLogin":resp}];
    }
    
}


@end
