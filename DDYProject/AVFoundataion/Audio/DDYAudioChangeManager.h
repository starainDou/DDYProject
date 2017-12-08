//
//  DDYAudioChangeManager.h
//  DDYProject
//
//  Created by LingTuan on 17/11/28.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct AudioChangeConfig {
    int sampleRate;     // 采样率 <这里使用8000 原因: 录音是采样率:8000>
    int tempoChange;    // 速度 <变速不变调> [-50, 100]
    int pitch;          // 音调 <男:-8 女:8> [-12, 12]
    int rate;           // 声音速率 [-50, 100]
} DDYAudioChangeConfig;

@interface DDYAudioChangeManager : NSOperation
{
    id target;
    SEL action;
    NSData *data;
    DDYAudioChangeConfig config;
}

+ (id)changeConfig:(DDYAudioChangeConfig)config audioData:(NSData *)data target:(id)target action:(SEL)action;

@end
