
//
//  UIView+DDYExtension.m
//  DDYProject
//
//  Created by Rain Dou on 15/5/18.
//  Copyright © 2015年 634778311 All rights reserved.
//

#import "UIView+DDYExtension.h"

@implementation UIView (DDYExtension)

/* x的setter和getter方法 */
- (void)setDdy_x:(CGFloat)ddy_x
{
    CGRect frame = self.frame;
    frame.origin.x = ddy_x;
    self.frame = frame;
}
- (CGFloat)ddy_x
{
    return self.frame.origin.x;
}

/* y的setter和getter方法 */
- (void)setDdy_y:(CGFloat)ddy_y
{
    CGRect frame = self.frame;
    frame.origin.y = ddy_y;
    self.frame = frame;
}
- (CGFloat)ddy_y
{
    return self.frame.origin.y;
}

/* width的setter和getter方法 */
- (void)setDdy_w:(CGFloat)ddy_w
{
    CGRect frame = self.frame;
    frame.size.width = ddy_w;
    self.frame = frame;
}
- (CGFloat)ddy_w
{
    return self.frame.size.width;
}

/* height的setter和getter方法 */
- (void)setDdy_h:(CGFloat)ddy_h
{
    CGRect frame = self.frame;
    frame.size.height = ddy_h;
    self.frame = frame;
}
-(CGFloat)ddy_h
{
    return self.frame.size.height;
}
/* centerX的setter和getter方法 */
- (void)setDdy_centerX:(CGFloat)ddy_centerX
{
    CGPoint center = self.center;
    center.x = ddy_centerX;
    self.center = center;
}

- (CGFloat)ddy_centerX
{
    return self.center.x;
}
/* centerY的setter和getter方法 */
- (void)setDdy_centerY:(CGFloat)ddy_centerY
{
    CGPoint center = self.center;
    center.y = ddy_centerY;
    self.center = center;
}

- (CGFloat)ddy_centerY
{
    return self.center.y;
}

/* 右边到 x 轴距离 */
- (void)setDdy_right:(CGFloat)ddy_right
{
    CGRect frame = self.frame;
    frame.origin.x = ddy_right - frame.size.width;
    self.frame = frame;
}
- (CGFloat)ddy_right
{
    return self.frame.origin.x + self.frame.size.width;

}
/* 底边到 y 轴距离 */
- (void)setDdy_bottom:(CGFloat)ddy_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = ddy_bottom - frame.size.height;
    self.frame = frame;
}
-(CGFloat)ddy_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

/* size的setter和getter方法 */
- (void)setDdy_size:(CGSize)ddy_size
{
    CGRect frame = self.frame;
    frame.size = ddy_size;
    self.frame = frame;
}
- (CGSize)ddy_size
{
    return self.frame.size;
}

/* origin的setter和getter方法 */
- (void)setDdy_origin:(CGPoint)ddy_origin
{
    CGRect frame = self.frame;
    frame.origin = ddy_origin;
    self.frame = frame;
}
- (CGPoint)ddy_origin
{
    return self.frame.origin;
}

#pragma mark 截屏
- (UIImage *)screenshot
{
    UIGraphicsBeginImageContext(self.bounds.size);
    if([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]){
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    }
    else{
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImageJPEGRepresentation(image, 0.75);
    image = [UIImage imageWithData:imageData];
    return image;
}

@end
