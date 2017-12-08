//
//  DDYFileTool.m
//  FireFly
//
//  Created by LingTuan on 17/9/26.
//  Copyright © 2017年 NAT. All rights reserved.
//

#import "DDYFileTool.h"

@implementation DDYFileTool

#pragma mark 是否存在
+ (BOOL)ddy_FileExistsAtPath:(NSString *)path {
    return [DDYFileManager fileExistsAtPath:path];
}

#pragma mark 创建
+ (BOOL)ddy_CreateDirectory:(NSString *)path error:(NSError **)error {
    if ([DDYFileTool ddy_FileExistsAtPath:path]) {
        return YES;
    } else {
        return [DDYFileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:error];
    }
}

#pragma mark 删除
+ (BOOL)ddy_RemoveItemAtPath:(NSString *)path error:(NSError **)error {
    return [DDYFileManager removeItemAtPath:path error:error];
}

#pragma mark 移动
+ (BOOL)ddy_MoveItemAtPath:(NSString *)path toPath:(NSString *)toPath error:(NSError **)error {
    return [DDYFileManager moveItemAtPath:path toPath:toPath error:error];
}

#pragma mark 复制
+ (BOOL)ddy_CopyItemAtPath:(NSString *)path toPath:(NSString *)toPath error:(NSError **)error {
    return [DDYFileManager copyItemAtPath:path toPath:path error:error];
}

#pragma mark 大小
+ (CGFloat)ddy_FileSizeAtPath:(NSString *)path {
    unsigned long long length = [[DDYFileManager attributesOfItemAtPath:path error:nil] fileSize];
    return length/1024.0;
}

#pragma mark 本地音视频时长
+ (NSUInteger)ddy_DurationWithPath:(NSString *)path {
    if ([DDYFileTool ddy_FileExistsAtPath:path]) {
        AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:DDYURLStr(path) options:@{AVURLAssetPreferPreciseDurationAndTimingKey:@(NO)}];
        return urlAsset.duration.value / urlAsset.duration.timescale;
    }
    return 0;
}

#pragma mark 录音临时存储
+ (NSString *)ddy_RecordPath {
    NSString *tempPath = DDYStrFormat(@"%@%@", DDYPathDocument, @"/DDYTemp/");
    [self ddy_CreateDirectory:tempPath error:nil];
    return [tempPath stringByAppendingPathComponent:@"record.wav"];
}

#pragma mark SoundTouch转存 */
+ (NSString *)ddy_SoundTouchPath {
    NSString *tempPath = DDYStrFormat(@"%@%@", DDYPathDocument, @"/DDYTemp/");
    [self ddy_CreateDirectory:tempPath error:nil];
    return [tempPath stringByAppendingPathComponent:@"ddySoundTouch.wav"];
}

@end
