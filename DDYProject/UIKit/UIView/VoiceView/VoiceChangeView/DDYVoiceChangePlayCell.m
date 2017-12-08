//
//  DDYVoiceChangePlayCell.m
//  DDYProject
//
//  Created by LingTuan on 17/11/27.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import "DDYVoiceChangePlayCell.h"
#import "DDYRecordModel.h"

//------------------------------- 模型 -------------------------------//
@implementation DDYVoiceChangeModel

+ (id)modelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (id)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.title = dict[@"title"];
        self.pitch = dict[@"pitch"];
        self.imgName = dict[@"imgName"];
    }
    return self;
}

@end

//------------------------------- cell -------------------------------//
@interface DDYVoiceChangePlayCell ()
/** 播放时振幅计时器 */
@property (nonatomic, strong) CADisplayLink *playTimer;
/** 头像播放按钮 */
@property (nonatomic, strong) DDYButton *playButton;
/** 底部标签按钮 */
@property (nonatomic, strong) DDYButton *titleButton;
/** 当前振幅数组 */
@property (nonatomic, strong) NSMutableArray *currentLevels;
/** 振幅图层 */
@property (nonatomic, strong) CAShapeLayer *levelLayer;
/** 振幅path */
@property (nonatomic, strong) UIBezierPath *levelPath;
/** 录音时长标签 */
@property (nonatomic, strong) UILabel *timeLabel;
/** 环形进度条 */
@property (nonatomic, strong) CAShapeLayer *circleLayer;
/** 录音播放计时器 */
@property (nonatomic, strong) NSTimer *audioTimer;
/** 录音时长 */
@property (nonatomic, assign) NSInteger duration;

@end

@implementation DDYVoiceChangePlayCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:DDY_White];
        [self addSubview:self.playButton];
    }
    return self;
}

#pragma mark 振幅数组
- (NSMutableArray *)currentLevels {
    if (!_currentLevels) {
        _currentLevels = [NSMutableArray arrayWithArray:@[@0.05,@0.05,@0.05,@0.05,@0.05,@0.05]];
    }
    return _currentLevels;
}

- (DDYButton *)playButton {
    if (!_playButton) {
        _playButton = DDYButtonNew.btnImageS(voiceImg(@"effectS")).btnImageH(voiceImg(@"effectP")).btnFrame(0,0,60,60).btnAction(self,@selector(playAudio));
        _playButton.center = CGPointMake(self.ddy_w/2, self.ddy_h/2 - 10);
    }
    return _playButton;
}

- (DDYButton *)titleButton {
    if (!_titleButton) {
        UIImage *image = [UIImage imageNamed:@"DDYVoice.bundle/textSelect"];
//        _titleButton = DDYButtonNew
    }
    return _titleButton;
}

- (void)startAudioTimer {
    if (_audioTimer) [_audioTimer invalidate];
    self.audioTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(addSeconded) userInfo:nil repeats:YES];
}

- (void)addSeconded {
    if (_duration == [DDYRecordModel shareInstance].duration) {
        [_audioTimer invalidate];
    } else {
        _duration++;
//        [self updateTimeLabel];
    }
}

#pragma mark 事件响应
- (void)playAudio {
    self.titleButton.selected = !self.titleButton.selected;
    self.playButton.selected = !self.playButton.selected;
    __weak __typeof__ (self)weakSelf = self;
    if (self.playButton.selected) {
        
    } else {
        
    }
}

#pragma mark 准备播放


#pragma mark 


#pragma mark 圆弧进度
//- (void)


@end
