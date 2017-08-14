//
//  DDYBaseViewController.h
//  NAToken
//
//  Created by LingTuan on 17/7/28.
//  Copyright © 2017年 NAT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDYBaseViewController : UIViewController

@property (nonatomic, assign) BOOL navigationBarBottomLineHidden;


/** 导航栏背景透明度设置 */
- (void)setNavigationBackgroundAlpha:(CGFloat)alpha;

/** defaultLeftButton */
- (void)showLeftBarBtnDefault;

/** leftButton */
- (void)showLeftBarBtnWithTitle:(NSString *)title img:(UIImage *)img;

/** rightButton */
- (void)showRightBarBtnWithTitle:(NSString *)title img:(UIImage *)img;

/** leftButtonTouch */
- (void)backBtnClick:(DDYButton *)button;

/** rightButtonTouch */
- (void)rightBtnClick:(DDYButton *)button;

@end
