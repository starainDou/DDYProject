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

@end
