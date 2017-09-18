//
//  DDYCameraView.h
//  DDYProject
//
//  Created by LingTuan on 17/8/16.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DDYCameraType) {
    DDYCameraTypePhoto = 0,        // 拍照功能
    DDYCameraTypeVideo = 1,        // 录制功能
    DDYCameraTypeGif   = 2,        // 录制gif
};

typedef NS_ENUM(NSInteger, DDYCameraMask) {
    DDYCameraMaskNone,         // 无遮罩层
    DDYCameraMaskCircle,       // 圆形遮罩
    DDYCameraMaskSquare,       // 方形遮罩
};

typedef NS_ENUM(NSInteger, DDYFlashMode) {
    DDYFlashModeOff,        // 关闭
    DDYFlashModeOn,         // 打开
    DDYFlashModeAuto,       // 自动
};

@interface DDYCameraView : UIView

/** 遮罩样式 默认无 */
@property (nonatomic, assign) DDYCameraMask cameraMask;
/** 相机类型 默认拍照 */
@property (nonatomic, assign) DDYCameraType cameraType;
/** 闪光灯模式 */
@property (nonatomic, assign) DDYFlashMode flashMode;
/** 拍照数量 默认 1张 */
@property (nonatomic, assign) NSInteger photoNumber;
/** 拍照间隔 默认0.1s */
@property (nonatomic, assign) CGFloat takePhotoDelayTime;
/** 拍照声音 默认有声音 */
@property (nonatomic, assign) BOOL isSound;
/** 录制时长 默认 15s */
@property (nonatomic, assign) NSInteger videoLength;

/** 切换摄像头 block优先 */
@property (nonatomic, copy) void (^toggleBlock)();
/** 闪光灯模式 block优先 */
@property (nonatomic, copy) void (^flashBlock)();
/** 点击返回  block优先 */
@property (nonatomic, copy) void (^backBlock)();
/** 点击拍照  block优先 */
@property (nonatomic, copy) void (^takeBlock)();
/** 录制事件  block优先 */

@end
