//
//  DDYTextView.h
//  DDYProject
//
//  Created by LingTuan on 17/7/27.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDYTextView : UITextView

@property (nonatomic, strong) NSString *placeholder;

@property (nonatomic, strong) UIColor *placeholderTextColor;

+ (instancetype)textView;

+ (instancetype)textViewPlaceholder:(NSString *)placeholder font:(UIFont *)font;

+ (instancetype)textViewPlaceholder:(NSString *)placeholder font:(UIFont *)font frame:(CGRect)frame;

@end
