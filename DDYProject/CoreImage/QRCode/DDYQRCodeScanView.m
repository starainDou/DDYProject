//
//  DDYQRCodeScanView.m
//  DDYProject
//
//  Created by LingTuan on 17/8/8.
//  Copyright © 2017年 Starain. All rights reserved.
//  https://github.com/starainDou/DDYProject/tree/master/DDYProject/CoreImage/QRCode

#import "DDYQRCodeScanView.h"

@interface DDYQRCodeScanView ()
{
    dispatch_source_t _timer;
}
@property (nonatomic, strong) UIImageView *scanningline;

@end

@implementation DDYQRCodeScanView

+ (instancetype)scanView {
    return [[self alloc] initWithFrame:DDYSCREENBOUNDS];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupContentView];
        [self startScanningLingAnimation];
    }
    return self;
}

- (void)setupContentView {
    // 镂空
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, self.bounds);
    CGPathAddRect(path, nil, CGRectMake(scanX, scanY, scanW, scanW));
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path;
    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    shapeLayer.fillColor = DDYRGBA(0, 0, 0, 0.6).CGColor;
    [self.layer addSublayer:shapeLayer];
    
    // 四角Img
    [self imgViewIndex:1 imgName:@"DDYQRCode.bundle/QRCodeLT"];
    [self imgViewIndex:2 imgName:@"DDYQRCode.bundle/QRCodeRT"];
    [self imgViewIndex:3 imgName:@"DDYQRCode.bundle/QRCodeLD"];
    [self imgViewIndex:4 imgName:@"DDYQRCode.bundle/QRCodeRD"];
    
    // 扫描线
    _scanningline = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DDYQRCode.bundle/QRCodeScanningLine"]];
    _scanningline.frame = CGRectMake(scanX, scanY, scanW, 2);
    [self addSubview:_scanningline];
    
    // 提示
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, scanY+scanW+15, DDYSCREENW, 16)];
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.text = @"将二维码/条码放入框内, 即可自动扫描";
    tipLabel.font = DDYFont(12);
    [self addSubview:tipLabel];
    
    // 闪光灯
    DDYButton *torchBtn = [DDYButton customDDYBtn];
    torchBtn.frame = CGRectMake(scanX, DDYSCREENH-65, scanW, 40);
    [torchBtn setImage:[UIImage imageNamed:@"DDYQRCode.bundle/QRCode_torch_n"] forState:UIControlStateNormal];
    [torchBtn setImage:[UIImage imageNamed:@"DDYQRCode.bundle/QRCode_torch_s"] forState:UIControlStateSelected];
    [torchBtn setTitle:@"打开照明灯" forState:UIControlStateNormal];
    [torchBtn setTitle:@"关闭照明灯" forState:UIControlStateSelected];
    torchBtn.titleLabel.font = DDYBDFont(15);
    [torchBtn addTarget:self action:@selector(turnOnlight:) forControlEvents:UIControlEventTouchUpInside];
    torchBtn.btnStyle = DDYBtnStyleImgTop;
    torchBtn.padding = 5;
    [self addSubview:torchBtn];
}

- (void)imgViewIndex:(NSInteger)index imgName:(NSString *)imgName {
    
    UIImage *img = [UIImage imageNamed:imgName];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    if (index == 1) {
        imgView.frame = CGRectMake(scanX, scanY, img.size.width, img.size.height);
    } else if (index == 2) {
        imgView.frame = CGRectMake(scanX+scanW-img.size.width, scanY, img.size.width, img.size.height);
    } else if (index == 3) {
        imgView.frame = CGRectMake(scanX, scanY+scanW-img.size.height, img.size.width, img.size.height);
    } else if (index == 4) {
        imgView.frame = CGRectMake(scanX+scanW-img.size.width, scanY+scanW-img.size.height, img.size.width, img.size.height);
    }
    [self addSubview:imgView];
}

#pragma mark 计时
- (void)startScanningLingAnimation {
    if (!_timer) {
        __weak __typeof__ (self)weakSelf = self;
        weakSelf.scanningline.ddy_y = scanY;
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0), 0.001 *NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(_timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (weakSelf.scanningline.ddy_y < scanY + scanW-2) {
                    weakSelf.scanningline.ddy_y += 0.1;
                } else {
                    weakSelf.scanningline.ddy_y = scanY;
                }
            });
        });
        dispatch_source_set_cancel_handler(_timer, ^{
            _timer = nil;
        });
        dispatch_resume(_timer);
    }
}

- (void)stopScanningLingAnimation {
    dispatch_source_cancel(_timer);
}

- (void)turnOnlight:(UIButton *)button {
    button.selected = !button.selected;
    [DDYQRCodeManager ddy_turnOnFlashLight:button.selected];
}

@end
