//
//  DDYAudioManager.m
//  DDYProject
//
//  Created by LingTuan on 17/9/28.
//  Copyright © 2017年 Starain. All rights reserved.
//

/**
 *  录音设置
 *  <1>AVNumberOfChannelsKey 通道数
 *  <2>AVSampleRateKey 采样率 一般用44100
 *  <3>AVLinearPCMBitDepthKey 比特率 一般设8或16或32
 *  <4>AVEncoderAudioQualityKey 质量
 *  <5>AVEncoderBitRateKey 比特采样率 一般是128000
 *
 *  meteringEnabled 音频检测,开启后updateMeters可以更新测量值
 */

#import "DDYAudioManager.h"

#define ALPHA 0.02f  // 音频振幅调解相对值 (越小振幅就越高)

@interface DDYAudioManager ()<AVAudioRecorderDelegate, AVAudioPlayerDelegate>
/** 录音器 */
@property (nonatomic, strong) AVAudioRecorder *recorder;
/** 播放器 */
@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation DDYAudioManager

#pragma mark - 单例对象

static DDYAudioManager *_instance;

+ (instancetype)sharedManager {
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

#pragma mark - 录音
#pragma mark 录音设置
- (NSDictionary *)recordSetting {
    if (!_recordSetting) {
        _recordSetting = @{AVSampleRateKey:@(8000), AVFormatIDKey:@(kAudioFormatLinearPCM), AVLinearPCMBitDepthKey:@(16), AVNumberOfChannelsKey:@(1)};
    }
    return _recordSetting;
}

#pragma mark 开始录音
- (void)ddy_StartRecordAtPath:(NSString *)path {
    _isRecording = YES;
    if ([self.delegate respondsToSelector:@selector(ddy_AudioRecordState:)]) [self.delegate ddy_AudioRecordState:0];
    [self ddy_StopRecord];
    [self ddy_StopAudio];
    [DDYAuthorityMaster audioAuthSuccess:^{
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        _recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL URLWithString:path] settings:self.recordSetting error:nil];
        _recorder.meteringEnabled = YES;
        _recorder.delegate = self;
        if ([_recorder prepareToRecord]) {
            [_recorder record];
            if ([self.delegate respondsToSelector:@selector(ddy_AudioRecordState:)]) [self.delegate ddy_AudioRecordState:1];
        } else {
            if ([self.delegate respondsToSelector:@selector(ddy_AudioRecordState:)]) [self.delegate ddy_AudioRecordState:-1];
        }
    } fail:^{
        if ([self.delegate respondsToSelector:@selector(ddy_AudioRecordState:)]) [self.delegate ddy_AudioRecordState:-1];
    } alertShow:YES];
}

#pragma mark 结束录音
- (void)ddy_StopRecord {
    if (_recorder.isRecording) {
        [_recorder stop];
        _isRecording = NO;
    }
}

#pragma mark 删除录音
- (void)ddy_DeleteRecord {
    [self ddy_StopRecord];
    [_recorder deleteRecording];
    _isRecording = NO;
}

#pragma mark 获取录制分贝值
- (float)ddy_RecordLevels {
    [_recorder updateMeters];
    double aveChannel = pow(10, (ALPHA * [_recorder averagePowerForChannel:0]));
    if (aveChannel <= 0.05f) aveChannel = 0.05f;
    if (aveChannel >= 1.0f)  aveChannel = 1.0f;
    return aveChannel;
}

#pragma mark - AVAudioRecorderDelegate

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    NSString *wavPath = [[_recorder url] path];
    // 音频转换
    NSString *amrPath = [[wavPath stringByDeletingPathExtension] stringByAppendingPathExtension:ddyExt_AMR];
    [VoiceConverter ConvertWavToAmr:wavPath amrSavePath:amrPath];
}

#pragma mark - 播放
#pragma mark 播放本地音频
- (void)ddy_PlayAudio:(NSString *)path {
    [self ddy_StopRecord];
    [self ddy_StopAudio];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
        _player.numberOfLoops = 0;
        _player.delegate = self;
        _player.meteringEnabled = YES;
        if ([_player prepareToPlay]) {
            [_player play];
        };
    }
}

#pragma mark 暂停播放
- (void)ddy_PauseAudio {
    if (_player && _player.isPlaying) {
        [_player pause];
    }
}

#pragma mark 停止播放 
- (void)ddy_StopAudio {
    if (_player && _player.isPlaying) {
        [_player stop];
    }
}

#pragma mark 恢复播放
- (void)ddy_ReplayAudio {
    if (_player) {
        [_player play];
    }
}

#pragma mark 播放完成
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [self ddy_StopAudio];
    if ([self.delegate respondsToSelector:@selector(ddy_AudioPlayDidFinish)]) {
        [self.delegate ddy_AudioPlayDidFinish];
    }
}

#pragma mark 设置播放模式
- (void)setAudioCategory:(NSString *)audioCategory {
    _audioCategory = audioCategory;
    [[AVAudioSession sharedInstance] setCategory:audioCategory error:nil];
}

#pragma mark 设置音量
- (void)setVolume:(CGFloat)volume {
    if (_player) {
        _player.volume = volume;
    }
}

#pragma mark 播放进度
- (float)palyProgress {
    return self.player.currentTime / self.player.duration;
}

#pragma mark 获取播放分贝值
- (float)ddy_PlayLevels {
    [_player updateMeters];
    double aveChannel = pow(10, (ALPHA * [_player averagePowerForChannel:0]));
    if (aveChannel <= 0.05f) aveChannel = 0.05f;
    if (aveChannel >= 1.0f)  aveChannel = 1.0f;
    return aveChannel;
}

- (void)dealloc {
    [self ddy_StopRecord];
    [self ddy_StopAudio];
}

@end
