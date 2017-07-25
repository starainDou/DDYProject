//
//  UIImage+DDYExtension.h
//  DDYProject
//
//  Created by Rain Dou on 15/5/18.
//  Copyright © 2015年 634778311 All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIImage (DDYExtension)

/** 绘制矩形图片 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/** 绘制矩形框 */
+ (UIImage *)rectBorderWithColor:(UIColor *)color size:(CGSize)size;

/** 绘制圆形图片 */
+ (UIImage *)circleImageWithColor:(UIColor *)color radius:(CGFloat)radius;

/** 获取jpg格式图片元数据 */
- (NSDictionary *)JPEGmetaData;

/** 获取png格式图片元数据 */
- (NSDictionary *)PNGmetaData;

/** 裁剪成正方形 */
+ (UIImage *)squareImgFromImg:(UIImage *)image scaledToSize:(CGFloat)newSize;

/** 将UIView转成UIImage */
+ (UIImage *)getImageFromView:(UIView *)theView;

@end
