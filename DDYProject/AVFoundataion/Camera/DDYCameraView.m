//
//  DDYCameraView.m
//  DDYProject
//
//  Created by LingTuan on 17/8/16.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import "DDYCameraView.h"
#import "DDYCameraManager.h"

#define TextColor DDYRGBA(255, 204, 26, 1)

@interface DDYCameraView ()

/** 上部背景视图 */
@property (nonatomic, strong) UIView *topBgView;
/** 下部背景视图 */
@property (nonatomic, strong) UIView *bottomBgView;
/** 返回按钮 */
@property (nonatomic, strong) UIButton *backBtn;
/** 切换前后摄像头按钮 */
@property (nonatomic, strong) UIButton *toggleBtn;
/** 闪光灯/补光灯按钮 */
@property (nonatomic, strong) UIButton *flashBtn;
/** 闪光灯选择 */
@property (nonatomic, strong) UIView   *flashView;
/** 遮罩视图 */
@property (nonatomic, strong) UIView   *holeView;
/** 拍照/录制 */
@property (nonatomic, strong) UIButton *takeBtn;
/** 重置按钮 */
@property (nonatomic, strong) UIButton *resetBtn;
/** 使用按钮 */
@property (nonatomic, strong) UIButton *useBtn;
/** 聚焦框 */
@property (nonatomic, strong) UIImageView *focusCursor;

@end

@implementation DDYCameraView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self prepare];
        [self setupContentView];
        [self layoutContentView];
    }
    return self;
}

#pragma mark 默认属性
- (void)prepare
{
    _cameraMask = DDYCameraMaskNone;
    _cameraType = DDYCameraTypePhoto;
    _photoNumber = 1;
    _takePhotoDelayTime = 0.1;
    _videoLength = 0;
    _isSound = YES;
}

- (void)setupContentView {
    [self setupMidView];
    [self setupTopView];
    [self setupBottomView];
}

- (void)setupTopView
{
    _topBgView = [[UIView alloc] init];
    _topBgView.backgroundColor = DDYColor(10, 10, 10, 0.7);
    [self addSubview:_topBgView];
    
    _backBtn   = [self btnTitle:@"返回" img:@"" superView:_topBgView action:@selector(handleBack:)]; //back_white
    _toggleBtn = [self btnTitle:@"前后" img:@"" superView:_topBgView action:@selector(handleToggle:)];
    _flashBtn  = [self btnTitle:@"开关" img:@"" superView:_topBgView action:@selector(handleFlash:)];
}

- (void)setupMidView
{

}

- (void)setCameraMask:(DDYCameraMask)cameraMask {
    // 镂空
    _cameraMask = cameraMask;
    if (_cameraMask == DDYCameraMaskCircle) {
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, nil, self.bounds);
        CGPathAddArc(path, nil, DDYSCREENW/2.0, 240, 120, 0, 2*M_PI, 0);
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = path;
        shapeLayer.fillRule = kCAFillRuleEvenOdd;
        shapeLayer.fillColor = DDYColor(0, 0, 0, 0.4).CGColor;
        [self.layer addSublayer:shapeLayer];
    } else if (_cameraMask == DDYCameraMaskSquare) {
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, nil, self.bounds);
        CGPathAddRect(path, nil, CGRectMake(DDYSCREENW/6.0, 120, DDYSCREENW*2/3.0, DDYSCREENW*2/3.0));
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = path;
        shapeLayer.fillRule = kCAFillRuleEvenOdd;
        shapeLayer.fillColor = DDYColor(0, 0, 0, 0.4).CGColor;
        [self.layer addSublayer:shapeLayer];
    }
    [self bringSubviewToFront:_topBgView];
    [self bringSubviewToFront:_bottomBgView];
}

- (void)setupBottomView
{
    _bottomBgView = [[UIView alloc] init];
    _bottomBgView.backgroundColor = DDYColor(10, 10, 10, 0.7);
    [self addSubview:_bottomBgView];
    
    _takeBtn = [self btnTitle:@"拍照" img:@"" superView:_bottomBgView action:@selector(handleTake:)];
}

