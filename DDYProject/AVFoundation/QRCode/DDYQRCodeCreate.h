//
//  DDYQRCodeCreate.h
//  DDYProject
//
//  Created by LingTuan on 17/7/31.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDYQRCodeCreate : NSObject

/** 生成黑白普通二维码 */
+ (UIImage *)DDY_defaultQRCodeWithData:(NSString *)data;

/** 生成带logo的二维码 scale:(0-1),0不显示，1与父视图等大 推荐0.2 */
+ (UIImage *)DDY_logoQRCodeWithData:(NSString *)data logo:(UIImage *)logo scale:(CGFloat)scale;

/** 生成彩色二维码 */
//+ (UIImage *)


@end
