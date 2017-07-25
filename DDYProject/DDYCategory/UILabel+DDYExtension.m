//
//  UILabel+DDYExtension.m
//  DDYProject
//
//  Created by starain on 15/8/14.
//  Copyright © 2015年 Starain. All rights reserved.
//

#import "UILabel+DDYExtension.h"

@implementation UILabel (DDYExtension)

- (CGSize)getContentSize
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    paragraphStyle.alignment = self.textAlignment;
    NSDictionary *attributes = @{ NSFontAttributeName : self.font, NSParagraphStyleAttributeName : paragraphStyle };
    
    CGSize contentSize = [self.text boundingRectWithSize : self.frame.size
                                                 options : (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                              attributes : attributes
                                                 context : nil].size;
    return contentSize;
}

- (void)changeLineSpacing:(CGFloat)spacing
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = spacing;
    NSDictionary *attributes = @{ NSFontAttributeName:self.font, NSParagraphStyleAttributeName:paragraphStyle };
    self.attributedText = [[NSAttributedString alloc] initWithString:self.text attributes:attributes];
}

@end