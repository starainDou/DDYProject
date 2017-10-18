//
//  NSData+DDYExtension.m
//  DDYProject
//
//  Created by LingTuan on 17/9/11.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import "NSData+DDYExtension.h"

@implementation NSData (DDYExtension)

#pragma mark NSData转字符串
// 为nil时解决方案
// http://www.jianshu.com/p/1b3cbcbd7f66
// http://www.cnblogs.com/JM110/p/5547169.html
// http://blog.csdn.net/args_/article/details/50888254
// http://blog.csdn.net/tieshuxianrezhang/article/details/51960393

- (NSString *)ddy_DataToString {
    NSString *str = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    return str ? str : [[NSString alloc]initWithData:self encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
}

@end
