//
//  XFPushPlugin.h
//  XFPush
//
//  Created by wangxuefeng on 16/10/20.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import <XFPlugin.h>
#import <UserNotifications/UserNotifications.h>

@protocol XFPushPluginDelegate <NSObject>

@optional

/**
 收到推送处理
 {
    aps =     {
        alert = "2019-09-18 09:48:10 \n\U8fd9\U662f\U6765\U81eaAPNs\U7684\U901a\U77e5";
        badge = 1;
        "mutable-content" = 1;
        sound = "chime.aiff";
    };
    "xg_media_resources" = "https://www.baidu.com";
 }
 */
- (void)didRecieveNotifiationWithInfo:(NSDictionary *)info;

@end

/**
 封装第三方推送插件，对外看不到第三方接口，可以随时更换第三方
 提供统一的调用和回调接口，不同版本的调用和回调都不同，封装以后，调用和回调使用统一的接口
 */
@interface XFPushPlugin : XFPlugin <UNUserNotificationCenterDelegate>

@property (weak, nonatomic) id<XFPushPluginDelegate> _Nullable delegate;

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
- (void)deviceNotificationIsAllowed:(nonnull void (^)(BOOL isAllowed))handler;

@end
