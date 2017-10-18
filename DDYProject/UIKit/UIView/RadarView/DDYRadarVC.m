//
//  DDYRadarVC.m
//  DDYProject
//
//  Created by ShangHaiSheQuan on 15/12/19.
//  Copyright © 2015年 Starain. All rights reserved.
//

#import "DDYRadarVC.h"

@interface DDYRadarVC ()<DDYRadarViewDataSource, DDYRadarViewDelegate>

@property (nonatomic, strong) DDYRadarView *radarView;

@end

@implementation DDYRadarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.radarView startScanAnimation];
    [self.radarView reloadData];
    [self addObserverActive];
}

- (DDYRadarView *)radarView {
    if (!_radarView) {
        _radarView = [DDYRadarView radarView];
        _radarView.dataSource = self;
        _radarView.delegate = self;
        _radarView.indicatorStartColor = DDYRGBA(220, 190, 50, 1);
        _radarView.indicatorEndColor = DDYRGBA(220, 190, 50, 0);
        _radarView.indicatorAngle = 240;
        _radarView.indicatorSpeed = 140;
        _radarView.backgroundImage = [UIImage imageNamed:@"radarBg"];
        [self.view addSubview:self.radarView];
    }
    return _radarView;
}

- (NSInteger)numberOfPointInRadarView:(DDYRadarView *)radarView {
    return 8;
}

- (UIImage *)radarView:(DDYRadarView *)radarView imageForIndex:(NSInteger)index {
    return [UIImage imageWithColor:DDYRandomColor size:CGSizeMake(40, 40)];
}

- (void)radarView:(DDYRadarView *)radarView didSelectItemAtIndex:(NSInteger)index {
    DDYLog(@"click index:%ld",index);
}

#pragma mark 监听挂起和重新进入程序
#pragma mark 添加监听
- (void)addObserverActive
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification object:nil]; //监听home键挂起.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];  //监听重新进入程序.
}

#pragma mark 进入前台
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self.radarView startScanAnimation];
}

#pragma mark 挂起程序
- (void)applicationWillResignActive:(UIApplication *)application
{
    [self.radarView stopScanAnimation];
}

@end
