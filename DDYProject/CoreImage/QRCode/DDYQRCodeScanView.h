//
//  DDYQRCodeScanView.h
//  DDYProject
//
//  Created by LingTuan on 17/8/8.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDYQRCodeManager.h"

@interface DDYQRCodeScanView : UIView

+ (instancetype)scanView;

- (void)startScanningLingAnimation;

- (void)stopScanningLingAnimation;

@end
