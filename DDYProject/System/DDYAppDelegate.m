//
//  AppDelegate.m
//  DDYProject
//
//  Created by RainDou on 15/5/18.
//  Copyright © 2015年 RainDou All rights reserved.
//

#import "DDYAppDelegate.h"
#import "DDYTabBarController.h"

@interface DDYAppDelegate ()

@end

@implementation DDYAppDelegate

void UncaughtExceptionHandler(NSException *exception) {
    NSArray  *callStackSymbols = [exception callStackSymbols];
    NSString *callStackSymbolStr = [callStackSymbols componentsJoinedByString:@"\n"];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    DDYInfoLog(@"异常名称：%@\n异常原因：%@\n堆栈标志：%@",name, reason, callStackSymbolStr);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.window makeKeyAndVisible];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    DDYTabBarController *vc = [[DDYTabBarController alloc] init];

    self.window.rootViewController = vc;    
    
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
    
    [self creatShortcutItem];
    UIApplicationShortcutItem *shortcutItem = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
    /** app不在后台(已杀死),处理逻辑,返回NO,不调用 -application:performActionForShortcutItem:completionHandler: */
    if (shortcutItem) {
        if([shortcutItem.type isEqualToString:@"open_search"]){
            DDYInfoLog(@"open_search");
        } else if ([shortcutItem.type isEqualToString:@"open_qrcode"]) {
            DDYInfoLog(@"open_qrcode");
        }
        return NO;
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // 挂起方法:按home,用这个方法去暂停正在执行的任务,中止定时器,减小OpenGL ES比率,暂停游戏
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // 进后台方法:减少共享资源,保存用户数据,销毁定时器,保存应用状态。
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // 进前台方法
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // 复原方法:应用非活动状态时,重新启动已暂停(或尚未启动)的任务。
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // 当应用程序即将终止时调用。
}

#pragma mark - 3D Touch
#pragma mark 创建3DTouch列表
- (void)creatShortcutItem {
    // 创建系统风格的icon
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare];
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:@"open_search" localizedTitle:@"分享" localizedSubtitle:@"分享副标题" icon:icon1 userInfo:nil];
    
    // 创建自定义图标的icon
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"qrcode"];
    UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc] initWithType:@"open_qrcode" localizedTitle:@"扫描" localizedSubtitle:@"扫描副标题" icon:icon2 userInfo:nil];
    
    // 添加到快捷选项数组
    [UIApplication sharedApplication].shortcutItems = @[item1, item2];
}

#pragma mark 修改3DTouch列表标签
- (void)editShortcutItem {
    // 获取第0个shortcutItem
    UIApplicationShortcutItem *shortcutItem = [[UIApplication sharedApplication].shortcutItems objectAtIndex:0];
    // 将shortcutItem0的类型由UIApplicationShortcutItem改为可修改类型UIMutableApplicationShortcutItem
    UIMutableApplicationShortcutItem *item = [shortcutItem mutableCopy];
    // 修改shortcutItem的标题
    [item setLocalizedTitle:@"修改"];
    [item setLocalizedSubtitle:@"修改副标题"];
    [item setIcon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAlarm]];
    // 将shortcutItems数组改为可变数组
    NSMutableArray *itemArray = [[UIApplication sharedApplication].shortcutItems mutableCopy];
    // 替换原ShortcutItem
    [itemArray replaceObjectAtIndex:0 withObject:item];
    [UIApplication sharedApplication].shortcutItems = itemArray;
}

#pragma mark 后台状态点击3DTouch选项进入APP
/** app不在后台(已杀死)，则处理逻辑在 -application:didFinishLaunchingWithOptions:中 */
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    
    if (shortcutItem) {
        if([shortcutItem.type isEqualToString:@"open_search"]){
            DDYInfoLog(@"open_search");
        } else if ([shortcutItem.type isEqualToString:@"open_qrcode"]) {
            DDYInfoLog(@"open_qrcode");
            [self editShortcutItem];
        }
    }
    
    if (completionHandler) {
        completionHandler(YES);
    }
}

- (NSInteger)numberWithHexString:(NSString *)hexString{
    
    const char *hexChar = [hexString cStringUsingEncoding:NSUTF8StringEncoding];
    
    int hexNumber;
    
    sscanf(hexChar, "%x", &hexNumber);
    
    return (NSInteger)hexNumber;
}


@end
