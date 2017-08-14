//
//  DDYTabBarController.m
//  DDYProject
//
//  Created by Rain Dou on 15/5/18.
//  Copyright © 2015年 634778311 All rights reserved.
//

#import "DDYTabBarController.h"
#import "DDYNavigationController.h"
#import "DDYTabBar.h"
#import "DDYAppDelegate.h"

#import "FirstVC.h"
#import "SecondVC.h"
#import "ThirdVC.h"
#import "FourthVC.h"

@interface DDYTabBarController ()<DDYTabBarDelegate>

@end

@implementation DDYTabBarController

#pragma mark 在init前调用一次
+ (void)initialize {
    
    //设置文字样式
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    NSDictionary *selectedAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                         NSFontAttributeName:[UIFont boldSystemFontOfSize:16]
                                         };
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttributes forState:UIControlStateSelected ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *tmpImage = [UIImage circleImageWithColor:[UIColor whiteColor] radius:28/2.0];

    [self addChildVC:[FirstVC vc].vcTitle(@"First") img:tmpImage selectedImg:tmpImage];
    [self addChildVC:[SecondVC vc].vcTitle(@"Second") img:tmpImage selectedImg:tmpImage];
    [self addChildVC:[ThirdVC vc].vcTitle(@"Third") img:tmpImage selectedImg:tmpImage];
    [self addChildVC:[FourthVC vc].vcTitle(@"Fourth") img:tmpImage selectedImg:tmpImage];
    [self setValue:[[DDYTabBar alloc] init] forKeyPath:@"tabBar"];
}

- (void)addChildVC:(UIViewController *)vc img:(UIImage *)img selectedImg:(UIImage *)selectedImg
{
    vc.tabBarItem.image = img;
    vc.tabBarItem.selectedImage = [selectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:[[DDYNavigationController alloc] initWithRootViewController:vc]];
}

#pragma mark - DDYTabBarDelegate代理方法
- (void)tabBarDidPlusBtn:(DDYTabBar *)tabBar
{

}

#pragma mark - 控制旋转屏幕
#pragma mark 支持旋转的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.selectedViewController supportedInterfaceOrientations];
}
#pragma mark 是否支持自动旋转
- (BOOL)shouldAutorotate
{
    return [self.selectedViewController shouldAutorotate];
}
#pragma mark 状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [self.selectedViewController preferredStatusBarStyle];
}

@end
