//
//  DDYVoiceTalkView.m
//  DDYProject
//
//  Created by LingTuan on 17/11/23.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import "DDYVoiceTalkView.h"
#import "DDYVoiceButton.h"
#import "DDYVoiceStateView.h"

static CGFloat const maxScale = 0.45;

@interface DDYVoiceTalkView ()<DDYAudioManagerDelegate>
/** 状态与振幅 */
@property (nonatomic, strong) DDYVoiceStateView *stateView;
/** 录音按钮 */
@property (nonatomic, strong) DDYVoiceButton *recordBtn;
/** 播放按钮 */
@property (nonatomic, strong) DDYVoiceButton *playBtn;
/** 取消按钮 */
@property (nonatomic, strong) DDYVoiceButton *cancelBtn;
/** 弧线图片 */
@property (nonatomic, strong) UIImageView *voiceArcView;

@end

@implementation DDYVoiceTalkView

+ (instancetype)viewWithFrame:(CGRect)frame {
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.stateView];
        [self addSubview:self.voiceArcView];
        [self addSubview:self.recordBtn];
        [self addSubview:self.playBtn];
        [self addSubview:self.cancelBtn];
    }
    return self;
}

#pragma mark 状态显示
- (DDYVoiceStateView *)stateView {
    if (!_stateView) {
        _stateView = [DDYVoiceStateView viewWithFrame:DDYRect(0, 10, self.ddy_w, 50)];
    }
    return _stateView;
}

#pragma mark 按住显示的曲线
- (UIImageView *)voiceArcView {
    if (!_voiceArcView) {
        _voiceArcView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DDYVoice.bundle/aio_voice_line"]];
        _voiceArcView.hidden = YES;
    }
    return _voiceArcView;
}

#pragma mark 录音按钮
- (DDYVoiceButton *)recordBtn {
    if (!_recordBtn) {
        _recordBtn = [DDYVoiceButton btnWithBgImgN:@"DDYVoice.bundle/aio_voice_button_nor"
                                            bgImgS:@"DDYVoice.bundle/aio_voice_button_press"
                                              imgN:@"DDYVoice.bundle/aio_voice_button_icon"
                                              imgS:@"DDYVoice.bundle/aio_voice_button_icon"
                                             frame:DDYRect(0, self.stateView.ddy_bottom, 0, 0)
                                        isMicPhone:YES];
        // 手指按下
        [_recordBtn addTarget:self action:@selector(starRecorde:) forControlEvents:UIControlEventTouchDown];
        // 手指松开
        [_recordBtn addTarget:self action:@selector(sendRecorde:) forControlEvents:UIControlEventTouchUpInside];
        // 手势拖动
        [_recordBtn addPanGestureTarget:self action:@selector(pan:)];
        _recordBtn.ddy_centerX = self.ddy_w/2.;
        _voiceArcView.center = _recordBtn.center;
    }
    return _recordBtn;
}

#pragma mark 播放按钮
- (DDYVoiceButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [DDYVoiceButton btnWithBgImgN:@"DDYVoice.bundle/aio_voice_operate_nor"
                                          bgImgS:@"DDYVoice.bundle/aio_voice_operate_press"
                                            imgN:@"DDYVoice.bundle/aio_voice_operate_listen_nor"
                                            imgS:@"DDYVoice.bundle/aio_voice_operate_listen_press"
                                           frame:DDYRect(35, self.stateView.ddy_bottom+10, 0, 0)
                                      isMicPhone:NO];
        _playBtn.hidden = YES;
    }
    return _playBtn;
}

#pragma mark 取消按钮
- (DDYVoiceButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [DDYVoiceButton btnWithBgImgN:@"DDYVoice.bundle/aio_voice_operate_nor"
                                            bgImgS:@"DDYVoice.bundle/aio_voice_operate_press"
                                              imgN:@"DDYVoice.bundle/aio_voice_operate_delete_nor"
                                              imgS:@"DDYVoice.bundle/aio_voice_operate_delete_press"
                                             frame:DDYRect(self.ddy_w-35, self.stateView.ddy_bottom+10, 0, 0)
                                        isMicPhone:NO];
        _cancelBtn.ddy_right = self.ddy_w-35;
        _cancelBtn.hidden = YES;
    }
    return _cancelBtn;
}

