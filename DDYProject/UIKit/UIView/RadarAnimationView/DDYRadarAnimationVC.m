//
//  DDYRadarAnimationVC.m
//  DDYProject
//
//  Created by LingTuan on 17/9/21.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import "DDYRadarAnimationVC.h"

@interface DDYRadarAnimationVC ()

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation DDYRadarAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupContentView];
    [self startAnimationTimer];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)prepare {
    [super prepare];
    self.title = DDYLocalStr(@"The man near by");
}

- (void)setupContentView {
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.ddy_h-80, DDYSCREENW, 24)];
    tipLabel.font = DDYFont(17);
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = DDY_Mid_Black;
    tipLabel.text = DDYLocalStr(@"Search nearby people immediately");
    [self.view addSubview:tipLabel];
}

#pragma mark 开启定时器 开始动画
- (void)startAnimationTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(radarAnimation) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

#pragma mark 扫描动画
-(void)radarAnimation
{
    DDYCirCleAnimationView *radarView = [DDYCirCleAnimationView circleViewFrame:DDYRect(0, 0, DDYSCREENW, DDYSCREENW)];
    radarView.ddy_centerY = self.view.ddy_h/2.0-20;
    radarView.backgroundColor = DDY_ClearColor;
    radarView.fillColor = APP_MAIN_COLOR;
    radarView.strokeColor = APP_MAIN_COLOR;
    [self.view addSubview:radarView];
    
    [UIView animateWithDuration:3 animations:^{
        radarView.transform = CGAffineTransformScale(radarView.transform, DDYSCREENW/2/30, DDYSCREENW/2/30);
        radarView.alpha = 0;
    } completion:^(BOOL finished) {
        [radarView removeFromSuperview];
    }];
}

@end
