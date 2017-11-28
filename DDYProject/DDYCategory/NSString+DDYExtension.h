//
//  NSString+DDYExtension.h
//  DDYProject
//
//  Created by Rain Dou on 15/5/18.
//  Copyright © 2015年 634778311 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DDYExtension)

/** date转字符串 */
+ (NSString *)ddy_StringFromDate:(NSDate *)date;

/** data转字符串 */
+ (NSString *)ddy_DataToString:(NSData *)data;

/** 字符串转data */
+ (NSData *)ddy_StringToData:(NSString *)string;

/** Unicode转中文 */
+ (NSString *)ddy_UnicodeToString;

/** 汉字转拼音 */
- (NSString *)ddy_ChangeToPinYin;

/** URL特殊符号编码 */
- (NSString*)ddy_URLEncoding;

/** 判断是否含有汉字 */
- (BOOL)ddy_IncludeChinese;

/** 判断是否是纯汉字 */
- (BOOL)ddy_OnlyChinese;

/** 判断是否为空 */
+ (BOOL)ddy_blankString:(NSString *)str;

/** SHA256加密 */
- (NSString *)ddy_SHA256;

/** SHA256加密data */
+ (NSString *)ddy_SHA256WithData:(NSData *)data;

/** SHA265加密 后台对key加密 */
- (NSString *)ddy_SHA256WithKey:(NSString *)key;

/** SHA3 Keccak-256加密 bitsLength:224/256/384/512 */
- (NSString*)ddy_SHA3:(NSUInteger)bitsLength;

/** 是否只包含数字/小数点 */
- (BOOL)ddy_OnlyNumberOrPoint;

/** 是否只包含给定字符串中字符 */
- (BOOL)ddy_onlyHasCharacterOfString:(NSString *)string;

/** 字典/数组转json字符串 */
- (NSString *)ddy_ChangeToJsonString:(id)obj;

/** 将16进制的字符串转换成NSData */
- (NSMutableData *)ddy_HexStrToData;

@end
