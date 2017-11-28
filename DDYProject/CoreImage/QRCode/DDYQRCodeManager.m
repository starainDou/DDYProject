//
//  DDYQRCodeManager.m
//  DDYProject
//
//  Created by LingTuan on 17/8/8.
//  Copyright © 2017年 Starain. All rights reserved.
//  https://github.com/starainDou/DDYProject/tree/master/DDYProject/CoreImage/QRCode

#import "DDYQRCodeManager.h"

@interface DDYQRCodeManager ()<AVCaptureMetadataOutputObjectsDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/** 捕获会话 */
@property (nonatomic, strong) AVCaptureSession *captureSession;
/** 视频输入 */
@property (nonatomic, strong) AVCaptureDeviceInput *videoInput;
/** 元数据输出 */
@property (nonatomic, strong) AVCaptureMetadataOutput *metadataOutput;
/** 预览层 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
/** 设备 */
@property (nonatomic, strong) AVCaptureDevice *device;

@end

@implementation DDYQRCodeManager

#pragma mark - 单例对象

static DDYQRCodeManager *_instance;

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

#pragma mark - 生成条形码
#pragma mark 生成原始条形码
- (CIImage *)generateBarCodeWithData:(NSString *)data
{
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    [filter setValue:[data dataUsingEncoding:NSUTF8StringEncoding] forKey:@"inputMessage"];
    [filter setValue:@(0.00) forKey:@"inputQuietSpace"];  // 上下左右的margin值
    return [filter outputImage];
}

#pragma mark 生成普通条形码
- (UIImage *)ddy_BarCodeWithData:(NSString *)data size:(CGSize)size
{
    return [self changeSize:[self generateBarCodeWithData:data] width:size.width height:size.height];
}

#pragma mark 生成彩色条形码
- (UIImage *)ddy_BarCodeWithData:(NSString *)data size:(CGSize)size color:(UIColor *)color bgColor:(UIColor *)bgColor
{
    return [self changeSize:[self changeColor:[self generateBarCodeWithData:data] color:color bgColor:bgColor] width:size.width height:size.height];
}

#pragma mark - 生成二维码
#pragma mark 生成原始二维码
- (CIImage *)generateQRCodeWithData:(NSString *)data
{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    [filter setValue:[data dataUsingEncoding:NSUTF8StringEncoding] forKeyPath:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    return [filter outputImage];
}

#pragma mark 改变前景和背景色
- (CIImage *)changeColor:(CIImage *)image color:(UIColor *)color bgColor:(UIColor *)bgColor
{
    CIFilter *filter = [CIFilter filterWithName:@"CIFalseColor"];
    [filter setDefaults];
    [filter setValue:image forKey:@"inputImage"];
    [filter setValue:[CIColor colorWithCGColor:bgColor.CGColor] forKey:@"inputColor0"];
    [filter setValue:[CIColor colorWithCGColor:color.CGColor] forKey:@"inputColor1"];
    return [filter outputImage];
}

#pragma mark 改变宽高
- (UIImage *)changeSize:(CIImage *)image width:(CGFloat)width height:(CGFloat)height
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(width/CGRectGetWidth(extent), width/CGRectGetHeight(extent));
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef contentRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpaceRef, kCGBitmapByteOrder32Little|kCGImageAlphaNoneSkipLast);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(contentRef, kCGInterpolationNone);
    CGContextScaleCTM(contentRef, scale, scale);
    CGContextDrawImage(contentRef, extent, imageRef);
    CGImageRef imageRefResized = CGBitmapContextCreateImage(contentRef);
    CGContextRelease(contentRef);
    CGImageRelease(imageRef);
    return [UIImage imageWithCGImage:imageRefResized];
}

