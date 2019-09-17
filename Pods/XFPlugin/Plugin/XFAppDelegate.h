//
//  XFAppDelegate.h
//  FileShareTest
//
//  Created by wangxuefeng on 16/6/8.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XFPlugin.h"
#import "XFPluginManager.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0

#import <UserNotifications/UserNotifications.h>

@interface XFAppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>

#else

@interface XFAppDelegate : UIResponder <UIApplicationDelegate>

#endif


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) XFPluginManager *pluginManager;

@end
