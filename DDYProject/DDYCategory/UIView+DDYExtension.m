
//
//  UIView+DDYExtension.m
//  DDYProject
//
//  Created by Rain Dou on 15/5/18.
//  Copyright © 2015年 634778311 All rights reserved.
//

#import "UIView+DDYExtension.h"
#import <objc/runtime.h> // 红点提示用到

@implementation UIView (DDYExtension)

#pragma mark x的setter和getter方法
- (void)setDdy_x:(CGFloat)ddy_x {
    CGRect frame = self.frame;
    frame.origin.x = ddy_x;
    self.frame = frame;
}

- (CGFloat)ddy_x {
    return self.frame.origin.x;
}

#pragma mark y的setter和getter方法
- (void)setDdy_y:(CGFloat)ddy_y {
    CGRect frame = self.frame;
    frame.origin.y = ddy_y;
    self.frame = frame;
}

- (CGFloat)ddy_y
{
    return self.frame.origin.y;
}

#pragma mark width的setter和getter方法
- (void)setDdy_w:(CGFloat)ddy_w {
    CGRect frame = self.frame;
    frame.size.width = ddy_w;
    self.frame = frame;
}

- (CGFloat)ddy_w {
    return self.frame.size.width;
}

#pragma mark height的setter和getter方法
- (void)setDdy_h:(CGFloat)ddy_h {
    CGRect frame = self.frame;
    frame.size.height = ddy_h;
    self.frame = frame;
}
- (CGFloat)ddy_h {
    return self.frame.size.height;
}
#pragma mark centerX的setter和getter方法
- (void)setDdy_centerX:(CGFloat)ddy_centerX {
    CGPoint center = self.center;
    center.x = ddy_centerX;
    self.center = center;
}

- (CGFloat)ddy_centerX {
    return self.center.x;
}

#pragma mark centerY的setter和getter方法
- (void)setDdy_centerY:(CGFloat)ddy_centerY {
    CGPoint center = self.center;
    center.y = ddy_centerY;
    self.center = center;
}

- (CGFloat)ddy_centerY {
    return self.center.y;
}

#pragma mark 右边到 x 轴距离
- (void)setDdy_right:(CGFloat)ddy_right {
    CGRect frame = self.frame;
    frame.origin.x = ddy_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)ddy_right
{
    return self.frame.origin.x + self.frame.size.width;

}
#pragma mark 底边到 y 轴距离
- (void)setDdy_bottom:(CGFloat)ddy_bottom {
    CGRect frame = self.frame;
    frame.origin.y = ddy_bottom - frame.size.height;
    self.frame = frame;
}

-(CGFloat)ddy_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

#pragma mark size的setter和getter方法
- (void)setDdy_size:(CGSize)ddy_size {
    CGRect frame = self.frame;
    frame.size = ddy_size;
    self.frame = frame;
}

- (CGSize)ddy_size
{
    return self.frame.size;
}

#pragma mark origin的setter和getter方法
- (void)setDdy_origin:(CGPoint)ddy_origin {
    CGRect frame = self.frame;
    frame.origin = ddy_origin;
    self.frame = frame;
}

- (CGPoint)ddy_origin {
    return self.frame.origin;
}

#pragma mark 截屏
- (UIImage *)ddy_Screenshot
{
    UIGraphicsBeginImageContext(self.bounds.size);
    if([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]){
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    } else{
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImageJPEGRepresentation(image, 0.75);
    image = [UIImage imageWithData:imageData];
    return image;
}

#pragma mark - 添加手势
#pragma mark 点击手势
- (void)addTapTarget:(id)target action:(SEL)action {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
}

#pragma mark 点击手势 + 代理
- (void)addTapTarget:(id)target action:(SEL)action delegate:(id)delegate {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    tap.delegate = delegate;
    [self addGestureRecognizer:tap];
}

#pragma mark 点击手势 + 点击数
- (void)addTapTarget:(id)target action:(SEL)action number:(NSInteger)number {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    tap.numberOfTapsRequired = number;
    [self addGestureRecognizer:tap];
}

#pragma mark 点击手势 + 点击数 + 代理
- (void)addTapTarget:(id)target action:(SEL)action number:(NSInteger)number  delegate:(id)delegate {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    tap.numberOfTapsRequired = number;
    tap.delegate = delegate;
    [self addGestureRecognizer:tap];
}

#pragma mark 长按手势
- (void)addLongGestureTarget:(id)target action:(SEL)action {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longGes = [[UILongPressGestureRecognizer alloc]initWithTarget:target action:action];
    [self addGestureRecognizer:longGes];
}

#pragma mark 长按手势 + 长按最短时间
- (void)addLongGestureTarget:(id)target action:(SEL)action minDuration:(CFTimeInterval)minDuration {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longGes = [[UILongPressGestureRecognizer alloc]initWithTarget:target action:action];
    longGes.minimumPressDuration = minDuration;
    [self addGestureRecognizer:longGes];
}

#pragma mark 拖动手势
- (void)addPanGestureTarget:(id)target action:(SEL)action {
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:target action:action]];
}

#pragma mark 拖动手势 + 代理
- (void)addPanGestureTarget:(id)target action:(SEL)action delegate:(id)delegate {
    self.userInteractionEnabled = YES;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
    panGesture.delegate = delegate;
    [self addGestureRecognizer:panGesture];
}

@end
