//
//  UILabel+DDYExtension.h
//  DDYProject
//
//  Created by starain on 15/8/14.
//  Copyright © 2015年 Starain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (DDYExtension)

/** 得到contentSize */
- (CGSize)getContentSize;
/** 设置行间距 */
- (void)changeLineSpacing:(CGFloat)spacing;

@end
