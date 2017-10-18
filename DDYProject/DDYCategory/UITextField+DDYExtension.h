//
//  UITextField+DDYExtension.h
//  DDYProject
//
//  Created by LingTuan on 17/9/26.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (DDYExtension)

- (NSRange)selectedRange;

- (void)setSelectedRange:(NSRange)range;

@end
