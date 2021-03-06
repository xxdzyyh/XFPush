//
//  XFPushPlugin.m
//  XFPush
//
//  Created by wangxuefeng on 16/10/20.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import "XFPushPlugin.h"
#import <QQ_XGPush/XGPush.h>

@interface XFPushPlugin () <XGPushDelegate,XGPushTokenManagerDelegate>

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
    [[XGPush defaultManager] startXGWithAppID:(int32_t)self.appKey.longLongValue appKey:self.appSecret delegate:self];
    [XGPushTokenManager defaultTokenManager].delegate = self;
    return YES;
}

/**
 收到推送的回调 [iOS7 - iOS 10)
 @param application  UIApplication 实例
 @param userInfo 推送时指定的参数
 @param completionHandler 完成回调
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [[XGPush defaultManager] reportXGNotificationInfo:userInfo];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didRecieveNotifiationWithInfo:)]) {
        [self.delegate didRecieveNotifiationWithInfo:userInfo];
    }

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
    
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didRecieveNotifiationWithInfo:)]) {
            [self.delegate didRecieveNotifiationWithInfo:userInfo];
        }
    }
        
    completionHandler();
}

// App 在前台弹通知需要调用这个接口
- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center
             willPresentNotification:(UNNotification *)notification 
               withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    [[XGPush defaultManager] reportXGNotificationInfo:notification.request.content.userInfo];
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(willPresentNotifiationWithInfo:withCompletionHandler:)]) {
            [self.delegate willPresentNotifiationWithInfo:userInfo withCompletionHandler:completionHandler];
        }
    }
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

#pragma mark - XGPushTokenManagerDelegate

/**
 @brief 监控token对象绑定的情况
 
 @param identifier token对象绑定的标识
 @param type token对象绑定的类型
 @param error token对象绑定的结果信息
 */
- (void)xgPushDidBindWithIdentifier:(nonnull NSString *)identifier 
                               type:(XGPushTokenBindType)type 
                              error:(nullable NSError *)error {
    if (self.enableDebug) {
        NSLog(@"xgPushDidBindWithIdentifier identifier: %@",identifier);
        if (error) {
            NSLog(@"xgPushDidBindWithIdentifier error : %@",error);
        }
    }
}

/**
 @brief 监控token对象解绑的情况
 
 @param identifier token对象解绑的标识
 @param type token对象解绑的类型
 @param error token对象解绑的结果信息
 */
- (void)xgPushDidUnbindWithIdentifier:(nonnull NSString *)identifier 
                                 type:(XGPushTokenBindType)type 
                                error:(nullable NSError *)error {
    if (self.enableDebug) {
        NSLog(@"xgPushDidUnbindWithIdentifier identifier: %@",identifier);
        if (error) {
            NSLog(@"xgPushDidUnbindWithIdentifier error : %@",error);
        }
    }
}

#pragma mark - Public

- (void)setEnableDebug:(BOOL)enableDebug {
    _enableDebug = enableDebug;
    
    [[XGPush defaultManager] setEnableDebug:enableDebug];
}

+ (void)deviceNotificationIsAllowed:(nonnull void (^)(BOOL isAllowed))handler {
    [[XGPush defaultManager] deviceNotificationIsAllowed:handler];
}

+ (void)bindAccount:(NSString *)account {
    [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:account type:XGPushTokenBindTypeAccount];
}

+ (void)unbindAccount:(NSString *)account {
    [[XGPushTokenManager defaultTokenManager] unbindWithIdentifer:account type:XGPushTokenBindTypeAccount];
}

@end
