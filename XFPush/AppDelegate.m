//
//  AppDelegate.m
//  XFPush
//
//  Created by wangxuefeng on 16/10/18.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import "AppDelegate.h"
#import "XFPushPlugin.h"

@interface AppDelegate()<XFPushPluginDelegate>

@end
@implementation AppDelegate

- (instancetype)init {
    self = [super init];
    if (self) {
        XFPushPlugin *plugin = [XFPushPlugin pushPluginWithAppID:@"2200343448" appKey:@"I1E8M5F91QDH"];
        plugin.enableDebug = YES;
        plugin.delegate = self;
        [self.pluginManager addPlugin:plugin withName:plugin.name];
    }
    return self;
}

- (void)didRecieveNotifiationWithInfo:(NSDictionary *)info {
    NSLog(@"%@",info);
}

@end
