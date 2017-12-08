//
//  DDYFileTool.h
//  FireFly
//
//  Created by LingTuan on 17/9/26.
//  Copyright © 2017年 NAT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDYFileTool : NSFileManager

/** 是否存在 */
+ (BOOL)ddy_FileExistsAtPath:(NSString *)path;

/** 创建 */
+ (BOOL)ddy_CreateDirectory:(NSString *)path error:(NSError **)error;

/** 删除 */
+ (BOOL)ddy_RemoveItemAtPath:(NSString *)path error:(NSError **)error;

/** 移动 */
+ (BOOL)ddy_MoveItemAtPath:(NSString *)path toPath:(NSString *)toPath error:(NSError **)error;

/** 复制 */
+ (BOOL)ddy_CopyItemAtPath:(NSString *)path toPath:(NSString *)toPath error:(NSError **)error;

/** 大小 */
+ (CGFloat)ddy_FileSizeAtPath:(NSString *)path;

/** 本地音视频时长 */
+ (NSUInteger)ddy_DurationWithPath:(NSString *)path;

/** 录音临时存储 */
+ (NSString *)ddy_RecordPath;

/** SoundTouch转存 */
+ (NSString *)ddy_SoundTouchPath;

@end
