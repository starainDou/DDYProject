//
//  DDYHeader.h
//  DDYProject
//
//  Created by LingTuan on 17/11/16.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import <UIKit/UIKit.h>

#define headerClipAngle 60 // 默认裁剪角度

static inline float change2Radians(double degrees) { return degrees * M_PI / 180; }
static inline float change2Angle(double rad) { return rad *  180 / M_PI; }

@interface DDYHeader : UIView
/** 占位图（本地图片） */
@property (nonatomic, strong) NSArray <UIImage *>*imgArray;
/** URL（网络图片） */
@property (nonatomic, strong) NSArray <NSString *>*urlArray;

+ (instancetype)headerWithHeaderWH:(CGFloat)headerWH;

@end
