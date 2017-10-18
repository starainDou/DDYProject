//
//  DDYPulseVC.m
//  DDYProject
//
//  Created by LingTuan on 17/10/12.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import "DDYPulseVC.h"

@interface DDYPulseVC ()

@property (nonatomic, strong) DDYPulseView *pulseView;

@end

@implementation DDYPulseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pulseView startAnimation];
    self.pulseView.fillColor = APP_MAIN_COLOR;
    self.pulseView.strokeColor = APP_MAIN_COLOR;
    self.pulseView.minRadius = 30;
}

- (DDYPulseView *)pulseView {
    if (!_pulseView) {
        _pulseView = [DDYPulseView pulseView];
        [self.view addSubview:_pulseView];
    }
    return _pulseView;
}

@end
