//
//  DDYQRCodeVC.m
//  DDYProject
//
//  Created by LingTuan on 17/8/8.
//  Copyright © 2017年 Starain. All rights reserved.
//

/**
 *  相机模块属于耗电模块，在iOS严格管控下，如果长时间运行会自动关闭会话，页面静止
 *
 *  二维码容量并非无限，所以生成二维码的字符不应该过多，防止出错。https://zh.wikipedia.org/wiki/QR%E7%A2%BC
 *
 *  二维码扫描暂时不支持旋转屏幕（本身二维码不分上下左右，没必要旋转后扫描）
 *
 *  iOS原生二维码扫描对编码格式有严格要求，如果确定编码格式导致扫描不出，请在错误回调中用其他扫描器扫描
 */

#import "DDYQRCodeVC.h"
#import "DDYQRCodeScanView.h"
#import "DDYQRCodeManager.h"
#import "DDYQRCodeScanResultVC.h"

@interface DDYQRCodeVC ()<DDYQRCodeManagerDelegate>
{
    UIStatusBarStyle _statusBarStyle;
}
@property (nonatomic, strong) DDYQRCodeScanView *scanView;

@property (nonatomic, strong) UIImage *myQRCodeImg;

@end

@implementation DDYQRCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepare];
    [self setupScanview];
    [self setupScanManager];
    [self setupMyQRCode];
}

- (void)prepare
{
    self.view.backgroundColor = [UIColor blackColor];
    [self showLeftBarBtnWithTitle:nil img:[UIImage imageNamed:@"back_white"]];
    [self showRightBarBtnWithTitle:@"相册" img:nil];
}

- (void)setupScanview {
    _scanView = [DDYQRCodeScanView scanView];
    [self.view addSubview:_scanView];
}

- (void)setupScanManager {
    [DDYAuthorityMaster cameraAuthSuccess:^{
        [DDYQRCodeManager sharedManager].delegate = self;
        [[DDYQRCodeManager sharedManager] ddy_ScanQRCodeWithCameraContainer:self.view];
    } fail:^{ } alertShow:YES];
}

- (void)setupMyQRCode
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(DDYSCREENW/2.0-50, DDYSCREENH-200, 100, 100);
    [self.view addSubview:imageView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        _myQRCodeImg = [[DDYQRCodeManager sharedManager] ddy_QRCodeWithData:@"http://www.jianshu.com/p/4d4ac1a67086"
                                                                      width:200
                                                                       logo:[UIImage circleImageWithColor:[UIColor redColor] radius:10]
                                                                  logoScale:0.25];
        imageView.image = _myQRCodeImg;
    });
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchToScan)];
    [imageView addGestureRecognizer:tapGes];
    imageView.userInteractionEnabled = YES;
}

- (void)ddy_QRCodeScanResult:(NSString *)result success:(BOOL)success; {
    DDYInfoLog(@"%@",result);
    if (success) {
        if ([result containsString:@"http://"] || [result containsString:@"https://"]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:result]];
        } else {
            [[DDYQRCodeManager sharedManager] ddy_stopRunningSession];
            DDYQRCodeScanResultVC *vc = [[DDYQRCodeScanResultVC alloc] init];
            vc.resultStr = result;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (void)dealloc {
    [_scanView stopScanningLingAnimation];
    [[DDYQRCodeManager sharedManager] ddy_stopRunningSession];
    [DDYQRCodeManager sharedManager].delegate = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[DDYQRCodeManager sharedManager] ddy_startRunningSession];
    [self setNavigationBackgroundAlpha:0.15];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    _statusBarStyle = UIStatusBarStyleLightContent;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[DDYQRCodeManager sharedManager] ddy_stopRunningSession];
    [self setNavigationBackgroundAlpha:1];
    self.navigationController.navigationBar.barTintColor = APP_MAIN_COLOR;
    _statusBarStyle = UIStatusBarStyleDefault;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)rightBtnClick:(DDYButton *)button
{
    [DDYAuthorityMaster albumAuthSuccess:^{
        [[DDYQRCodeManager sharedManager] ddy_imgPickerVCWithCurrentVC:self];
    } fail:^{ } alertShow:YES];
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

#pragma mark 状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return _statusBarStyle;
}

#pragma mark 长按录制
- (void)touchToScan
{
    [[DDYQRCodeManager sharedManager] ddy_scanQRCodeWithImage:_myQRCodeImg];
}

@end
