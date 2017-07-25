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
- (UIImage *)screenshot;

@end
