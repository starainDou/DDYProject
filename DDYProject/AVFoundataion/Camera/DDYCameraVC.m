//
//  DDYCameraVC.m
//  DDYProject
//
//  Created by LingTuan on 17/8/16.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import "DDYCameraVC.h"
#import "DDYCameraManager.h"
#import "DDYCameraView.h"

#import "FilterTestVC.h" // 测试用

@interface DDYCameraVC ()

@property (nonatomic, strong) DDYCameraManager *cameraManager;

@end

@implementation DDYCameraVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCamera];
    [self setupCameraView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [_cameraManager ddy_StartCaptureSession];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [_cameraManager ddy_StopCaptureSession];
}

- (void)setupCamera
{
     __weak __typeof__ (self)weakSelf = self;
    _cameraManager = [[DDYCameraManager alloc] init];
    [_cameraManager ddy_CameraWithContainer:self.view];
    _cameraManager.takePhotoBlock = ^ (UIImage * image) {
        if (image) {
            DDYInfoLog(@"%f-%f",image.size.width, image.size.height);
            FilterTestVC *vc = [[FilterTestVC alloc] init];
            vc.img = image;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    };
}

- (void)setupCameraView
{
    self.view.backgroundColor = DDYBackColor;
    DDYCameraView *cameraView = [[DDYCameraView alloc] initWithFrame:self.view.bounds];
    cameraView.cameraMask = DDYCameraMaskCircle;
    [self.view addSubview:cameraView];
    
    cameraView.backBlock = ^() { [self handleBack]; };
    cameraView.toggleBlock = ^() { [self handleToggle]; };
    cameraView.takeBlock = ^() { [self handleTake]; };
    cameraView.recordBlock = ^(BOOL startOrStop) { startOrStop ? [self startRecod] : [self stopRecord]; };
}

#pragma mark - 事件响应
#pragma mark 返回
- (void)handleBack {
    if ([self.navigationController popViewControllerAnimated:YES]) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{ }];
    }
}

#pragma mark 切换摄像头
- (void)handleToggle {
    [_cameraManager ddy_ToggleCamera];
}

#pragma mark 拍照
- (void)handleTake {
    [_cameraManager ddy_TakePhotos];
}

#pragma mark 长按录制
- (void)startRecod {
    [_cameraManager ddy_StartRecord];
}

#pragma mark 录制结束
- (void)stopRecord {
    [_cameraManager ddy_StopRecord];
}

#pragma mark - 控制旋转屏幕
#pragma mark 支持旋转的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
#pragma mark 是否支持自动旋转
- (BOOL)shouldAutorotate {
    return NO;
}

#pragma mark - 状态栏显隐性
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
