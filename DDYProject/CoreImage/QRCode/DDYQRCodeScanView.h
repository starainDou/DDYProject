//
//  DDYQRCodeScanView.h
//  DDYProject
//
//  Created by LingTuan on 17/8/8.
//  Copyright © 2017年 Starain. All rights reserved.
//  https://github.com/starainDou/DDYProject/tree/master/DDYProject/CoreImage/QRCode

#import <UIKit/UIKit.h>
#import "DDYQRCodeManager.h"

@interface DDYQRCodeScanView : UIView

+ (instancetype)scanView;

- (void)startScanningLingAnimation;

- (void)stopScanningLingAnimation;

@end
