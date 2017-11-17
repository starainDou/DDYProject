//
//  DDYGroupHeader.h
//  DDYProject
//
//  Created by LingTuan on 17/11/9.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import <UIKit/UIKit.h>
#define clipAngle 60 // 默认裁剪角度

@interface DDYGroupHeader : UIView

@property (nonatomic, strong) NSArray *images;

+ (instancetype)headerWithHeaderWH:(CGFloat)headerWH;

@end
