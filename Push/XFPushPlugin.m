//
//  XFPushPlugin.m
//  XFPush
//
//  Created by wangxuefeng on 16/10/20.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import "XFPushPlugin.h"
#import <QQ_XGPush/XGPush.h>

@interface XFPushPlugin () <XGPushDelegate>

@end

@implementation XFPushPlugin

+ (XFPushPlugin *)pushPluginWithAppID:(NSString *)appID appKey:(NSString *)appKey {
    return [[XFPushPlugin alloc] initWithAppID:appID appKey:appKey];
}

- (instancetype)initWithAppID:(NSString *)appID appKey:(NSString *)appKey {
    return [super initWithAppKey:appID appSecret:appKey];
}

#pragma mark - UIApplicaionDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    if (self.shouldShowOpenAlert) {
        [[XGPush defaultManager] deviceNotificationIsAllowed:^(BOOL isAllowed) {
            if (isAllowed == NO) {
                NSLog(@"设备不允许推送");
            } else {
                NSLog(@"设备允许推送");
            }
        }];
    }
    
    [[XGPush defaultManager] startXGWithAppID:(int32_t)self.appKey.longLongValue appKey:self.appSecret delegate:self];
    
    return YES;
}

/**
 收到推送的回调
 @param application  UIApplication 实例
 @param userInfo 推送时指定的参数
 @param completionHandler 完成回调
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [[XGPush defaultManager] reportXGNotificationInfo:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
// iOS 10 新增回调 API
// App 用户点击通知
// App 用户选择通知中的行为
// App 用户在通知中心清除消息
// 无论本地推送还是远程推送都会走这个回调
#if __IPHONE_OS_VERSION_MAX_ALLOWED >=     __IPHONE_10_0
- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center 
      didReceiveNotificationResponse:(UNNotificationResponse *)response 
               withCompletionHandler:(void (^)(void))completionHandler {
    [[XGPush defaultManager] reportXGNotificationResponse:response];
    completionHandler();
}

// App 在前台弹通知需要调用这个接口
- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center
             willPresentNotification:(UNNotification *)notification 
               withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    [[XGPush defaultManager] reportXGNotificationInfo:notification.request.content.userInfo];
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}
#endif

/**
 @brief 监控信鸽推送服务地启动情况
 
 @param isSuccess 信鸽推送是否启动成功
 @param error 信鸽推送启动错误的信息
 */
- (void)xgPushDidFinishStart:(BOOL)isSuccess error:(nullable NSError *)error {
    if (self.enableDebug) {
        NSLog(@"信鸽推送启动%@",isSuccess?@"成功":@"失败");
        if (error) {
            NSLog(@"%@",error);
        }
    }
}

/**
 @brief 向信鸽服务器注册设备token的回调
 
 @param deviceToken 当前设备的token
 @param error 错误信息
 @note 当前的token已经注册过之后，将不会再调用此方法
 */
- (void)xgPushDidRegisteredDeviceToken:(nullable NSString *)deviceToken error:(nullable NSError *)error {
    if (self.enableDebug) {
        NSLog(@"xgPushDidRegisteredDeviceToken：%@",deviceToken);
        if (error) {
            NSLog(@"%@",error);
        }
    }
}

#pragma mark - Public

- (void)setEnableDebug:(BOOL)enableDebug {
    self.enableDebug = enableDebug;
    
    [[XGPush defaultManager] setEnableDebug:enableDebug];
}


/**
 @brief 查询设备通知权限是否被用户允许
 
 @param handler 查询结果的返回方法
 @note iOS 10 or later 回调是异步地执行
 */
- (void)deviceNotificationIsAllowed:(nonnull void (^)(BOOL isAllowed))handler {
    [[XGPush defaultManager] deviceNotificationIsAllowed:handler];
}

@end