#pragma mark - 事件处理
#pragma mark 拖拽
- (void)pan:(UIPanGestureRecognizer *)pan {
    if (!self.recordBtn.isSelected) return;
    CGPoint point = [pan locationInView:self];
    __weak __typeof__ (self)weakSelf = self;
    if (pan.state == UIGestureRecognizerStateBegan) {
        
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        if (point.x < self.ddy_w/2) { // 触摸左边
            [self transformBtn:self.playBtn point:point callBack:^(BOOL isContain) {
                weakSelf.stateView.voiceState = isContain ? DDYVoiceStateListen : DDYVoiceStateRecording;
            }];
        } else {
            [self transformBtn:self.cancelBtn point:point callBack:^(BOOL isContain) {
                weakSelf.stateView.voiceState = isContain ? DDYVoiceStateCancel : DDYVoiceStateRecording;
            }];
        }
    } else { // 松开手指or手势cancel
        [[DDYAudioManager sharedManager] ddy_StopRecord];
        [self.stateView endRecord];
        if (self.stateView.voiceState == DDYVoiceStateListen) { DDYInfoLog(@"试听");
            if (self.playBlock) self.playBlock();
        } else if (self.stateView.voiceState == DDYVoiceStateCancel) { DDYInfoLog(@"取消发送");
            [[DDYAudioManager sharedManager] ddy_DeleteRecord];
            if (self.changeVoiceBoxState) self.changeVoiceBoxState(DDYVoiceBoxStateDefault);
        } else {
            if (self.changeVoiceBoxState) self.changeVoiceBoxState(DDYVoiceBoxStateDefault);
        }
        
        self.recordBtn.selected = NO;
        self.playBtn.selected = NO;
        self.cancelBtn.selected = NO;
        
        self.playBtn.hidden = YES;
        self.cancelBtn.hidden = YES;
        self.voiceArcView.hidden = YES;
        self.playBtn.bgLayer.transform = CATransform3DIdentity;
        self.cancelBtn.bgLayer.transform = CATransform3DIdentity;
        
        self.stateView.voiceState = DDYVoiceStateDefault;
    }
    
}

#pragma mark 按钮形变及动画
- (void)transformBtn:(DDYVoiceButton *)btn point:(CGPoint)point callBack:(void(^)(BOOL isContain))callBack {
    CGFloat distance = sqrt(pow((btn.center.x - btn.center.x), 2) + pow((point.y - point.y), 2));
    CGFloat d = btn.ddy_w*3/4;
    CGFloat x = distance*maxScale/d;
    CGFloat scale = 1-x;
    scale = scale>0 ? scale>maxScale ? maxScale : scale :0;
    CGPoint p = [self.layer convertPoint:point toLayer:btn.bgLayer];
    BOOL isContain = [btn.bgLayer containsPoint:p];
    btn.selected = isContain;
    btn.bgLayer.transform = CATransform3DMakeScale(1+(isContain ? maxScale : scale), 1+(isContain ? maxScale : scale), 1);
    if (callBack) callBack(isContain);
}

#pragma mark 曲线动画
- (void)animationArcView {
    self.voiceArcView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    self.voiceArcView.hidden = NO;
    [UIView animateWithDuration:0.15 animations:^{
        self.voiceArcView.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark 播放和取消按钮动画
- (void)animationPlayAndCancelBtn {
    [self animationStarPoint:CGPointMake(self.playBtn.ddy_centerX+20,   self.playBtn.ddy_centerY)   endPoint:self.playBtn.center   view:self.playBtn];
    [self animationStarPoint:CGPointMake(self.cancelBtn.ddy_centerX-20, self.cancelBtn.ddy_centerY) endPoint:self.cancelBtn.center view:self.cancelBtn];
    
}

- (void)animationStarPoint:(CGPoint)starP endPoint:(CGPoint)endP view:(UIView *)view {
    view.hidden = NO;
    CABasicAnimation *positionAnim = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnim.fromValue = [NSValue valueWithCGPoint:starP];
    positionAnim.toValue = [NSValue valueWithCGPoint:endP];
    positionAnim.duration = 0.15;
    
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.toValue = @1;
    opacityAnim.fromValue = @0;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[positionAnim,opacityAnim];
    animationGroup.duration = 0.15;
    [view.layer addAnimation:animationGroup forKey:nil];
}

#pragma mark 开始录音
- (void)starRecorde:(DDYVoiceButton *)sender {
    [DDYAudioManager sharedManager].delegate = self;
    sender.selected = YES;
    // 设置状态 隐藏小圆点和三个标签
    if (self.changeVoiceBoxState) self.changeVoiceBoxState(DDYVoiceBoxStateRecord);
    [UIView animateWithDuration:0.1 animations:^{
        self.recordBtn.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.05 animations:^{
            self.recordBtn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [[DDYAudioManager sharedManager] ddy_StartRecordAtPath:[DDYFileTool ddy_RecordPath]];
        }];
        
    }];
}

#pragma mark 手指松开--发送录音
- (void)sendRecorde:(DDYVoiceButton *)sender {
    NSTimeInterval t = [DDYAudioManager sharedManager].isRecording ? 0 : 0.3;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(t * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.selected = NO;
        self.playBtn.hidden = YES;
        self.cancelBtn.hidden = YES;
        self.voiceArcView.hidden = YES;
        self.stateView.voiceState = DDYVoiceStateDefault;
        [[DDYAudioManager sharedManager] ddy_StopRecord];
        [self.stateView endRecord];
        // 设置状态 显示小圆点和三个标签
        if (self.changeVoiceBoxState) self.changeVoiceBoxState(DDYVoiceBoxStateDefault);
        t == 0 ? NSLog(@"发送录音111111") : NSLog(@"录音时间太短");
    });
}

#pragma mark DDYAudioManagerDelegate 录音状态 -1出错 0准备 1录音中
- (void)ddy_AudioRecordState:(NSInteger)state {
    if (state == -1) {
        self.stateView.voiceState = DDYVoiceStateDefault;
    } else if (state == 0) {
        self.stateView.voiceState = DDYVoiceStatePrepare;
    } else if (state == 1) {
        self.stateView.voiceState = DDYVoiceStateRecording;
        [self animationPlayAndCancelBtn];
        [self animationArcView];
        [self.stateView startRecord];
    }
}

@end
