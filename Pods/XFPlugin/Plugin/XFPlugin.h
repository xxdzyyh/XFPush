//
//  XFPlugin.h
//  FileShareTest
//
//  Created by wangxuefeng on 16/6/7.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface XFPlugin : NSObject <UIApplicationDelegate>

// 插件名称，默认为类名
@property (copy  , nonatomic) NSString *name;


/**
 一般插件是基于第三方的，需要appKey,appSecret
 */
@property (copy  , nonatomic) NSString *appKey;
@property (copy  , nonatomic) NSString *appSecret;

- (instancetype)initWithAppkey:(NSString *)appkey;

- (instancetype)initWithAppkey:(NSString *)appkey
                     appSecret:(NSString *)appSecret;

@end
