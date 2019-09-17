//
//  XFPluginManager.m
//  FileShareTest
//
//  Created by wangxuefeng on 16/6/7.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import "XFPluginManager.h"

@interface XFPluginManager () 

@property (strong, nonatomic) NSMutableDictionary *plugins;

@end

static XFPluginManager * _share = nil;

@implementation XFPluginManager

+ (XFPluginManager *)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _share = [XFPluginManager new];
    });
    return _share;
}

- (void)addPlugin:(XFPlugin *)plugin withName:(NSString *)name {
    if (_plugins == nil) {
        _plugins = [NSMutableDictionary dictionary];
    }

    if ([self.plugins.allKeys containsObject:name]) {
        NSAssert(0, @"该名称已被使用");
    }
    
    NSAssert(plugin != nil, @"为什么要注册一个空的plugin");
    [_plugins setObject:plugin forKey:name];
}

- (XFPlugin *)pluginWithName:(NSString *)name {
    return [_plugins objectForKey:name];
}

- (NSArray *)getAllPlugins {
    return _plugins.allValues;
}

@end
