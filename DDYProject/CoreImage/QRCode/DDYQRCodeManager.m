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

#pragma mark 生成圆块二维码
- (UIImage *)ddy_CircleQRCodeWithData:(NSString *)data width:(CGFloat)width gradientType:(kQRCodeGradientType)type startColor:(UIColor *)startColor endColor:(UIColor *)endColor {
    NSArray *points = [self getPixelsWithImage:[self convertCIImageToCGImage:[self generateQRCodeWithData:data]]];
    DDYInfoLog(@"%@",points);
    return [self drawWithPoints:points width:width colors:@[startColor, endColor] type:type];
}

#pragma mark 将CIImage转成CGImage
- (CGImageRef)convertCIImageToCGImage:(CIImage *)image {
    CGRect extent = CGRectIntegral(image.extent);
    
    size_t width = CGRectGetWidth(extent);
    size_t height = CGRectGetHeight(extent);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, 1, 1);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    return scaledImage;
}

#pragma mark 将原始图片的所有点的色值保存到二维数组
- (NSArray <NSArray *>*)getPixelsWithImage:(CGImageRef)image {
    CGFloat width = CGImageGetWidth(image);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char *)calloc(width*width*4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = width*bytesPerPixel;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, width, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, width, width), image);
    CGContextRelease(context);
    
    NSMutableArray *pixels = [NSMutableArray array];
    for (int y = 0; y < width; y++) {
        NSMutableArray *array = [NSMutableArray array];
        for (int x = 0; x < width; x++) {
            @autoreleasepool {
                NSUInteger byteIndex = bytesPerRow*y + bytesPerPixel*x;
                CGFloat r = (CGFloat)rawData[byteIndex];
                CGFloat g = (CGFloat)rawData[byteIndex + 1];
                CGFloat b = (CGFloat)rawData[byteIndex + 2];
                BOOL display = (r==0 && g==0 && b==0);
                [array addObject:@(display)];
                byteIndex += bytesPerPixel;
            }
        }
        [pixels addObject:[array copy]];
    }
    free(rawData);
    return [pixels copy];
}

- (UIImage *)drawWithPoints:(NSArray <NSArray *>*)points width:(CGFloat)width colors:(NSArray <UIColor *>*)colors type:(kQRCodeGradientType)type {
    
    CGFloat delta = width/points.count;
    UIGraphicsBeginImageContext(CGSizeMake(width, width));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    for (int y = 0; y < points.count; y++) {
        for (int x = 0; x < points[y].count; x++) {
            if ([points[y][x] boolValue]) {
                CGFloat centerX = x*delta + 0.5*delta;
                CGFloat centerY = y*delta + 0.5*delta;
                CGFloat radius = 0.5*delta;
                CGFloat startAngle = 0;
                CGFloat endAngle = M_PI * 2;
                UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
                NSArray <UIColor *> *gradientColors = [self gradientColorWithStartPoint:CGPointMake(x*delta, y*delta) endPoint:CGPointMake((x+1)*delta, (y+1)*delta) width:width colors:colors type:type];
                [self drawLinearGradient:ctx path:path.CGPath startColor:gradientColors.firstObject.CGColor endColor:gradientColors.lastObject.CGColor type:type];
                CGContextSaveGState(ctx);
            }
        }
    }
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (NSArray <UIColor *>*)gradientColorWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint width:(CGFloat)width colors:(NSArray *)colors type:(kQRCodeGradientType)type {
    UIColor *color1 = colors.firstObject;
    UIColor *color2 = colors.lastObject;
    const CGFloat *components1 = CGColorGetComponents(color1.CGColor);
    const CGFloat *components2 = CGColorGetComponents(color2.CGColor);
    
    CGFloat r1 = components1[0];
    CGFloat g1 = components1[1];
    CGFloat b1 = components1[2];
    
    CGFloat r2 = components2[0];
    CGFloat g2 = components2[1];
    CGFloat b2 = components2[2];
    
    NSArray <UIColor *> *result = nil;
    switch (type) {
        case kQRCodeGradientTypeHorizontal:
        {
            CGFloat startDelta = startPoint.x / width;
            CGFloat endDelta = endPoint.x / width;
            
            CGFloat startR = (1-startDelta)*r1 + startDelta*r2;
            CGFloat startG = (1-startDelta)*g1 + startDelta*g2;
            CGFloat startB = (1-startDelta)*b1 + startDelta*b2;
            
            CGFloat endR = (1-endDelta)*r1 + endDelta*r2;
            CGFloat endG = (1-endDelta)*g1 + endDelta*g2;
            CGFloat endB = (1-endDelta)*b1 + endDelta*b2;
            result = @[DDYColor(startR, startG, startB, 1), DDYColor(endR, endG, endB, 1)];
        }
            break;
        case kQRCodeGradientTypeDiagonal:
        {
            CGFloat startDelta = [self calculateTarHeiForPoint:startPoint] / (width*width);
            CGFloat endDelta = [self calculateTarHeiForPoint:endPoint] / (width*width);
           
            CGFloat startR = r1 + startDelta*(r2-r1);
            CGFloat startG = g1 + startDelta*(g2-g1);
            CGFloat startB = b1 + startDelta*(b2-b1);
            
            CGFloat endR = r1 + endDelta*(r2-r1);
            CGFloat endG = g1 + endDelta*(g2-g1);
            CGFloat endB = b1 + endDelta*(b2-b1);
            
            result = @[DDYColor(startR, startG, startB, 1), DDYColor(endR, endG, endB, 1)];
        }
            break;
        default:
            break;
    }
    return result;
}

- (CGFloat)calculateTarHeiForPoint:(CGPoint)point {
    CGFloat tarArvValue = point.x>=point.y ? M_PI_4-atan(point.y/point.x) : M_PI_4-atan(point.x/point.y);
    return cos(tarArvValue) * (point.x*point.x + point.y*point.y);
}

- (void)drawLinearGradient:(CGContextRef)ctr path:(CGPathRef)path startColor:(CGColorRef)startColor endColor:(CGColorRef)endColor type:(kQRCodeGradientType)type {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0, 1};
    
    NSArray *colors = @[(__bridge id)startColor, (__bridge id)endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint = CGPointZero;
    
    switch (type) {
        case kQRCodeGradientTypeDiagonal:
        {
            startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMinY(pathRect));
            endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMaxY(pathRect));
        }
            break;
            case kQRCodeGradientTypeHorizontal:
        {
            startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
            endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));
        }
            break;
        default:
            break;
    }
    CGContextSaveGState(ctr);
    CGContextAddPath(ctr, path);
    CGContextClip(ctr);
    CGContextDrawLinearGradient(ctr, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(ctr);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
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
