//
//  DDYVoiceTalkView.h
//  DDYProject
//
//  Created by LingTuan on 17/11/23.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDYVoiceTalkView : UIView

@property (nonatomic, copy) void (^changeVoiceBoxState) (DDYVoiceBoxState state);
@property (nonatomic, copy) void (^playBlock) (void);

+ (instancetype)viewWithFrame:(CGRect)frame;

@end