- (void)layoutContentView {
    _topBgView.frame = CGRectMake(0, 0, DDYSCREENW, 64);
    _backBtn.frame = CGRectMake(12, 12, 40, 40);
    _toggleBtn.frame = CGRectMake(DDYSCREENW/2.0-20, 12, 40, 40);
    _flashBtn.frame = CGRectMake(DDYSCREENW-52, 12, 40, 40);
    
    _bottomBgView.frame = CGRectMake(0, DDYSCREENH-120, DDYSCREENW, 120);
    _takeBtn.frame = CGRectMake(DDYSCREENW/2.0-30, 30, 60, 60);
}

//#pragma mark - init view
//- (void)setupNavBar
//{
//    _backBtn   = [self btnFrame:CGRectMake(12, 12, 40, 40)               title:nil img:@"Back"          superView:self.view action:@selector(backBtnClick)];
//    _toggleBtn = [self btnFrame:CGRectMake(SWScreenW/2.0-20, 14, 40, 40) title:nil img:@"CameraToggle"  superView:self.view action:@selector(toggleBtnClick:)];
//    _flashBtn  = [self btnFrame:CGRectMake(SWScreenW-52, 12, 40, 40)     title:nil img:@"CameraFlashOn" superView:self.view action:@selector(flashClick:)];
//    _flashView = [[UIView alloc] initWithFrame:CGRectMake(0, 12, SWScreenW-52, 40)];
//    [self.view addSubview:_flashView];
//    CGFloat tmpWidth = (SWScreenW-104)/3.0;
//    [self btnFrame:CGRectMake(52+0*tmpWidth, 0, tmpWidth, 40) title:OffText  img:nil superView:_flashView action:@selector(flashOffClick:)];
//    [self btnFrame:CGRectMake(52+1*tmpWidth, 0, tmpWidth, 40) title:OnText   img:nil superView:_flashView action:@selector(flashOnClick:)];
//    [self btnFrame:CGRectMake(52+2*tmpWidth, 0, tmpWidth, 40) title:AutoText img:nil superView:_flashView action:@selector(flashAutoClick:)];
//    _flashView.backgroundColor = [UIColor blackColor];
//    _flashView.hidden = YES;
//}
//- (void)setContainerView
//{
//    _viewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SWScreenW, SWScreenH - 174)];
//    [self.view addSubview:_viewContainer];
//    
//    _holeView = [[HollowView alloc] initWithFrame:_viewContainer.frame];
//    [self.view insertSubview:_holeView aboveSubview:_viewContainer];
//}
//- (void)setupToolBar
//{
//    _takeBtn = [self btnFrame:CGRectMake(SWScreenW/2.0-30, SWScreenH-110, 60, 110) title:nil img:@"CameraTake" superView:self.view action:@selector(takeBtnClick:)];
//    _resetBtn = [self btnFrame:CGRectMake(26, SWScreenH-45, 50, 25) title:ResetText img:nil superView:self.view action:@selector(resetBtnClick:)];
//    _resetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    _useBtn = [self btnFrame:CGRectMake(SWScreenW-86, SWScreenH-45, 60, 25) title:UseText img:nil superView:self.view action:@selector(useBtnClick:)];
//    _resetBtn.hidden = YES;
//    _useBtn.hidden = YES;
//}
#pragma mark 创建按钮
- (UIButton *)btnTitle:(NSString *)title img:(NSString *)img superView:(UIView *)superView action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (![img ddy_blankString]) [button setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:TextColor forState:UIControlStateNormal];
        button.titleLabel.font = DDYFont(16);
    }
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:button];
    return button;
}

#pragma mark - 事件处理
#pragma mark 返回
- (void)handleBack:(UIButton *)sender {
//    [[self currentViewController].navigationController popViewControllerAnimated:YES];
    if (self.backBlock) {
        self.backBlock();
    }
}

#pragma mark 切换摄像头
- (void)handleToggle:(UIButton *)sender {
    if (self.toggleBlock) {
        self.toggleBlock();
    }
}

#pragma mark 切换闪光灯模式
- (void)handleFlash:(UIButton *)sender
{
    if (_cameraType == DDYCameraTypeVideo)
    {
        
    }
    else
    {
        
    }
}

#pragma mark 拍照
- (void)handleTake:(UIButton *)sender {
    if (self.takeBlock) {
        self.takeBlock();
    }
}

#pragma mark - 私有方法
#pragma mark 获取当前控制器
- (UIViewController *)currentViewController
{
    UIResponder *next = self.nextResponder;
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    } while (next != nil);
    
    return nil;
}

@end
