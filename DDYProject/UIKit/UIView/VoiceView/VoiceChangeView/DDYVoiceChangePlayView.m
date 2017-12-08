//
//  DDYVoiceChangePlayView.m
//  DDYProject
//
//  Created by LingTuan on 17/11/27.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import "DDYVoiceChangePlayView.h"
#import "DDYRecordModel.h"
#import "DDYAudioChangeManager.h"

static inline UIImage* strectchImg(NSString *imgName) { return [voiceImg(imgName) resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 1, 1)];}

@interface DDYVoiceChangePlayView ()
/** 取消按钮 */
@property (nonatomic, strong) DDYButton *cancelBtn;
/** 发送按钮 */
@property (nonatomic, strong) DDYButton *sendBtn;
/** 声音转换线程 */
@property (nonatomic, strong) NSOperationQueue *soundTouchQueue;

@end

@implementation DDYVoiceChangePlayView

+ (instancetype)viewWithFrame:(CGRect)frame {
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSendBtnAndCancelBtn];
    }
    return self;
}


#pragma mark 声音转换线程
- (NSOperationQueue *)soundTouchQueue {
    if (!_soundTouchQueue) {
        _soundTouchQueue = [[NSOperationQueue alloc] init];
        _soundTouchQueue.maxConcurrentOperationCount = 1;
    }
    return _soundTouchQueue;
}

- (void)setupSendBtnAndCancelBtn {
    _cancelBtn = DDYButtonNew.btnFrame(0,self.ddy_h-40,self.ddy_w/2,40).btnTitleN(DDYLocalStr(@"Cancel")).btnTitleColorN(kSelectColor);
    _cancelBtn.btnFont(DDYFont(17)).btnAction(self,@selector(btnClick:)).btnBgImageN(strectchImg(@"PlayCancelN"));
    _cancelBtn.btnBgImageH(strectchImg(@"PlayCancelH")).btnSuperView(self);
    
    _sendBtn = DDYButtonNew.btnFrame(self.ddy_w/2,self.ddy_h-40,self.ddy_w/2,40).btnTitleN(DDYLocalStr(@"Send")).btnTitleColorN(kSelectColor);
    _sendBtn.btnFont(DDYFont(17)).btnAction(self,@selector(btnClick:)).btnBgImageN(strectchImg(@"PlaySendN"));
    _sendBtn.btnImageH(strectchImg(@"PlaySendH")).btnSuperView(self);
}

- (void)btnClick:(DDYButton *)sender {
    
}

#pragma mark 变声功能
- (void)soundChangeWithPitch:(int)pitch {
    NSData *data = [NSData dataWithContentsOfFile:[DDYFileTool ddy_RecordPath]];
    DDYAudioChangeConfig config;
    config.sampleRate = 11025;
    config.tempoChange = 0;
    config.pitch = pitch;
    config.rate = 0;  
    
    DDYAudioChangeManager *change = [DDYAudioChangeManager changeConfig:config audioData:data target:self action:@selector(playChange)];
    [_soundTouchQueue cancelAllOperations];
    [_soundTouchQueue addOperation:change];
}

- (void)playChange {
    [[DDYAudioManager sharedManager] ddy_PlayAudio:[DDYFileTool ddy_SoundTouchPath]];
}

@end
