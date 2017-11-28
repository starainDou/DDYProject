//
//  DDYQRCodeVC.m
//  DDYProject
//
//  Created by LingTuan on 17/8/8.
//  Copyright © 2017年 Starain. All rights reserved.
//  https://github.com/starainDou/DDYProject/tree/master/DDYProject/CoreImage/QRCode

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
@property (nonatomic, strong) DDYQRCodeManager *qrCodeManager;

@property (nonatomic, strong) DDYQRCodeScanView *scanView;

@property (nonatomic, strong) UIImage *myQRCodeImg;

@end

@implementation DDYQRCodeVC

- (DDYQRCodeManager *)qrCodeManager {
    if (!_qrCodeManager) {
        _qrCodeManager = [[DDYQRCodeManager alloc] init];
        _qrCodeManager.delegate = self;
    }
    return _qrCodeManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepare];
    [self setupScanview];
//    [self setupMyQRCode];
    [self performSelector:@selector(setupQRManager) withObject:nil afterDelay:0.01];
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

- (void)setupQRManager {
    [DDYAuthorityMaster cameraAuthSuccess:^{
        [self.qrCodeManager ddy_ScanQRCodeWithCameraContainer:self.view];
    } fail:^{ } alertShow:YES];
}

- (void)setupMyQRCode
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(DDYSCREENW/2.0-50, DDYSCREENH-200, 100, 100);
    [self.view addSubview:imageView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        _myQRCodeImg = [self.qrCodeManager ddy_QRCodeWithData:@"http://www.jianshu.com/p/4d4ac1a67086"
                                                        width:200
                                                         logo:[UIImage circleImageWithColor:[UIColor redColor] radius:10]
                                                    logoScale:0.25];
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = _myQRCodeImg;
        });
    });
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchToScan)];
    [imageView addGestureRecognizer:tapGes];
    imageView.userInteractionEnabled = YES;
}

- (void)ddy_QRCodeScanResult:(NSString *)result success:(BOOL)success; {
    DDYInfoLog(@"%@",result);
    if (success) {
        [self.qrCodeManager ddy_stopRunningSession];
        if ([result containsString:@"http://"] || [result containsString:@"https://"]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:result]];
        } else {
            DDYQRCodeScanResultVC *vc = [[DDYQRCodeScanResultVC alloc] init];
            vc.resultStr = result;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (void)dealloc {
    [_scanView stopScanningLingAnimation];
    if (_qrCodeManager) {
        [_qrCodeManager ddy_stopRunningSession];
        _qrCodeManager.delegate = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_qrCodeManager) { [_qrCodeManager ddy_startRunningSession];}
    [self setNavigationBackgroundAlpha:0.15];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    _statusBarStyle = UIStatusBarStyleLightContent;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_qrCodeManager) {  [self.qrCodeManager ddy_stopRunningSession];}
    [self setNavigationBackgroundAlpha:1];
    self.navigationController.navigationBar.barTintColor = APP_MAIN_COLOR;
    _statusBarStyle = UIStatusBarStyleDefault;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)rightBtnClick:(DDYButton *)button {
    [DDYAuthorityMaster albumAuthSuccess:^{
        [self.qrCodeManager ddy_imgPickerVCWithCurrentVC:self];
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
- (UIStatusBarStyle)preferredStatusBarStyle {
    return _statusBarStyle;
}

#pragma mark 长按扫描
- (void)touchToScan {
    if (_qrCodeManager) { [_qrCodeManager ddy_scanQRCodeWithImage:_myQRCodeImg];}
}

@end
