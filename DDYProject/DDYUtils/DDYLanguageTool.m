//
//  DDYLanguageTool.m
//  FireFly
//
//  Created by LingTuan on 17/9/25.
//  Copyright © 2017年 NAT. All rights reserved.
//

#import "DDYLanguageTool.h"

#define DDYLanguageSet @"DDYLanguageSet"

NSErrorDomain DDYLanguageErrorDomain = @"DDYLanguageErrorDomain";

@interface DDYLanguageTool ()

@end

@implementation DDYLanguageTool


#pragma mark - 单例对象
static DDYLanguageTool *_instance;

+ (instancetype)sharedManager {
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

#pragma mark 初始化
- (instancetype)init {
    if (self = [super init]) {
        NSString *currLanguage = DDYUserDefaultsGet(DDYLanguageSet);
        // 默认语言(中英)
        if (!currLanguage) {
            currLanguage = DDYStr(DDY_CN, DDY_EN);
            DDYInfoLog(@"11111111 %@",currLanguage);
        }
        DDYInfoLog(@"3333333333 %@",currLanguage);
        DDYUserDefaultsSet(currLanguage, DDYLanguageSet)
        [DDYUserDefaults synchronize];
        [NSBundle ddy_Language:currLanguage];
    }
    return self;
}

#pragma mark 获取当前语言
- (NSString *)localLanguage {
    return DDYUserDefaultsGet(DDYLanguageSet);
}

#pragma mark 切换语言(中英时)
- (void)changeLanguage {
    [DDYUserDefaults setObject:[DDYUserDefaultsGet(DDYLanguageSet) isEqualToString:DDY_CN] ? DDY_EN : DDY_CN forKey:DDYLanguageSet];
    [DDYUserDefaults synchronize];
}

#pragma mark 设置语言(较多语言支持时)
- (void)setLanguage:(NSString *)language callback:(void (^)(NSError *error))callback {
    if ([language ddy_blankString]) {
        if (callback) callback([NSError errorWithDomain:DDYLanguageErrorDomain code:kDDYLanguageErrorNil userInfo:@{@"reason":@"设置的语言不能为空"}]);
    } else {
        [NSBundle ddy_Language:language];
        [DDYUserDefaults setObject:language forKey:DDYLanguageSet];
        [DDYUserDefaults synchronize];
        if (callback) callback([NSError errorWithDomain:DDYLanguageErrorDomain code:kDDYLanguageErrorSuccess userInfo:@{@"reason":@"设置成功"}]);
    }
}

@end
