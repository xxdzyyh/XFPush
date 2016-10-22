//
//  AppDelegate.m
//  XFPush
//
//  Created by wangxuefeng on 16/10/18.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import "AppDelegate.h"
#import "XFPushPlugin.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (instancetype)init {
    self = [super init];
    if (self) {
        XFPushPlugin *plugin = [XFPushPlugin pushPluginWithAppkey:PushKey];
        
        [self.pluginManager addPlugin:plugin withName:plugin.name];
    }
    return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
