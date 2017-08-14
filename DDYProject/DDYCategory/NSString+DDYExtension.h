//
//  NSString+DDYExtension.h
//  DDYProject
//
//  Created by Rain Dou on 15/5/18.
//  Copyright © 2015年 634778311 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DDYExtension)
/** 汉字转拼音 */
- (NSString *)ddyChangeToPinYin;
/**  */
- (NSString*)ddyStringByURLEncodingStringParameter;
/** Unicode转中文 */
- (NSString *)replaceUnicode:(NSString *)unicodeStr;
/** date转字符串 */
+ (NSString *)stringFromDate:(NSDate *)date;
/** 判断是否含有汉字 */
- (BOOL)includeChinese;
/** 判断是否是纯汉字 */
- (BOOL)isChinese;
/** 判断是否为空 */
- (BOOL)isBlankString;

@end
