//
//  XFPushPlugin.h
//  XFPush
//
//  Created by wangxuefeng on 16/10/20.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import <XFPlugin.h>

#if __IPHONE_OS_VERSION_MAX_ALLOWED >=     __IPHONE_10_0

#import <UserNotifications/UserNotifications.h>

#endif

NS_ASSUME_NONNULL_BEGIN

@protocol XFPushPluginDelegate <NSObject>

@optional

- (void)didRecieveNotifiationWithInfo:(NSDictionary *)info;

#if __IPHONE_OS_VERSION_MAX_ALLOWED >=     __IPHONE_10_0
- (void)willPresentNotifiationWithInfo:(NSDictionary *)info withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler;
#endif

@end

/**
 封装第三方推送插件，对外看不到第三方接口，可以随时更换第三方
 提供统一的调用和回调接口，不同版本的调用和回调都不同，封装以后，调用和回调使用统一的接口
 */
@interface XFPushPlugin : XFPlugin <UNUserNotificationCenterDelegate>

@property (weak, nonatomic) id<XFPushPluginDelegate> delegate;

/**
 是否输出调试信息
 */
@property (nonatomic, assign) BOOL enableDebug;

+ (XFPushPlugin*)pushPluginWithAppID:(NSString *)appID appKey:(NSString *)appKey;

- (instancetype)initWithAppID:(NSString *)appID appKey:(NSString *)appKey;

/**
 @brief 查询设备通知权限是否被用户允许
 
 @param handler 查询结果的返回方法
 @note iOS 10 or later 回调是异步地执行
 */
+ (void)deviceNotificationIsAllowed:(nonnull void (^)(BOOL isAllowed))handler;

/**
 绑定账号
 
 @param account 要绑定的账号
 */
+ (void)bindAccount:(NSString *)account;

/**
 解绑账号

 @param account 要解绑的账号
 */
+ (void)unbindAccount:(NSString *)account;

@end

NS_ASSUME_NONNULL_END
