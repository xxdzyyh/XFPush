//
//  AppDelegate.m
//  XFPush
//
//  Created by wangxuefeng on 16/10/18.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import "AppDelegate.h"
#import "XFPushPlugin.h"

@implementation AppDelegate

- (instancetype)init {
    self = [super init];
    if (self) {
        XFPushPlugin *plugin = [XFPushPlugin pushPluginWithAppID:@"2200342513" appKey:@"I351VD31NEIH"];
        plugin.enableDebug = YES;
        plugin.shouldShowOpenAlert = YES;
        [self.pluginManager addPlugin:plugin withName:plugin.name];
    }
    return self;
}

@end
