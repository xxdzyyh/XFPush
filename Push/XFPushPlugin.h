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

- (void)didRecieveNotifiationWithInfo:(NSDictionary *)info;

@end

/**
 封装第三方推送插件，对外看不到第三方接口，可以随时更换第三方
 提供统一的调用和回调接口，不同版本的调用和回调都不同，封装以后，调用和回调使用统一的接口
 */
@interface XFPushPlugin : XFPlugin <UNUserNotificationCenterDelegate>

@property (weak, nonatomic) id<XFPushPluginDelegate> delegate;

+ (XFPushPlugin*)pushPluginWithAppkey:(NSString *)appkey;

@end