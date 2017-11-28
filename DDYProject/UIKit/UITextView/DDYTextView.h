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

/** 文字 */
@property (nonatomic, assign, readonly) CGSize textSize;

+ (instancetype)textView;

+ (instancetype)textViewPlaceholder:(NSString *)placeholder font:(UIFont *)font;

+ (instancetype)textViewPlaceholder:(NSString *)placeholder font:(UIFont *)font frame:(CGRect)frame;

/** 调整高宽适应规定高度 */
- (void)heightFitMinHeight:(CGFloat)minH maxHeight:(CGFloat)maxH;

@end
