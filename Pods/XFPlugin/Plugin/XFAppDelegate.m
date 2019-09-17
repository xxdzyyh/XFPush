//
//  XFAppDelegate.m
//  FileShareTest
//
//  Created by wangxuefeng on 16/6/8.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import "XFAppDelegate.h"

@implementation XFAppDelegate

- (NSArray *)plugins {
    return [[XFPluginManager defaultManager] getAllPlugins];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)]) {
            [obj application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
    return YES;
}

#pragma mark - 应用状态转变

- (void)applicationWillResignActive:(UIApplication *)application {
    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(applicationWillResignActive:)]) {
            [obj applicationWillResignActive:application];
        }
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(applicationDidEnterBackground:)]) {
            [obj applicationDidEnterBackground:application];
        }
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(applicationWillEnterForeground:)]) {
            [obj applicationWillEnterForeground:application];
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(applicationDidBecomeActive:)]) {
            [obj applicationDidBecomeActive:application];
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(applicationWillTerminate:)]) {
            [obj applicationWillTerminate:application];
        }
    }
}

#pragma mark - 应用间交互

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    BOOL canOpen = NO;
    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(application:handleOpenURL:)]) {
            canOpen = [obj application:application handleOpenURL:url];
        }
    }
    return canOpen;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL canOpen = NO;
    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(application:openURL:sourceApplication:annotation:)]) {
            canOpen = [obj application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
        }
    }
    return canOpen;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    BOOL canOpen = NO;
    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(application:openURL:options:)]) {
            canOpen = [obj application:application openURL:url options:options];
        }
    }
    return canOpen;
}

#pragma mark - 推送相关

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(application:didReceiveRemoteNotification:)]) {
            [obj application:application didReceiveRemoteNotification:userInfo];
        }
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"%@",application.delegate);
    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)]) {
            [obj application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
        }
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(application:didReceiveLocalNotification:)]) {
            [obj application:application didReceiveLocalNotification:notification];
        }
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)]) {
            [obj application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
        }
    }
}

// iOS 10 新增回调 API
// App 用户点击通知
// App 用户选择通知中的行为
// App 用户在通知中心清除消息
// 无论本地推送还是远程推送都会走这个回调
#if __IPHONE_OS_VERSION_MAX_ALLOWED >=     __IPHONE_10_0

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:)]) {
            [(id<UNUserNotificationCenterDelegate>)obj userNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:completionHandler];
        }
    }
}

#endif

#pragma mark - setter & getter 

- (UIWindow *)window {
    if (_window == nil) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.backgroundColor = [UIColor whiteColor];
    }
    return _window;
}

- (XFPluginManager *)pluginManager {
    if (_pluginManager == nil) {
        _pluginManager = [XFPluginManager defaultManager];
    }
    return _pluginManager;
}

@end
