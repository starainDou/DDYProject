//
//  DDYAudioManager.h
//  DDYProject
//
//  Created by LingTuan on 17/9/28.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import <Foundation/Foundation.h>

//----------------------------- 后缀 -----------------------------//
static NSString *const ddyExt_WAV = @"wav";
static NSString *const ddyExt_AMR = @"amr";
static NSString *const ddyExt_CAF = @"caf";
static NSString *const ddyExt_MP3 = @"mp3";

//----------------------------- 录音播放代理 -----------------------------//
@protocol DDYAudioManagerDelegate <NSObject>
@optional
/** 录音状态 -1出错 0准备 1录音中 */
- (void)ddy_AudioRecordState:(NSInteger)state;
/** 声音播放完成 */
- (void)ddy_AudioPlayDidFinish;

@end

//----------------------------- 录制、播放 -----------------------------//
@interface DDYAudioManager : NSObject
/** 代理 */
@property (nonatomic, weak) id <DDYAudioManagerDelegate> delegate;

/** 单例对象 */
+ (instancetype)sharedManager;

/** 录音设置 */
@property (nonatomic, strong) NSDictionary *recordSetting;
/** 开始录音 */
- (void)ddy_StartRecordAtPath:(NSString *)path;
/** 是否正在录音 */
@property (nonatomic, assign, readonly) BOOL isRecording;
/** 结束录音 */
- (void)ddy_StopRecord;
/** 删除录音 */
- (void)ddy_DeleteRecord;
/** 获取录制分贝值 */
- (float)ddy_RecordLevels;

/** 播放模式 默认扬声器AVAudioSessionCategoryPlayback */
@property (nonatomic, strong) NSString *audioCategory;
/** 播放进度 */
@property (nonatomic, assign, readonly) float palyProgress;
/** 播放音量 0-1 */
@property (nonatomic, assign) CGFloat volume;
/** 播放本地音频 */
- (void)ddy_PlayAudio:(NSString *)path;
/** 暂停播放 */
- (void)ddy_PauseAudio;
/** 恢复播放 */
- (void)ddy_ReplayAudio;
/** 停止播放 */
- (void)ddy_StopAudio;
/** 获取播放分贝值 */
- (float)ddy_PlayLevels;

@end
