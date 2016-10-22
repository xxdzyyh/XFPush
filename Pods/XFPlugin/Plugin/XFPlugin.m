//
//  XFPlugin.m
//  FileShareTest
//
//  Created by wangxuefeng on 16/6/7.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import "XFPlugin.h"

@implementation XFPlugin

@synthesize name = _name;

#pragma mark - life cycle

- (instancetype)initWithAppkey:(NSString *)appkey appSecret:(NSString *)appSecret {
    self = [super init];
    if (self) {
        _appKey = appkey;
        _appSecret = appSecret;
    }
    return self;
}

- (instancetype)initWithAppkey:(NSString *)appkey {
    self = [self initWithAppkey:appkey appSecret:nil];
    
    return self;
}

#pragma mark - setter & getter

- (NSString *)name {
    if (_name == nil) {
        _name = NSStringFromClass([self class]);
    }
    return _name;
}

@end
