//
//  UIView+DDYExtension.h
//  DDYProject
//
//  Created by Rain Dou on 15/5/18.
//  Copyright © 2015年 634778311 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DDYExtension)

@property (nonatomic, assign) CGFloat ddy_x;
@property (nonatomic, assign) CGFloat ddy_y;
@property (nonatomic, assign) CGFloat ddy_w;
@property (nonatomic, assign) CGFloat ddy_h;
@property (nonatomic, assign) CGFloat ddy_right;
@property (nonatomic, assign) CGFloat ddy_bottom;
@property (nonatomic, assign) CGFloat ddy_centerX;
@property (nonatomic, assign) CGFloat ddy_centerY;
@property (nonatomic, assign) CGSize  ddy_size;
@property (nonatomic, assign) CGPoint ddy_origin;

/** 截屏 */
- (UIImage *)ddy_Screenshot;

/** 红点提示 https://github.com/gitkong/UIView-BadgeValue */
@property (nonatomic, strong) NSString *ddy_BadgeValue;


/** 点击手势 */
- (void)addTapTarget:(id)target action:(SEL)action;
/** 点击手势 + 代理 */
- (void)addTapTarget:(id)target action:(SEL)action delegate:(id)delegate;
/** 点击手势 + 点击数 */
- (void)addTapTarget:(id)target action:(SEL)action number:(NSInteger)number;
/** 点击手势 + 点击数 + 代理 */
- (void)addTapTarget:(id)target action:(SEL)action number:(NSInteger)number  delegate:(id)delegate;
/** 长按手势 */
- (void)addLongGestureTarget:(id)target action:(SEL)action;
/** 长按手势 + 长按最短时间 */
- (void)addLongGestureTarget:(id)target action:(SEL)action minDuration:(CFTimeInterval)minDuration;
/** 拖动手势 */
- (void)addPanGestureTarget:(id)target action:(SEL)action;
/** 拖动手势 + 代理 */
- (void)addPanGestureTarget:(id)target action:(SEL)action delegate:(id)delegate;

@end