#pragma mark 添加logo
- (UIImage *)addLogo:(UIImage *)image logo:(UIImage *)logo logoScale:(CGFloat)logoScale
{
    CGFloat scale = logoScale>0 ? (logoScale<0.3?logoScale:0.3) : 0.25;
    CGFloat logoW = image.size.width * scale;
    CGFloat logoX = (image.size.width-logoW)/2.0;
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    [logo drawInRect:CGRectMake(logoX, logoX, logoW, logoW)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

#pragma mark 生成普通二维码
- (UIImage *)ddy_QRCodeWithData:(NSString *)data width:(CGFloat)width
{
    return [self changeSize:[self generateQRCodeWithData:data] width:width height:width];
}

#pragma mark 生成logo二维码
- (UIImage *)ddy_QRCodeWithData:(NSString *)data width:(CGFloat)width logo:(UIImage *)logo logoScale:(CGFloat)logoScale
{
    return [self addLogo:[self ddy_QRCodeWithData:data width:width] logo:logo logoScale:logoScale];
}

#pragma mark 生成彩色二维码
- (UIImage *)ddy_QRCodeWithData:(NSString *)data width:(CGFloat)width color:(UIColor *)color bgColor:(UIColor *)bgColor
{
    return [self changeSize:[self changeColor:[self generateQRCodeWithData:data] color:color bgColor:bgColor] width:width height:width];
}

#pragma mark - 扫描二维码
#pragma mark 拍照扫描二维码
- (void)ddy_ScanQRCodeWithCameraContainer:(UIView *)container
{
    _captureSession = [[AVCaptureSession alloc] init];
    if ([_captureSession canSetSessionPreset:AVCaptureSessionPresetHigh]) {
        [_captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    }
    
    // 视频输入
    _device         = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    _videoInput     = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
    if ([_captureSession canAddInput:_videoInput]) {
        [_captureSession addInput:_videoInput];
    }
    
    // 预览层
    _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_captureSession];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _previewLayer.frame = container.bounds;
    [container.layer insertSublayer:_previewLayer atIndex:0];
    
    // 自动对焦
    if (_device.isFocusPointOfInterestSupported &&[_device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        [_videoInput.device lockForConfiguration:nil];
        [_videoInput.device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
        [_videoInput.device unlockForConfiguration];
    }
    
    // 元数据输出,放后边比较好 rectOfInterest:扫描范围,原点在右上角
    _metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    _metadataOutput.rectOfInterest = CGRectMake(scanY/DDYSCREENH, scanX/DDYSCREENW, scanW/DDYSCREENH, scanW/DDYSCREENW);
    if ([_captureSession canAddOutput:_metadataOutput]) {
        [_captureSession addOutput:_metadataOutput];
    }
    // 必须先加addOutput 并且有权限
    _metadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    [self ddy_startRunningSession];
}

#pragma mark 开始运行会话
- (void)ddy_startRunningSession {
    if (![_captureSession isRunning]) {
        [_captureSession startRunning];
    }
}

#pragma mark 停止运行会话
- (void)ddy_stopRunningSession {
    if ([_captureSession isRunning]) {
        [_captureSession stopRunning];
    }
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects && metadataObjects.count) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        NSString *resultStr = [obj stringValue];
        BOOL success = metadataObjects && metadataObjects.count && ![NSString ddy_blankString:resultStr];
        [self scanQRCodeResult:resultStr success:success];
    }
}

#pragma mark 图片读取二维码
- (void)ddy_scanQRCodeWithImage:(UIImage *)image
{
    UIImage *img = [image imageSizeInScreen];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:img.CGImage]];
    NSString *resultStr;
    
    for (int i = 0; i<features.count; i++) {
        CIQRCodeFeature *feature = [features objectAtIndex:i];
        resultStr = feature.messageString;
    }
    BOOL success = features && features.count && ![NSString ddy_blankString:resultStr];
    
    [self scanQRCodeResult:resultStr success:success];
}
#pragma mark 利用UIImagePickerViewController选取二维码图片
- (void)ddy_imgPickerVCWithCurrentVC:(UIViewController *)controller {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //（选择类型）表示仅仅从相册中选取照片
    imagePicker.delegate = self;
    [controller presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [self ddy_scanQRCodeWithImage:info[UIImagePickerControllerOriginalImage]];
    [picker dismissViewControllerAnimated:YES completion:^{ }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{ }];
}

- (void)scanQRCodeResult:(NSString *)resultStr success:(BOOL)success
{
    if ([self.delegate respondsToSelector:@selector(ddy_QRCodeScanResult:success:)]) {
        [self.delegate ddy_QRCodeScanResult:resultStr success:success];
    } else if (self.scanResult) {
        self.scanResult(resultStr, success);
    }
}

#pragma mark 播放音效
void soundCompleteCallback(SystemSoundID soundID, void *clientData) {
    
}
- (void)ddy_palySound:(NSString *)soundName {
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:soundName ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioFile];
    SystemSoundID soundID = 0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    AudioServicesPlaySystemSound(soundID);
}

+ (void)ddy_turnOnFlashLight:(BOOL)on {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // hasTorch是持续发光 hasFlash是闪光 （setTorchMode: 和 setFlashMode: 同理）
    if ([device hasTorch] && [device hasFlash])
    {
        // 注意改变设备属性前先加锁,调用完解锁
        [device lockForConfiguration:nil];
        [device setTorchMode: on ? AVCaptureTorchModeOn : AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    }
}

@end

/** 
 iOS-使用AudioServices相关接口的连续震动 http://www.jianshu.com/p/dded314dd920
 
 花式二维码 swift https://github.com/EyreFree/EFQRCode
 */
